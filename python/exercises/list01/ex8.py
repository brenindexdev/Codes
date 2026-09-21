secret = 42
x = True

while x:
    guess = int(input("Adivinhe o número secreto: "))
    if secret % 2 == 0:
        parity = "par"
    else:
        parity = "ímpar"

    print(f"\nO número secreto é {parity}.")

    if guess > secret:
        print("Muito alto!\n")
        continue
    elif guess < secret:
        print("Muito baixo!\n")
        continue
    else:
        print("Parabéns! Você acertou!")
        x = False