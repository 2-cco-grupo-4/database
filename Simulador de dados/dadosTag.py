nomes = [
    "Retratos",
    "Natureza",
    "Moda",
    "Festa",
    "Evento",
    "Casamento",
    "Preto e Branco",
    "Igreja"
]

with open('dadosTag.txt', 'w') as file:
    for i, nome in enumerate(nomes, start=1):
        insert = f"INSERT INTO tb_tag (nome) VALUES ('{nome}');"
        file.write(insert + '\n')
