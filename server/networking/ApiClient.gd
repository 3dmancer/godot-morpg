extends HTTPRequest


func _ready():
	if connect("request_completed", self, "_on_request_completed") != 0: printerr("Failed to connect signal")
	request("http://localhost:5000/api/v1/users", [], false, HTTPClient.METHOD_GET, "")

func _on_request_completed(result, response, headers, body):
	var json = JSON.parse(body.get_string_from_utf8())
	print("Got response: " + str(json.result))

