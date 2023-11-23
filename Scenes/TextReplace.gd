extends CanvasLayer

# ChatGPT Init
var url : String = "https://api.openai.com/v1/chat/completions"
var temp : float = 0.5
var max_tokens : int = 1024
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


func _on_button_pressed():
	get_node("Label").set_text(get_node("TextEdit").text)

func _on_gd_gpt_pressed():	
	print("GPT Function Called")
	var prompt : String = get_node("TextEdit").text
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
	print("New function called")
	var json = JSON.new()
	json.parse(body.get_string_from_utf8())
	var response = json.get_data()
	var message = response["choices"][0]["message"]["content"]
	print("Message received, sending to label")
	get_node("Label").set_text(message)
	
	print(message)
