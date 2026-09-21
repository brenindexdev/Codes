name = input("Digite seu nome: ")
age = int(input("Digite sua idade: "))

if age < 16:
    print(f"{name}, acesso não permitido.")
elif 16 <= age <= 17:
    print(f"{name}, acesso permitido somente acompanhado.")
else:
    print(f"{name}, acesso permitido.")