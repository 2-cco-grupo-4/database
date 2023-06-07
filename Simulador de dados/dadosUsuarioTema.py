import random

# Dados de exemplo
usuarios = range(1, 51)  # IDs de 1 a 50
temas = range(1, 16)  # IDs de 1 a 15

# Função para gerar um comando INSERT com um tema para cada usuário
def gerar_comando_insert(id_usuario):
    id_tema = random.choice(temas)
    comando = f"INSERT INTO USUARIO_TEMA (ID_USUARIO, ID_TEMA) VALUES ({id_usuario}, {id_tema});"
    return comando

# Gerar os comandos INSERT aleatórios com um tema para cada usuário
num_comandos = 50  # Quantidade de comandos INSERT a serem gerados
comandos = [gerar_comando_insert(id_usuario) for id_usuario in usuarios]

# Escrever os comandos em um arquivo de texto
nome_arquivo = "dadosUsuarioTema.txt"
with open(nome_arquivo, "w") as arquivo:
    arquivo.write("\n".join(comandos))

print(f"{num_comandos} comandos INSERT foram gerados e gravados em {nome_arquivo}.")
