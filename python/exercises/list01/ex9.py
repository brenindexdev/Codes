n = int(input("Digite um número inteiro: "))

if n > 0:
    sign = "positivo"
elif n < 0:
    sign = "negativo"
else:
    sign = "zero"

if n % 2 == 0:
    parity = "par"
else:
    parity = "ímpar"

abs_value = abs(n)

print(f"Número: {n}\n")
print(f"Classificação: {sign}")
print(f"Paridade: {parity}")
print(f"Valor absoluto: {abs_value}")