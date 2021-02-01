--Author ultimatezenzar https://github.com/ultimatezenzar/tape_streamer

--print usage info if url is missing
if (arg[1] == nil)
then
    print("Usage: tapestreamer <url>")
    return
end
 
--find tape drive to write to 
tape_drive = peripheral.find("tape_drive")
if (tape_drive == nil)
then
    print("Error: Tape drive not found")
    return
end

--check availability of http
if (http == nil)
then
    print("Error: HTTP api not found")
    return
end

--check url to make sure it's useable
success, message = http.checkURL(arg[1])
if (not success)
then
    print("Error: URL not valid ")
    print(message)
    return
end

--check if tape drive is empty
if (not tape_drive.isReady())
then
    print("Error: Tape not inserted")
    return
end

--do an http get to retrieve the file
print("Establishing Connection...")
payload = http.get(arg[1], nil, true).readAll() --convert http response to string
print("HTTP payload retrieved")

--confirm the user is ok with overwriting their tape
print("WARNING: this will overwite the tape's contents")
print("type y to confirm write operation")
 
if io.read() == "y" --write to tape if the user confirms
then
    tape_drive.seek(-1000000) --rewind tape
    tape_drive.write(payload) --write file to the tape
    print("Tape Write Complete") 
    return
end
 
print("Write Aborted")
 
 
