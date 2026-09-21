salary = float(input("Digite o salário atual: "))
percentage = float(input("Digite o percentual de aumento: "))

increase = salary * (percentage / 100)
new_salary = salary + increase

if new_salary < 2000:
    classification = "Faixa salarial 1"
elif new_salary <= 5000:
    classification = "Faixa salarial 2"
else:
    classification = "Faixa salarial 3"

print(f"\nValor do aumento: R$ {increase:.2f}")
print(f"Novo salário: R$ {new_salary:.2f}")
print(f"Classificação: {classification}")