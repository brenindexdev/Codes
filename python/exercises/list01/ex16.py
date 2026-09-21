date_string = input()
parts = date_string.split("/")

day = parts[0]
month_index = int(parts[1]) - 1
year = parts[2]

months = [
    "janeiro", "fevereiro", "março", "abril", "maio", "junho",
    "julho", "agosto", "setembro", "outubro", "novembro", "dezembro"
]

print(f"{day} de {months[month_index]} de {year}")