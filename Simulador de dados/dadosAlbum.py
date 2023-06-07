import random

titulos = ["Álbum de Família", "Viagem dos Sonhos", "Momentos Especiais", "Retratos da Natureza", "Aventuras pelo Mundo"]

descricoes = ["Um álbum repleto de memórias incríveis.", "Registros dos melhores momentos da vida.", "Explorando a beleza do mundo através das lentes.", "Momentos únicos capturados para a eternidade."]

ids_fotografos = list(range(1, 51))

ids_temas = list(range(1, 16))

with open("dadosAlbum.txt", "w") as arquivo:
    for fotografo in ids_fotografos:
        for _ in range(2):
            tema = random.choice(ids_temas)
            
            titulo = random.choice(titulos)
            descricao = random.choice(descricoes)
            
            comando = f"INSERT INTO ALBUM (TITULO, DESCRICAO, FK_FOTOGRAFO, FK_TEMA) VALUES ('{titulo}', '{descricao}', {fotografo}, {tema});\n"
            arquivo.write(comando)
