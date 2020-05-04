# REST API Client
extends HTTPRequest

# Routes
onready var auth = preload("res://game_server/client/http_client/routes/auth/auth.gd").new()

const API_ROOT = "http://localhost:5000/api/v1" 

# Function to call on the http response. Set before every request.
# This way we know how to treat any response from the API.
var callback : FuncRef

func _ready():
	var _r = connect("request_completed", self, "_on_request_completed")
	auth.httpClient = self

func _on_request_completed(result, respone_code, headers, body):	
	callback.call_func(result, respone_code, headers, body)
	


func GET(route: String):
	var _r = request(API_ROOT + route, get_headers(), false, HTTPClient.METHOD_GET)

func POST(route: String, data: String):
	var _r = request(API_ROOT + route, get_headers(), false, HTTPClient.METHOD_POST, data)
	
		

func PUT():
	pass

func DELETE():
	pass

func get_headers():
	var headers = ["Content-Type: application/json"]
	#var auth =  "Authentication: Bearer " + loginToken
	return headers
