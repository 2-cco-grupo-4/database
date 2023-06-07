import random
from faker import Faker


def gerar_cpf():
    cpf = [random.randint(0, 9) for _ in range(9)]

    # Gera o primeiro dígito verificador
    soma = sum(x * y for x, y in zip(cpf, range(10, 1, -1)))
    cpf.append((11 - soma % 11) % 10)

    # Gera o segundo dígito verificador
    soma = sum(x * y for x, y in zip(cpf, range(11, 1, -1)))
    cpf.append((11 - soma % 11) % 10)

    return ''.join(map(str, cpf))


def gerar_dados_usuario():
    fake = Faker("pt_BR")
    nome = fake.name()
    cpf = gerar_cpf()
    email = fake.email()
    senha = fake.password()
    data_nascimento = fake.date_of_birth(minimum_age=18, maximum_age=90)
    autenticado = random.choice([True, False])
    celular = fake.phone_number()
    data_cadastro = fake.date_between(start_date='-1y', end_date='today')
    tipo_usuario = random.choice([1, 2])
    token_solicitacao = fake.uuid4()
    ultimo_login = fake.date_between(start_date='-1y', end_date='today')

    return (nome, cpf, email, senha, data_nascimento, autenticado, celular, data_cadastro, tipo_usuario, token_solicitacao, ultimo_login)


def gerar_queries_insert(num_queries):
    queries = []

    for _ in range(num_queries):
        dados_usuario = gerar_dados_usuario()

        query = "INSERT INTO USUARIO (NOME, CPF, EMAIL, SENHA, DATA_NASCIMENTO, AUTENTICADO, CELULAR, DATA_CADASTRO, TIPO_USUARIO, TOKEN_SOLICITACAO, ULTIMO_LOGIN) " \
                f"VALUES ('{dados_usuario[0]}', '{dados_usuario[1]}', '{dados_usuario[2]}', '{dados_usuario[3]}', '{dados_usuario[4]}', {int(dados_usuario[5])}, '{dados_usuario[6]}', '{dados_usuario[7]}', {dados_usuario[8]}, '{dados_usuario[9]}', '{dados_usuario[10]}');"

        queries.append(query)

    return queries


def salvar_queries_em_arquivo(queries, nome_arquivo):
    with open(nome_arquivo, 'w') as arquivo:
        for query in queries:
            arquivo.write(query + '\n')

    print(f"As queries foram salvas no arquivo '{nome_arquivo}'.")


queries = gerar_queries_insert(50)
salvar_queries_em_arquivo(queries, 'queries_insert.txt')
