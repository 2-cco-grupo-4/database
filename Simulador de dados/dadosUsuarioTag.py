import random

usuarios = range(1, 51)  
tags = range(1, 9)  


def gerar_comando_insert(id_usuario):
    id_tag = random.choice(tags)
    comando = f"INSERT INTO tb_usuario_tag (id_usuario, id_tag) VALUES ({id_usuario}, {id_tag});"
    return comando

num_comandos = 50  
comandos = [gerar_comando_insert(id_usuario) for id_usuario in usuarios]

nome_arquivo = "dadosUsuarioTag.txt"
with open(nome_arquivo, "w") as arquivo:
    arquivo.write("\n".join(comandos))

print(f"{num_comandos} comandos INSERT foram gerados e gravados em {nome_arquivo}.")
