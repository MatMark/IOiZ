# test = 'bcadebcadb'
# window = 2
# out = []
# for i in range(len(test) - window + 1):
#     temp = []
#     for j in range(i, i + window):
#         temp.append(test[j])
#     out.append(tuple(temp))

# print(out)
# print(set(out))

f = open('first.txt', 'r')
first = f.read()
f.close()

f = open('second.txt', 'r')
second = f.read()
f.close()

window = 16
out = []
for i in range(len(first) - window + 1):
    temp = []
    for j in range(i, i + window):
        temp.append(first[j])
    out.append(tuple(temp))

first_shingles = set(out)

out = []
for i in range(len(second) - window + 1):
    temp = []
    for j in range(i, i + window):
        temp.append(second[j])
    out.append(tuple(temp))

second_shingles = set(out)


# print(first_shingles)
# print(second_shingles)

and_num = 0
for x in second_shingles:
    if x in first_shingles:
        and_num += 1
        print(x)
print(and_num)

or_num = len(set(list(first_shingles) + list(second_shingles)))
print(or_num)

jaccard = and_num/or_num
print(jaccard)