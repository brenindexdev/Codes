status = ["Frio", "Agradável", "Quente"]
c = float(input("Insira uma temperatura em graus Celsius: "))

f = (c * 9/5) + 32

if f < 15:
    print(f"\n{f:.1f}F - {status[0]}")
elif f >= 15 and f <= 25:
    print(f"\n{f:.1f}F - {status[1]}")
else:
    print(f"\n{f:.1f}F - {status[2]}")

