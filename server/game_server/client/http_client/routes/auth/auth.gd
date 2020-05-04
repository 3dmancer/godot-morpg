extends Reference

var httpClient : HTTPRequest

const ROUTE_ROOT = "/auth"

signal login_complete(successful, token, error)

func login(jsonData: String):
	httpClient.callback = funcref(self, "on_login_response")
	httpClient.POST(ROUTE_ROOT + "/login", jsonData)

func on_login_response(_result: int, _response_code: int, _headers: PoolStringArray, body: PoolByteArray):
	print("Login response:")
	var res = parse_response(body)
	print(res)
	if res["success"]:
		emit_signal("login_complete", true, res["token"], "")
	else:
		emit_signal("login_complete", false, "", res["error"])

func parse_response(body: PoolByteArray):
	var json = JSON.parse(body.get_string_from_utf8())
	if json.result is Dictionary:
		return json.result
	else:
		push_error("Got wrong json format. Expected Dictionary.")
	
