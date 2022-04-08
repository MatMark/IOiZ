import random

f = open('words.txt', 'r')
words = f.read()
words = words.split()
words = list(set(words))
f.close()
# print(words)
# print(len(words))

f = open('oryginal.txt', 'r')
contents = f.read()
contents = contents.split()
output = contents.copy()
# print(contents)
# print(len(contents))
f.close()

iterations = int(len(contents) / 3)
for i in range(iterations):
    num = random.randint(0, len(contents) - 1)
    contents[num] = f'<b>{contents[num]}</b>'
    output[num] = f'<b>{words[random.randint(0, len(words) - 1)]}</b>'

print(output)

f = open("output1.html", "w")
listToStr = ' '.join([str(elem) for elem in contents])
f.write(listToStr)
f.close()

f = open("output2.html", "w")
listToStr = ' '.join([str(elem) for elem in output])
f.write(listToStr)
f.close()