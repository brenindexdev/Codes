amount = int(input("Digite o valor do saque: "))

notes_100 = amount // 100
amount %= 100

notes_50 = amount // 50
amount %= 50

notes_20 = amount // 20
amount %= 20

notes_10 = amount // 10

print(f"{notes_100} nota(s) de R$ 100")
print(f"{notes_50} nota(s) de R$ 50")
print(f"{notes_20} nota(s) de R$ 20")
print(f"{notes_10} nota(s) de R$ 10")