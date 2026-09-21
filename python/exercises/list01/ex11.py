value = float(input())
days = int(input())

fine = value * 0.02
interest = value * 0.00033 * days
total = value + fine + interest
min_payment = total * 0.10

print(f"\nValor: R$ {value:.2f}")
print(f"Multa: R$ {fine:.2f}")
print(f"Juros: R$ {interest:.2f}")
print(f"Valor total: R$ {total:.2f}")
print(f"Valor minimo para renegociacao: R$ {min_payment:.2f}")