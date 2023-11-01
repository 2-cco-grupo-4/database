from faker import Faker
import random

fake = Faker('pt_BR')

id_sessoes = list(range(2, 32))

num_inserts = 30
inserts = []

for sessao_id in id_sessoes:
    estado_info = fake.estado()
    estado = estado_info[1] 
    cidade = fake.city()
    cep = fake.postcode()
    bairro = fake.bairro()
    logradouro = fake.street_name()
    numero = str(random.randint(1, 999))
    complemento = 'null'

    insert = f"INSERT INTO tb_endereco (estado, cidade, cep, bairro, logradouro, numero, complemento, fk_sessao) " \
             f"VALUES ('{estado}', '{cidade}', '{cep}', '{bairro}', '{logradouro}', '{numero}', {complemento}, {sessao_id});"
    inserts.append(insert)

with open("dadosEndereco.txt", "w") as file:
    for insert in inserts:
        file.write(insert + "\n")
