list1 = eval(input())
list2 = eval(input())

common = []
for item in list2:
    if item in list1 and item not in common:
        common.append(item)

if len(common) > 0:
    for item in common:
        print(item)
else:
    print("Não tem.")