text = input()
clean_text = text.replace(" ", "").lower()
rev_text = clean_text[::-1]

if clean_text == rev_text:
    print("Palindromo")
else:
    print("Não é palindromo")