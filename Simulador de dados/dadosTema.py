nomes = [
    "Retratos",
    "Moda",
    "Evento",
    "Casamento",
    "Aniversário",
    "Conferência"
]

with open('dadosTema.txt', 'w') as file:
    for i, nome in enumerate(nomes, start=1):
        insert = f"INSERT INTO tb_tema (nome) VALUES ('{nome}');"
        file.write(insert + '\n')