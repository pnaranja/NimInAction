import sugar
import asyncdispatch, asyncfile

var future: Future[int] = newFuture[int]()
doAssert(not future.finished)

future.callback =
    proc (future: Future[int]) =
        echo("Future is no longer empty: ", future.read)

future.complete(42)
#future.fail(newException(ValueError, "the future has failed!"))

proc testAsyncRead1() =
    var file = openAsync("/Users/paul/nohup.out")
    let data = file.readAll()
    data.callback =
        proc (future: Future[string]) =
            echo(future.read())
    asyncdispatch.runForever()

proc testAsyncRead2() {.async.} =
    var file = openAsync("/Users/paul/nohup.out", fmReadWriteExisting)
    var file2 = openAsync("/Users/paul/nohup.out", fmReadWriteExisting)
    var data: string = await file.readAll()
    echo data
    await file.write("Hello!\n")
    data = await file2.readAll()
    echo data
    file.close()
    file2.close()

proc testSyncRead() =
    var file = open("/Users/paul/nohup.out")
    let data: string = file.readAll()
    echo data

waitFor testAsyncRead2()
