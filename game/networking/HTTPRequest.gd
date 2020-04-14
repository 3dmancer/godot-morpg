extends HTTPRequest

const API_ADDRESS = "http://localhost:5000/api/v1"
const HEADERS = PoolStringArray([])
const USE_SSL = false

const REQUEST_DATA = "{}"

func _ready():
	self.connect("request_completed", self, "_on_request_completed")
	var r = self.request(API_ADDRESS + "/users", HEADERS, USE_SSL, HTTPClient.METHOD_GET, REQUEST_DATA)
	
	print("Sent request status: %s" % r)

func _on_request_completed(result, response_code, headers, body):
	print("got response")
	var json = JSON.parse(body.get_string_from_utf8())
	print(json.result)
