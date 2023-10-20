import random
from datetime import datetime, timedelta

# Gere IDs de usuário aleatórios com base no número de IDs de usuário
num_usuarios = 50
ids_usuarios = list(range(1, num_usuarios + 1))

def gerar_data_login():
    # Gere uma data e hora aleatória no último mês
    data_atual = datetime.now()
    data_login = data_atual - timedelta(days=random.randint(1, 30))
    return data_login.strftime("%Y-%m-%d %H:%M:%S")

with open("dadosLogAcessos.txt", "w") as arquivo:
    for _ in range(100):  
        usuario = random.choice(ids_usuarios)
        data_login = gerar_data_login()
        comando = f"INSERT INTO tb_log_acessos (data_login, fk_usuario) VALUES ('{data_login}', {usuario});\n"
        arquivo.write(comando)
