extends CanvasLayer

# ChatGPT Init
var host = "https://api.openai.com"
var path = "/v1/chat/completions"
var url = host+path
var temp : float = 0.5  # How varied the responses are
var max_tokens : int = 200  # Not too long
var stream : bool = true
var api_key : String = OS.get_environment("OPENAI_API_KEY")
var headers = ["Content-type: application/json", 
	"Authorization: Bearer " + api_key]
var model : String = "gpt-3.5-turbo"
# var messages = []  # Only needed for conversations
var request : HTTPRequest
signal message_processed(message)
var message_ai = preload("res://Scenes/chat_message_ai.tscn")
signal stream_busy(is_busy:bool)
var npc_response_ongoing : bool = false

var stream_reply_buffer: String
var stream_reply_final: String
var stream_used_status_ai_message = false
var stream_ongoing = false

# Called when the node enters the scene tree for the first time.
func _ready():#
	# Instantiate HTTP request to GPT
	request = HTTPRequest.new()
	add_child(request)
	#request.connect("request_completed", _on_request_completed)
	#message_processed.connect(_on_request_completed)
	if stream:
		$HTTPSSEClient.new_sse_event.connect(_on_new_sse_event)


func _on_new_sse_event(partial_reply : Array, ai_status_message : ChatMessageAI):
	for string in partial_reply:
		if string == "[DONE]":
			$HTTPSSEClient.close_connection()
			# Whatever is reamining in the buffer, if any, must be sent to the 
			# RichTextLabel and voice ai service
			stream_ongoing = false
			
			if stream_reply_buffer.length() > 0:
				stream_reply_final += stream_reply_buffer
				#_inject_message_from_stream(ai_status_message, stream_reply_buffer) 
				# We reset the buffer
				stream_reply_buffer = ""
				
			print("Response:\n\n", stream_reply_final)
			# We append the whole message to our internal chat
			#chat.append({"role": "assistant", "content":stream_reply_final})
			# We reset the reply, ready for the next stream
			stream_reply_final = ""
			stream_used_status_ai_message = false
			await get_tree().create_timer(4).timeout 
			get_node("SpeechFrame/TextMargins/ChatMessageAI").set_text("")
			await get_tree().create_timer(2).timeout 
			DialogueDatabase.NPC_text = ""
			npc_response_ongoing = false
			
		elif string == "[EMPTY DELTA]":
			pass
		elif string == "[ERROR]":
			$HTTPSSEClient.close_connection()
			stream_ongoing = false
			# Whatever is reamining in the buffer, if any, must be sent to the 
			# RichTextLabel and voice ai service
			if stream_reply_buffer.length() > 0:
				stream_reply_final += stream_reply_buffer
				#_inject_message_from_stream(ai_status_message, stream_reply_buffer) 
				# We reset the buffer and the reply
				stream_reply_buffer = ""
			stream_reply_final = ""
			stream_used_status_ai_message = false
		else:
			# We process the partial reply
			stream_reply_buffer += string
			if DialogueDatabase.NPC or npc_response_ongoing:
				if stream_reply_buffer != "":
#					var npcNode = load("res://Scenes/NPC/shopkeeper.gd").new()
#					npcNode._update_npc_text(stream_reply_buffer)
					DialogueDatabase.NPC_text = stream_reply_buffer
			else:
				get_node("SpeechFrame/TextMargins/ChatMessageAI").set_text(stream_reply_buffer)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if get_node("SpeechFrame/TextMargins/ChatMessageAI").get_text() == "":
		get_node("SpeechFrame").hide()
	else:
		get_node("SpeechFrame").show()
	

func _on_gd_gpt_pressed():	
	# var prompt : String = get_node("TextEdit").text
	if DialogueDatabase.NPC:
		npc_response_ongoing = true
	# Prompt variables
	
	### NPC VARIABLES ###
	var NPC : String = "a tavern keep"
	var NPC2: String = "An adventurer just walked into your tavern."
	var npc_mood: String = ""
	if(DialogueDatabase.npc_mood == 0):
		npc_mood = "Happy"
	if(DialogueDatabase.npc_mood == 1):
		npc_mood = "Sad"
	if(DialogueDatabase.npc_mood == 2):
		npc_mood = "Stressed"
	if(DialogueDatabase.npc_mood == 3):
		npc_mood = "Energetic"
	if(DialogueDatabase.npc_mood == 4):
		npc_mood = "Angry"
	if(DialogueDatabase.npc_mood == 5):
		npc_mood = "Sarcastic"
	var NPC3 : String = ""
	### END NPC VARIABLES ###
	
	
	### ADVENTURER VARIABLES ###
	var MC : String =  "an adventurer"
	var apple : String = str(DialogueManager.get_context("total_apple"))
	var banana : String = str(DialogueManager.get_context("total_banana"))
	var watermelon : String = str(DialogueManager.get_context("total_watermelon"))
	var hunger : String = str(DialogueManager.get_context("hunger"))
	var hp : String = str(DialogueManager.get_context("health"))
	var mood : String = "exhausted"
	var extra: String = ""
	### END ADVENTURER VARIABLES ###
	
	### Weather ###
	var weather: String = ""
	if(DialogueDatabase.rainState == 0):
		weather = "Sunny"
	if(DialogueDatabase.rainState == 1):
		weather = "Light rain"
	if(DialogueDatabase.rainState == 2):
		weather = "Pouring rain"
		
	### END VARIABLES ###
	
	# Checks dialogue database for the NPC boolean variable, to see whether you are in range of an NPC
	# We can use this system with a number instead of bool for more prompt struct choices if we want
	# variable can be changed based on different signals for NPCS, object interaction, etc
	
	var prompt = []
	if (DialogueDatabase.NPC == true):
		var promptStruct = (
			# NPC Prompt
			"
You are %s. 
%s. 
The weather is %s. 
Your mood is %s. 
Don't need to comment on all of the above, 
only respond with the text of the monologue, 
no quotations. 
Stay under 150 characters.
")
		prompt = promptStruct % [NPC, NPC2, weather, npc_mood]
	else:
		var promptStruct = (
			# Monologue Prompt
			"
You are %s in a foreign land. 
You have eaten %s apples, %s watermelon, and %s bananas since discovering this area. 
The weather is %s. 
Your hunger points are at %s. 
Your mood is %s. 
Don't need to comment on all of the above, 
only respond with the text of the monologue. 
Stay under 150 characters.
")
		prompt = promptStruct % [MC, apple, watermelon, banana, weather, hunger, mood]
		
	print("Prompt:\n", prompt)
	
	var ai_message = message_ai.instantiate()
	_call_gpt(prompt, ai_message)


func _call_gpt(prompt : String, ai_status_message : RichTextLabel) -> void:
	var headers = [
		"Content-Type: application/json",
		"Authorization: Bearer " + api_key
	]
	var messages = [{
		"role": "user",
		"content": prompt
	}]
	var body = JSON.stringify({
		"model": model,
		"messages": messages, # Send the array to chatGPT
		"temperature": temp,
		"stream": stream,
	})
	
	$HTTPSSEClient.connect_to_host(host, path, headers, body, ai_status_message, 443)
	stream_busy.emit(true)
	stream_ongoing = true
