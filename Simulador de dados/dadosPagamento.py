import random

num_pagamentos = 30

formas_de_pagamento = ["Cartão de Crédito", "Boleto Bancário", "Transferência Bancária", "PIX"]

# Gere IDs de sessão sequencialmente
ids_sessao = list(range(1, num_pagamentos + 1))

inserts = []
for i in range(num_pagamentos):
    forma_pagamento = random.choice(formas_de_pagamento)
    valor = round(random.uniform(50, 1000), 2)
    parcelas = random.randint(1, 12)
    fk_sessao = ids_sessao[i]

    insert = f"INSERT INTO tb_pagamento (forma, valor, parcelas, fk_sessao) " \
             f"VALUES ('{forma_pagamento}', {valor}, {parcelas}, {fk_sessao});"
    inserts.append(insert)

with open("dadosPagamento.txt", "w") as file:
    for insert in inserts:
        file.write(insert + "\n")
