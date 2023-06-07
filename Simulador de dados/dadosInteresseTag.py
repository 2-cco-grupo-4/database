import random

def generate_insert(tag_id, user_id):
    return f"INSERT INTO INTERESSE_TAG (ID_TAG, ID_USUARIO) VALUES ({tag_id}, {user_id});"

def generate_random_data(num_tags, num_users):
    data = []
    for user_id in range(1, num_users + 1):
        tag_id = random.randint(1, num_tags)
        insert = generate_insert(tag_id, user_id)
        data.append(insert)
    return data

def write_to_file(filename, data):
    with open(filename, 'w') as file:
        for insert in data:
            file.write(insert + '\n')

num_tags = 15
num_users = 50
filename = 'dadosInteresseTag.txt'

random_data = generate_random_data(num_tags, num_users)
write_to_file(filename, random_data)

print(f"Inserts gerados e salvos no arquivo '{filename}'.")
