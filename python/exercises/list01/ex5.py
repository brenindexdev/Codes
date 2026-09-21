p_value = float(input("Insira o valor da compra: "))

if p_value <= 100:
    d = 0
    d_value = p_value * d
elif p_value > 100 and p_value <= 500:
    d = 0.1
    d_value = p_value * d
else:
    d = 0.15
    d_value = p_value * d

print(f"\nValor original: R${p_value:.2f}\n% de desconto: {d * 100:.0f}%\nValor do desconto: R${d_value:.2f}\nValor final: R${p_value - d_value:.2f}")