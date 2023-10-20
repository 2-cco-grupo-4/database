import random
from faker import Faker

def gerar_cpf():
    cpf = [str(random.randint(0, 9)) for _ in range(9)]

    # Gera o primeiro dígito verificador
    soma = sum(int(x) * y for x, y in zip(cpf, range(10, 1, -1)))
    cpf.append(str((11 - soma % 11) % 10))

    # Gera o segundo dígito verificador
    soma = sum(int(x) * y for x, y in zip(cpf, range(11, 1, -1)))
    cpf.append(str((11 - soma % 11) % 10))

    return ''.join(cpf)

def gerar_dados_usuario(tipo_usuario):
    fake = Faker("pt_BR")
    nome = fake.name()
    cpf = gerar_cpf()
    email = fake.email()
    senha = fake.password()
    data_nascimento = fake.date_of_birth(minimum_age=18, maximum_age=50)
    autenticado = random.choice([0, 1])
    celular = fake.phone_number()
    data_cadastro = fake.date_time_between(start_date='-1y', end_date='now')
    token_solicitacao = fake.password()
    cidade_preferencia = fake.city()
    estado_preferencia = fake.state()
    
    return (nome, cpf, email, senha, data_nascimento, celular, data_cadastro, tipo_usuario, token_solicitacao, cidade_preferencia, estado_preferencia, autenticado)

def gerar_queries_insert(num_queries):
    queries = []

    for i in range(num_queries):
        tipo_usuario = 1 if i < 25 else 2
        dados_usuario = gerar_dados_usuario(tipo_usuario)

        query = "INSERT INTO tb_usuario (nome, cpf, email, senha, data_nascimento, celular, data_cadastro, tipo_usuario, token_solicitacao, cidade_preferencia, estado_preferencia, autenticado) " \
                f"VALUES ('{dados_usuario[0]}', '{dados_usuario[1]}', '{dados_usuario[2]}', '{dados_usuario[3]}', '{dados_usuario[4]}', '{dados_usuario[5]}', '{dados_usuario[6]}', {dados_usuario[7]}, '{dados_usuario[8]}', '{dados_usuario[9]}', '{dados_usuario[10]}', '{dados_usuario[11]}');"

        queries.append(query)

    return queries

def salvar_queries_em_arquivo(queries, nome_arquivo):
    with open(nome_arquivo, 'w') as arquivo:
        for query in queries:
            arquivo.write(query + '\n')

    print(f"As queries foram salvas no arquivo '{nome_arquivo}'.")

queries = gerar_queries_insert(50)
salvar_queries_em_arquivo(queries, 'dadosUsuario.txt')
