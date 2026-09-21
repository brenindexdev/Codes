text = input("Digite um texto: ")
punct = [".", ",", "!", "?", ";", ":"]

for p in punct:
    text = text.replace(p, " ")

words = text.split()
count = len(words)

print(count)