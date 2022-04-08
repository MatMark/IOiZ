f = open('output22.html', 'r')
contents = f.read()
contents = contents.split()
f.close()

num = 0
for i, word in enumerate(contents):
    if "<b>" in word: 
        # print(word)
        # print(i)
        num += 1

print(len(contents))
print(num)
