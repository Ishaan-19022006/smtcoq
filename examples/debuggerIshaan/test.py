with open("test.txt", "r+") as f:
    word = "hello"
    f.write(word)
    f.seek(0)
    line = f.readline()
print(line)