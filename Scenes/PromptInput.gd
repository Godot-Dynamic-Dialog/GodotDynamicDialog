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

var stream_reply_buffer: String
var stream_reply_final: String
var stream_used_status_ai_message = false
var stream_ongoing = false

# Called when the node enters the scene tree for the first time.
func _ready():
	# Instantiate HTTP request to GPT
	request = HTTPRequest.new()
	add_child(request)
	#request.connect("request_completed", _on_request_completed)
	message_processed.connect(_on_request_completed)
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
				
			# We append the whole message to our internal chat
			#chat.append({"role": "assistant", "content":stream_reply_final})
			# We reset the reply, ready for the next stream
			stream_reply_final = ""
			stream_used_status_ai_message = false
			
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
			get_node("Label").set_text(stream_reply_buffer)
			# print("Current buffer: ", stream_reply_buffer)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_gd_gpt_pressed():	
	# var prompt : String = get_node("TextEdit").text
	
	# Prompt variables
	# These first two are only for NPC interaction
	#var NPC : String = "an old wise man"
	#var action : String = "MC has just finished slaying a dragon"
	var MC : String =  "an adventurer"
	var apple : String = "you see an apple"
	var extra : String = "you just saw an apple tree."
	var hunger : String = "you are quite hungry"
	var env : String = "It is a dry desert day"
	var hp : String = str(65)
	var mood : String = "exhausted"
	var promptStruct = (
# Monologue Prompt
"
You are a character with an internal monologue. 
You are %s. 
%s. %s. %s. %s. 
Your HP is %s. 
Your mood is %s. 
Don't need to comment on all of the above, 
only respond with the text of the monologue. 
Stay under 300 characters.
")

	var prompt = promptStruct % [MC, env, hunger, apple, extra, hp, mood]
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
	
	if stream:
		$HTTPSSEClient.connect_to_host(host, path, headers, body, ai_status_message, 443)
		stream_busy.emit(true)
		stream_ongoing = true
		
	else:
		var http_request = HTTPRequest.new()
		add_child(http_request)
		http_request.request_completed.connect(_on_request_completed)
		
		var error = http_request.request(url, headers, HTTPClient.METHOD_POST, body)
		
		if error != OK:
			push_error("Something Went Wrong!")

func _on_request_completed(result, response_code, headers, body):
	# Get the message string from response
	var json = JSON.new()
	json.parse(body.get_string_from_utf8())
	var response = json.get_data()
	var message = response["choices"][0]["message"]["content"]

	# Change on-screen text
	get_node("Label").set_text(message)
	
	print("Response:\n", message)
