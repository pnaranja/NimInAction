from os import paramCount, paramStr
from threadpool import spawn, `^`
from strformat import `&`

echo "starting Chat client application"

if paramCount() == 0:
    quit "Please specify the server address, e.g ./client localhost"

let serverAddr = paramStr(1)
echo &"Connecting to {serverAddr}"

echo &"Begin Chat.  To exit, enter \"exit()\""
while true:
    # stdout and stdin variables are of type os.File.File
    stdout.write(">> "); stdout.flushFile()
    let read = spawn stdin.readLine()
    # '^' - Block the current thread until you actuall get something in the stdin
    let message = ^read

    if message == "exit()":
        quit "Exiting chat application", 0

    echo("Sending message: \"", message, "\"")