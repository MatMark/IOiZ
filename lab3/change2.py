# f = open('output1.html', 'r')
# words = f.read()
# words = words.split()
# f.close()
# print(words)
# print(len(words))

f = open('output22.html', 'r')
contents = f.read()
contents = contents.split()
output = contents.copy()
# print(contents)
# print(len(contents))
f.close()

for i, word in enumerate(contents):
    # if "<b><b>" in word: 
        # print(word)
        # print(i)
    output[i] = word.replace("<b><b>", "<b>")
    output[i] = output[i].replace("</b></b>", "</b>")


print(output)

# f = open("output1.html", "w")
# listToStr = ' '.join([str(elem) for elem in contents])
# f.write(listToStr)
# f.close()

f = open("output22.html", "w")
listToStr = ' '.join([str(elem) for elem in output])
f.write(listToStr)
f.close()