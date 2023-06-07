from faker import Faker
import random

fake = Faker('pt_BR')

id_eventos = list(range(1, 51))

num_inserts = 50 
inserts = []

for evento_id in id_eventos:
    estado = fake.estado()
    cidade = fake.city()
    cep = fake.postcode()
    bairro = fake.bairro()
    logradouro = fake.street_name()
    numero = str(random.randint(1, 999))
    complemento = 'null'

    insert = f"INSERT INTO ENDERECO (ESTADO, CIDADE, CEP, BAIRRO, LOGRADOURO, NUMERO, COMPLEMENTO, FK_EVENTO) " \
             f"VALUES ('{estado}', '{cidade}', '{cep}', '{bairro}', '{logradouro}', '{numero}', '{complemento}', {evento_id});"
    inserts.append(insert)

with open("dadosEndereco.txt", "w") as file:
    for insert in inserts:
        file.write(insert + "\n")
