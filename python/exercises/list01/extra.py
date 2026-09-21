product = input("Nome do produto: ")
price = float(input("Preço unitário: "))
quantity = int(input("Quantidade: "))

total = price * quantity

if total <= 100:
    rate = 0.0
elif total <= 300:
    rate = 0.05
else:
    rate = 0.10

discount = total * rate
final_total = total - discount

print(f"\nProduto: {product}")
print(f"Quantidade: {quantity}")
print(f"Valor total: R$ {total:.2f}")
print(f"Desconto: R$ {discount:.2f}")
print(f"Valor final: R$ {final_total:.2f}")