from json import parseJson, JsonNode, getStr, `[]`, `%`, `$`

# The '*' means it is public
type Message* = object
  username*: string
  message*: string

# JsonNode type is a variant type - it is a reference object to JsonNodeObj
# JsonNodeObj contains element "kind" -> which is an enum of different Json node types
proc parseMessage*(data: string): Message =
  let dataJson:JsonNode = parseJson(data)
  result.username = dataJson["username"].getStr()
  result.message = dataJson["message"].getStr()

proc createMessage*(username: string, message: string) : string = 
  result = $(%{
    "username" : %username,
    "message" : %message
  }) & "\c\l"