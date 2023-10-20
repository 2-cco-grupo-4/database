import random

def generate_insert(image_id, tag_id):
    return f"INSERT INTO tb_tag_imagem (id_imagem, id_tag) VALUES ({image_id}, {tag_id});"

def generate_random_data(num_images, num_tags):
    data = []
    for image_id in range(1, num_images + 1):
        tag_id = random.randint(1, num_tags)
        insert = generate_insert(image_id, tag_id)
        data.append(insert)
    return data

def write_to_file(filename, data):
    with open(filename, 'w') as file:
        for insert in data:
            file.write(insert + '\n')

num_images = 50
num_tags = 8
filename = 'dadosTagImagem.txt'

random_data = generate_random_data(num_images, num_tags)
write_to_file(filename, random_data)

print(f"Inserts gerados e salvos no arquivo '{filename}'.")
