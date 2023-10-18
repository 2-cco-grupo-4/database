import random

# Número de avaliações a serem geradas
num_avaliacoes = 30

# IDs de sessão
ids_sessao = list(range(1, num_avaliacoes + 1))

inserts = []
for sessao_id in ids_sessao:
    descricao = "Avaliação da sessão #" + str(sessao_id)
    nota = round(random.uniform(3, 5), 2)

    insert = f"INSERT INTO tb_avaliacao (descricao, nota, fk_sessao) " \
             f"VALUES ('{descricao}', {nota}, {sessao_id});"
    inserts.append(insert)

with open("dadosAvaliacao.txt", "w") as file:
    for insert in inserts:
        file.write(insert + "\n")
