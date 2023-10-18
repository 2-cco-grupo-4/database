import random

titulos = ["Casamento da filha", "Aniversario do cunhado", "Momentos Especiais", "Retratos do evento", "Aventuras pelo Mundo"]

descricoes = ["Um álbum repleto de memórias incríveis.", "Registros dos melhores momentos da vida.", "Melhor dia da minha vida", "Momentos únicos capturados para a eternidade."]

ids_fotografos = list(range(1, 51))

ids_temas = list(range(1, 7)) 

with open("dadosAlbum.txt", "w") as arquivo:
    for fotografo in ids_fotografos:
        for _ in range(2):
            tema = random.choice(ids_temas)
            
            titulo = random.choice(titulos)
            descricao = random.choice(descricoes)
            
            comando = f"INSERT INTO tb_album (titulo, descricao, fk_fotografo, fk_tema) VALUES ('{titulo}', '{descricao}', {fotografo}, {tema});\n"
            arquivo.write(comando)
