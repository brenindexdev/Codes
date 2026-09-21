n1 = float(input("Insira o primeiro número:"))
n2 = float(input("Insira o segundo número:"))

def sum_numeros(n1,n2):
            return n1 + n2

def sub_numeros(n1,n2):
            return (n1 - n2)

def mul_numeros(n1,n2):
            return (n1 * n2)

def div_numeros(n1,n2):
            if n2 == 0:
                return "Impossível dividir por zero"
            else:
                return (n1 / n2)

print(f"\n Soma: {n1} + {n2} = {sum_numeros(n1,n2):.2f}")
print(f"\n Subtração: {n1} - {n2} = {sub_numeros(n1,n2):.2f}")
print(f"\n Multiplicação: {n1} * {n2} = {mul_numeros(n1,n2):.2f}")
print(f"\n Divisão: {n1} / {n2} = {div_numeros(n1,n2):.2f}")