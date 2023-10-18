import random
from datetime import datetime, timedelta

num_usuarios = 50
ids_usuarios = list(range(1, num_usuarios + 1))

termos_de_busca = [
    "Casamento",
    "Eventos",
    "Vestidos de noiva",
    "Fotografia de casamento",
    "Cerimonias",
    "Especiais"
]

def gerar_data_pesquisa():
    data_atual = datetime.now()
    data_pesquisa = data_atual - timedelta(days=random.randint(1, 30))
    return data_pesquisa.strftime("%Y-%m-%d %H:%M:%S")

with open("dadosLogPesquisas.txt", "w") as arquivo:
    for _ in range(100):  
        usuario = random.choice(ids_usuarios)
        termo_busca = random.choice(termos_de_busca)
        data_pesquisa = gerar_data_pesquisa()
        comando = f"INSERT INTO tb_log_pesquisas (termo_busca, data_pesquisa, fk_usuario) VALUES ('{termo_busca}', '{data_pesquisa}', {usuario});\n"
        arquivo.write(comando)
