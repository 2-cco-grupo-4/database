import random

# Lista de formatos de imagem
formatos = ["jpg", "png", "gif"]

# Função para gerar um comando INSERT aleatório
def gerar_comando_insert(id_album):
    caminho = f"/caminho/para/imagem{id_album}"
    descricao = f"Descrição da imagem {id_album}"
    formato = random.choice(formatos)
    return f"INSERT INTO IMAGEM (CAMINHO, DESCRICAO, FORMATO, FK_ALBUM) VALUES ('{caminho}', '{descricao}', '{formato}', {id_album});"

# Função para gerar comandos INSERT para cada álbum
def gerar_comandos_insert():
    with open("dadosImagem.txt", "w") as arquivo:
        for id_album in range(1, 101):
            for _ in range(3):
                comando_insert = gerar_comando_insert(id_album)
                arquivo.write(comando_insert + "\n")

# Chamada da função para gerar os comandos INSERT
gerar_comandos_insert()
