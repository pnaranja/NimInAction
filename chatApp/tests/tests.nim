from ../src/protocol import parseMessage, createMessage, Message
from strformat import `&`
from json import JsonParsingError

block:
 let data = """{"username":"Mae", "message":"Hi Hunny"}"""
 let parsed: Message = parseMessage(data)
 doAssert(parsed.username == "Mae",
    &"Expected parsed.username == Mae but got {parsed.username}")

block:
 let data = """Bad Json"""
 try:
  let parsed: Message = parseMessage(data)
  echo parsed.username
  doAssert(false, "Was expecting a JsonParsingError when parsing a message")
 except JsonParsingError:
  doAssert true
 except:
  doAssert(false, "Was expecting a JsonParsingError when parsing a message")

block:
 let expected = """{"username":"dom","message":"hello"}""" & "\c\l"
 doAssert createMessage("dom", "hello") == expected


