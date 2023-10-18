import random

num_logs_sessao = 50

ids_sessao = list(range(1, num_logs_sessao + 1))

inserts = []
for sessao_id in ids_sessao:
    data_modificacao = f"'2023-{random.randint(1, 12):02d}-{random.randint(1, 28):02d} " \
                       f"{random.randint(0, 23):02d}:{random.randint(0, 59):02d}:{random.randint(0, 59):02d}'"
    status_sessao = random.choice(["Ativo", "Desativado"])
    data_realizacao = f"'2023-{random.randint(1, 12):02d}-{random.randint(1, 28):02d} " \
                      f"{random.randint(0, 23):02d}:{random.randint(0, 59):02d}:{random.randint(0, 59):02d}'"

    insert = f"INSERT INTO tb_log_sessao (data_modificacao, status_sessao, data_realizacao, fk_sessao) " \
             f"VALUES ({data_modificacao}, '{status_sessao}', {data_realizacao}, {sessao_id});"
    inserts.append(insert)

# Gravação dos inserts em arquivo
with open("dadosLogSessao.txt", "w") as file:
    for insert in inserts:
        file.write(insert + "\n")
