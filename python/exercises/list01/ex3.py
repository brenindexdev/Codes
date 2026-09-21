grades = []

for n in range(3):
    grade = float(input(f"Insira a nota {n+1}: "))
    grades.append(grade)

def avg(grades):
    return sum(grades) / len(grades)

def status(grades):
    if avg(grades) >= 7: return "Aprovado"
    if avg(grades) >= 5 and avg(grades) < 7: return "Recuperação"
    else: return "Reprovado"
        
print(f"\nMédia: {avg(grades):.2f}\n{status(grades)}")