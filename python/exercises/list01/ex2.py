from datetime import date

name = input("Insira seu nome: ")
age = int(input("Insira sua idade: "))
city = input("Insira sua cidade: ")

today = date.today()
birth_year = today.year - age

print(f"\nOlá {name}! Você tem {age} anos (nascido em {birth_year}) e mora em {city}.")