import random

id_usuarios = list(range(1, 51))
id_temas = list(range(1, 16))

num_inserts = 30  
inserts = []

for _ in range(num_inserts):
    data_realizacao = f"'2023-{random.randint(1, 12):02d}-{random.randint(1, 28):02d}'"
    status_evento = random.choice(["Confirmado", "Pendente", "Cancelado"])
    fk_fotografo = random.choice(id_usuarios)
    fk_tema = random.choice(id_temas)
    fk_cliente = random.choice(id_usuarios)
    valor = round(random.uniform(100, 1000), 2)
    
    insert = f"INSERT INTO EVENTO (DATA_REALIZACAO, STATUS_EVENTO, FK_FOTOGRAFO, FK_TEMA, FK_CLIENTE, VALOR) VALUES ({data_realizacao}, '{status_evento}', {fk_fotografo}, {fk_tema}, {fk_cliente}, {valor});"
    inserts.append(insert)

# Gravação dos inserts em arquivo
with open("dadosEvento.txt", "w") as file:
    for insert in inserts:
        file.write(insert + "\n")
