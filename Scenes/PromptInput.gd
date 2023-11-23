extends CanvasLayer

# ChatGPT Init
var url : String = "https://api.openai.com/v1/chat/completions"
var temp : float = 0.5
var max_tokens : int = 200
var api_key : String = OS.get_environment("OPENAI_API_KEY")
var headers = ["Content-type: application/json", "Authorization: Bearer " + api_key]
var model : String = "gpt-3.5-turbo"
# var messages = []  # Only needed for conversations
var request : HTTPRequest


# Called when the node enters the scene tree for the first time.
func _ready():
	request = HTTPRequest.new()
	add_child(request)
	request.connect("request_completed", _on_request_completed)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_gd_gpt_pressed():	
	# var prompt : String = get_node("TextEdit").text
	
	# Prompt variables
	#var NPC : String = "an old wise man"
	var MC : String =  "an adventurer"
	var apple : String = "you have just seen an apple"
	var hunger : String = "you are quite hungry"
	#var action : String = "MC has just finished slaying a dragon"
	var env : String = "It is a dry desert day"
	var hp : String = "65"#str(65)
	var mood : String = "exhausted"
	var promptStruct = (
#"
#You are %s. 
#Main character (MC) is %s, 
#%s. %s. 
#MC's HP is %s%%. 
#Say something to MC. Your mood is %s. 
#Don't have to comment on all of the above, 
#only respond with the text. Stay under 400 characters.
#")
"
You are a character with an internal monologue. 
You are %s. 
%s. %s. %s. 
Your HP is %s. 
Your mood is %s. 
Don't comment on all of the above, 
only respond with the text of the monologue. 
Stay under 200 characters.
")
	#var prompt = promptStruct % [NPC, MC, action, env, hp, mood]
	var prompt = promptStruct % [MC, env, apple, hunger, hp, mood]
	print("Prompt:\n", prompt)
	
	var messages = [{
		"role": "user",
		"content": prompt
	}]
	
	var body = JSON.new().stringify({
		"messages": messages,
		"temperature": temp,
		"max_tokens": max_tokens,
		"model": model
	})
	
	print("Sending ChatGPT Request")
	var send_request = request.request(
		url, headers, HTTPClient.METHOD_POST, body
		)
		
	
	print("Request received")
	if send_request != OK:
		print("error in ChatGPT request")


func _on_request_completed(result, response_code, headers, body):
	var json = JSON.new()
	json.parse(body.get_string_from_utf8())
	var response = json.get_data()
	var message = response["choices"][0]["message"]["content"]

	get_node("Label").set_text(message)
	
	print("Response:\n", message)
