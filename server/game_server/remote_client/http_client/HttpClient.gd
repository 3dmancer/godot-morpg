extends HTTPRequest

const API_ROOT = "http://localhost:5000/api/v1" 

func _ready():
	var _r = connect("request_completed", self, "_on_request_completed")


func _on_request_completed(_result, _respone_code, _headers, body):
	var json = JSON.parse(body.get_string_from_utf8())
	print(json.result)


func GET(route: String):
	pass

func POST(route: String, data: String):
	pass

func PUT():
	pass

func DELETE():
	pass
