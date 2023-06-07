nomes = [
    "Retratos",
    "Paisagens",
    "Natureza",
    "Moda",
    "Vida Selvagem",
    "Arquitetura",
    "Street Photography",
    "Viagem",
    "Evento",
    "Produto",
    "Fotojornalismo",
    "Casamento",
    "Esportes",
    "Aerea",
    "Subaquatica"
]

with open('inserts.txt', 'w') as file:
    for i, nome in enumerate(nomes, start=1):
        insert = f"INSERT INTO TAG (ID_TAG, NOME) VALUES ({i}, '{nome}');"
        file.write(insert + '\n')