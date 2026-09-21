n = int(input("Qtd. de notas: "))
grades = []

for i in range(n):
    grade = float(input())
    grades.append(grade)

average = sum(grades) / n

print(f"\n{grades}")
print(f"{average:.1f}")