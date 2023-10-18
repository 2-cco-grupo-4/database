import random

num_usuarios = 50
num_temas = 6

usuarios = list(range(1, num_usuarios + 1))
temas = list(range(1, num_temas + 1))

def gerar_comando_insert(id_usuario, id_tema):
    comando = f"INSERT INTO tb_usuario_tema (id_usuario, id_tema) VALUES ({id_usuario}, {id_tema});"
    return comando

comandos = []
for id_usuario in usuarios:
    id_tema = random.choice(temas)
    comando = gerar_comando_insert(id_usuario, id_tema)
    comandos.append(comando)

nome_arquivo = "dadosUsuarioTema.txt"

with open(nome_arquivo, "w") as arquivo:
    arquivo.write("\n".join(comandos))

print(f"{len(comandos)} comandos INSERT foram gerados e gravados em {nome_arquivo}.")
