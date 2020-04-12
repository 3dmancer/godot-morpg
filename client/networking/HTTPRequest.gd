extends HTTPRequest

func _ready():
	self.connect("request_completed", self, "_on_request_completed")
	self.request("http://localhost:1337")
	#request("localhost:1337",[""] ,false, HTTPClient.METHOD_GET)
	print("sent request")

func _on_request_completed(result, response_code, headers, body):
	print("got response")
	var json = JSON.parse(body.get_string_from_utf8())
	print(json.result)
