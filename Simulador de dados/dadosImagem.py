import random
from datetime import datetime, timedelta

# Lista de URLs de imagens de casamento
urls_casamento = [
    "https://plus.unsplash.com/premium_photo-1683290222216-a9fab340cbf8?auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MXx8Q2FzYW1lbnRvfGVufDB8fDB8fHww&w=500",
    "https://images.unsplash.com/photo-1649183424680-464747a8e43d?auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8Q2FzYW1lbnRvfGVufDB8fDB8fHww&w=500",
    "https://images.unsplash.com/photo-1532712938310-34cb3982ef74?auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8M3x8Q2FzYW1lbnRvfGVufDB8fDB8fHww&w=500",
    "https://images.unsplash.com/photo-1519741497674-611481863552?auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NXx8Q2FzYW1lbnRvfGVufDB8fDB8fHww&w=500",
    "https://images.unsplash.com/photo-1583939003579-730e3918a45a?auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8OXx8Q2FzYW1lbnRvfGVufDB8fDB8fHww&w=500",
    "https://images.unsplash.com/photo-1546032996-6dfacbacbf3f?auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTh8fENhc2FtZW50b3xlbnwwfHwwfHx8MA%3D%3D&w=500",
    "https://images.unsplash.com/photo-1523438885200-e635ba2c371e?auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTZ8fENhc2FtZW50b3xlbnwwfHwwfHx8MA%3D%3D&w=500",
    "https://images.unsplash.com/photo-1607190074257-dd4b7af0309f?auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MjF8fENhc2FtZW50b3xlbnwwfHwwfHx8MA%3D%3D&w=500",
    "https://images.unsplash.com/photo-1606216794074-735e91aa2c92?auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MjN8fENhc2FtZW50b3xlbnwwfHwwfHx8MA%3D%3D&w=500",
    "https://images.unsplash.com/photo-1541532713592-79a0317b6b77?auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTR8fEZlc3Rhc3xlbnwwfHwwfHx8MA%3D%3D&w=500",
    "https://images.unsplash.com/photo-1544155891-969f15a055d3?auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MjR8fEZlc3Rhc3xlbnwwfHwwfHx8MA%3D%3D&w=500",
    "https://images.unsplash.com/photo-1533219057257-4bb9ed5d2cc6?auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NjR8fEZlc3Rhc3xlbnwwfHwwfHx8MA%3D%3D&w=500",
    "https://images.unsplash.com/photo-1544155892-b2b6c64204fc?auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTB8fEZlc3RhJTIwZGUlMjBBbml2ZXJzYXJpb3xlbnwwfHwwfHx8MA%3D%3D&w=500",
    "https://images.unsplash.com/photo-1595732301236-42a26208b2fc?auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NDF8fEZlc3RhJTIwZGUlMjBBbml2ZXJzYXJpb3xlbnwwfHwwfHx8MA%3D%3D&w=500",
    "https://images.unsplash.com/photo-1621857426350-ddab819cf0cc?auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NDd8fEZlc3RhJTIwZGUlMjBBbml2ZXJzYXJpb3xlbnwwfHwwfHx8MA%3D%3D&w=500",
    "https://images.unsplash.com/photo-1533294160622-d5fece3e080d?auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NTJ8fEZlc3RhJTIwZGUlMjBBbml2ZXJzYXJpb3xlbnwwfHwwfHx8MA%3D%3D&w=500",
    "https://images.unsplash.com/photo-1503315082045-a2bfb5e7f56e?auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NTl8fEZlc3RhJTIwZGUlMjBBbml2ZXJzYXJpb3xlbnwwfHwwfHx8MA%3D%3D&w=500",
    "https://images.unsplash.com/photo-1517457373958-b7bdd4587205?auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NzV8fEZlc3RhJTIwZGUlMjBBbml2ZXJzYXJpb3xlbnwwfHwwfHx8MA%3D%3D&w=500",
    "https://images.unsplash.com/photo-1603862018057-8a1ae272751a?auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Nzd8fEZlc3RhJTIwZGUlMjBBbml2ZXJzYXJpb3xlbnwwfHwwfHx8MA%3D%3D&w=500",
    "https://images.unsplash.com/photo-1598028445822-98171b8bcec1?auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8OTR8fEZlc3RhJTIwZGUlMjBBbml2ZXJzYXJpb3xlbnwwfHwwfHx8MA%3D%3D&w=500"
]

formatos = ["jpg", "png", "gif"]

num_albuns = 100
ids_albuns = list(range(1, num_albuns + 1))

def gerar_comando_insert(id_album):
    media_url = random.choice(urls_casamento)
    descricao = f"Descrição da imagem {id_album}"
    formato = random.choice(formatos)
    data_atual = datetime.now()
    data_atual = data_atual - timedelta(days=random.randint(1, 30))
    data_atual_str = data_atual.strftime("%Y-%m-%d %H:%M:%S")
    return f"INSERT INTO tb_imagem (media_url, caption, media_type, origem_imagem, updated_at, fk_album) VALUES ('{media_url}', '{descricao}', '{formato}', 'web', '{data_atual_str}', {id_album});"

def gerar_comandos_insert():
    with open("dadosImagem.txt", "w") as arquivo:
        for id_album in ids_albuns:
            for _ in range(1):
                comando_insert = gerar_comando_insert(id_album)
                arquivo.write(comando_insert + "\n")

gerar_comandos_insert()
