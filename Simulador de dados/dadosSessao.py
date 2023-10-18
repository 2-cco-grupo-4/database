import random

id_usuarios = list(range(1, 51))
id_temas = list(range(1, 9))

num_inserts = 30
inserts = []

for _ in range(num_inserts):
    data_realizacao = f"'2023-{random.randint(1, 12):02d}-{random.randint(1, 28):02d} {random.randint(0, 23):02d}:{random.randint(0, 59):02d}:{random.randint(0, 59):02d}'"
    status_sessao = random.choice(["Confirmada", "Pendente", "Cancelada"])
    fk_fotografo = random.choice(id_usuarios)
    fk_tema = random.choice(id_temas)
    fk_cliente = random.choice(id_usuarios)
    created_at = f"NOW()"
    
    insert = f"INSERT INTO tb_sessao (data_realizacao, status_sessao, created_at, fk_fotografo, fk_tema, fk_cliente) VALUES ({data_realizacao}, '{status_sessao}', {created_at}, {fk_fotografo}, {fk_tema}, {fk_cliente});"
    inserts.append(insert)

# Gravação dos inserts em arquivo
with open("dadosSessao.txt", "w") as file:
    for insert in inserts:
        file.write(insert + "\n")
