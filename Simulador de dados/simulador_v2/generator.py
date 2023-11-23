from faker import Faker
from sqlalchemy import create_engine, Column, Integer, String, Text, DateTime, Date, Float, ForeignKey, Index
from sqlalchemy.orm import declarative_base, sessionmaker
from sqlalchemy.sql import func
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.exc import IntegrityError, DataError

# Configuração do banco de dados
DATABASE_URL = "mysql://picme_trojan:trojan@localhost/picme_demo"
engine = create_engine(DATABASE_URL)

# Definindo a estrutura das tabelas
Base = declarative_base()

class Usuario(Base):
    __tablename__ = 'tb_usuario'
    id_usuario = Column(Integer, primary_key=True, autoincrement=True)
    nome = Column(String(120), nullable=False)
    cpf = Column(String(14))
    email = Column(String(256))
    senha = Column(String(100))
    data_nascimento = Column(Date)
    celular = Column(String(20))
    data_cadastro = Column(DateTime, default=func.now())
    tipo_usuario = Column(Integer, nullable=False)
    token_solicitacao = Column(String(200))
    cidade_preferencia = Column(String(150))
    estado_preferencia = Column(String(150))
    autenticado = Column(Integer)
    Index('cpf', 'email', 'nome')

class Tag(Base):
    __tablename__ = 'tb_tag'
    id_tag = Column(Integer, primary_key=True, autoincrement=True)
    nome = Column(String(100), nullable=False)
    Index('nome')

class Tema(Base):
    __tablename__ = 'tb_tema'
    id_tema = Column(Integer, primary_key=True, autoincrement=True)
    nome = Column(String(50), nullable=False)
    Index('nome')

class UsuarioTag(Base):
    __tablename__ = 'tb_usuario_tag'
    id_tag = Column(Integer, ForeignKey('tb_tag.id_tag'), primary_key=True)
    id_usuario = Column(Integer, ForeignKey('tb_usuario.id_usuario'), primary_key=True)

class Album(Base):
    __tablename__ = 'tb_album'
    id_album = Column(Integer, primary_key=True, autoincrement=True)
    titulo = Column(String(150), nullable=False)
    descricao = Column(Text)
    fk_fotografo = Column(Integer, ForeignKey('tb_usuario.id_usuario'))
    fk_tema = Column(Integer, ForeignKey('tb_tema.id_tema'))
    Index('titulo')
    
class LogAcessos(Base):
    __tablename__ = 'tb_log_acessos'
    id_log_acessos = Column(Integer, primary_key=True, autoincrement=True)
    data_login = Column(DateTime, default=func.now())
    fk_usuario = Column(Integer, ForeignKey('tb_usuario.id_usuario'))
    Index('fk_usuario')
    
class LogPesquisas(Base):
    __tablename__ = 'tb_log_pesquisas'
    id_log_pesquisas = Column(Integer, primary_key=True, autoincrement=True)
    termo_busca = Column(String(150), nullable=False)
    data_pesquisa = Column(DateTime, default=func.now())
    fk_usuario = Column(Integer, ForeignKey('tb_usuario.id_usuario'))
    Index('termo_busca')
    
class Imagem(Base):
    __tablename__ = 'tb_imagem'
    id_imagem = Column(Integer, primary_key=True, autoincrement=True)
    media_url = Column(String(500))
    permalink = Column(String(500))
    caption = Column(String(100))
    media_type = Column(String(5))
    origem_imagem = Column(String(5), nullable=False)
    updated_at = Column(DateTime, default=func.now())
    fk_album = Column(Integer, ForeignKey('tb_album.id_album'))
    
class TagImagem(Base):
    __tablename__ = 'tb_tag_imagem'
    id_tag = Column(Integer, ForeignKey('tb_tag.id_tag'), primary_key=True)
    id_imagem = Column(Integer, ForeignKey('tb_imagem.id_imagem'), primary_key=True)
    
class UsuarioTema(Base):
    __tablename__ = 'tb_usuario_tema'
    id_tema = Column(Integer, ForeignKey('tb_tema.id_tema'), primary_key=True)
    id_usuario = Column(Integer, ForeignKey('tb_usuario.id_usuario'), primary_key=True)
    
class Sessao(Base):
    __tablename__ = 'tb_sessao'
    id_sessao = Column(Integer, primary_key=True, autoincrement=True)
    data_realizacao = Column(DateTime, default=func.now())
    status_sessao = Column(String(20), nullable=False)
    created_at = Column(DateTime, default=func.now())
    fk_fotografo = Column(Integer, ForeignKey('tb_usuario.id_usuario'))
    fk_cliente = Column(Integer, ForeignKey('tb_usuario.id_usuario'))
    fk_tema = Column(Integer, ForeignKey('tb_tema.id_tema'))
    Index('data_realizacao')
    
class Endereco(Base):
    __tablename__ = 'tb_endereco'
    id_endereco = Column(Integer, primary_key=True, autoincrement=True)
    cep = Column(String(10))
    logradouro = Column(String(100))
    numero = Column(String(10))
    complemento = Column(String(30))
    bairro = Column(String(80))
    cidade = Column(String(150))
    estado = Column(String(150))
    fk_sessao = Column(Integer, ForeignKey('tb_sessao.id_sessao'))
    Index('estado', 'cidade')
    
class Pagamento(Base):
    __tablename__ = 'tb_pagamento'
    id_pagamento = Column(Integer, primary_key=True, autoincrement=True)
    forma = Column(String(60), nullable=False)
    valor = Column(Float, nullable=False)
    parcelas = Column(Integer, nullable=False)
    fk_sessao = Column(Integer, ForeignKey('tb_sessao.id_sessao'))
    Index('forma', 'valor')
    
class Avaliacao(Base):
    __tablename__ = 'tb_avaliacao'
    id_avaliacao = Column(Integer, primary_key=True, autoincrement=True)
    nota = Column(Float, nullable=False)
    descricao = Column(String(300))
    fk_sessao = Column(Integer, ForeignKey('tb_sessao.id_sessao'))
    Index('nota')
    
class LogSessao(Base):
    __tablename__ = 'tb_log_sessao'
    id_log_sessao = Column(Integer, primary_key=True, autoincrement=True)
    data_modificacao = Column(DateTime, default=func.now())
    status_sessao = Column(String(20), nullable=False)
    data_realizacao = Column(DateTime, default=func.now())
    fk_sessao = Column(Integer, ForeignKey('tb_sessao.id_sessao'))
    Index('fk_sessao')

# Criação das tabelas
Base.metadata.create_all(bind=engine)

# Configuração do Faker
fake = Faker()

# Gerar e inserir dados fictícios
def gerar_dados_ficticios():
    BATCH_SIZE = 50000
    SessionLocal = sessionmaker(autocommit=False, autoflush=False, bind=engine)
    
    with SessionLocal() as db:
        
        try:
            # Usando uma transação global
                for _ in range(50000000):  # Altere conforme necessário
                    usuario = Usuario(
                        nome=fake.name(),
                        cpf=fake.random_int(min=10000000000, max=99999999999),
                        email=fake.email(),
                        senha=fake.password(),
                        data_nascimento=fake.date_of_birth(),
                        celular=fake.pystr(max_chars=20),
                        tipo_usuario=fake.random_int(min=0, max=2),
                        cidade_preferencia=fake.city(),
                        estado_preferencia=fake.state(),
                        autenticado=fake.random_int(min=0, max=1),
                        token_solicitacao=fake.word(),
                    )
                    db.add(usuario)
                    if _ % BATCH_SIZE == 0:
                        db.commit()
                        # Iniciar uma nova transação
                        db.begin()
                db.commit()
        except Exception as e:
            print(f"Erro durante a geração de dados: {e}")
            db.rollback()
            
        
        try:
            for _ in range(50000000):
                tag = Tag(
                    nome=fake.word()
                )
                db.add(tag)
                if _ % BATCH_SIZE == 0:
                    db.commit()
                    # Iniciar uma nova transação
                    db.begin()
            db.commit()
        except Exception as e:
            print(f"Erro durante a geração de dados: {e}")
            db.rollback()
            
            
        try:
            for _ in range(50000000):
                tema = Tema(
                    nome=fake.word()
                )
                db.add(tema)
                if _ % BATCH_SIZE == 0:
                    db.commit()
                    # Iniciar uma nova transação
                    db.begin()
            db.commit()
        except Exception as e:
            print(f"Erro durante a geração de dados: {e}")
            db.rollback()
            
        
        try:
            for _ in range(50000000):  # Altere conforme necessário
                usuario_tag = UsuarioTag(
                    id_tag=fake.random_int(min=1, max=100),
                    id_usuario=fake.random_int(min=1, max=100)
                )
                if not db.query(UsuarioTag).filter_by(id_tag=usuario_tag.id_tag, id_usuario=usuario_tag.id_usuario).first():
                    # Inserir apenas se não existir
                    db.add(usuario_tag)
                    try:
                        if _ % BATCH_SIZE == 0:
                            db.commit()
                            # Iniciar uma nova transação
                            db.begin()
                    except IntegrityError as e:
                        # Lidar com a exceção (por exemplo, imprimir uma mensagem)
                        print(f"Erro de integridade: {e}")
                        db.rollback()
            db.commit()
        except Exception as e:
            print(f"Erro durante a geração de dados: {e}")
            db.rollback()
                
       
        try:
            for _ in range(50000000):  # Altere conforme necessário    
                album = Album(
                    titulo=fake.word(),
                    descricao=fake.text(max_nb_chars=100),
                    fk_fotografo=fake.random_int(min=1, max=100),
                    fk_tema=fake.random_int(min=1, max=100)
                )
                db.add(album)
                if _ % BATCH_SIZE == 0:
                    db.commit()
                    # Iniciar uma nova transação
                    db.begin()
            db.commit()
        except Exception as e:
            print(f"Erro durante a geração de dados: {e}")
            db.rollback()
            
        try:
            for _ in range(50000000):  # Altere conforme necessário
                logAcessos = LogAcessos(
                    fk_usuario=fake.random_int(min=1, max=100),
                    data_login=fake.date_time()
                )
                db.add(logAcessos)
                if _ % BATCH_SIZE == 0:
                    db.commit()
                    # Iniciar uma nova transação
                    db.begin()
            db.commit()
        except Exception as e:
            print(f"Erro durante a geração de dados: {e}")
            db.rollback()
            
        
        try:
            for _ in range(50000000):  # Altere conforme necessário
                logPesquisas = LogPesquisas(
                    termo_busca=fake.word(),
                    data_pesquisa=fake.date_time(),
                    fk_usuario=fake.random_int(min=1, max=100)
                )
                db.add(logPesquisas)
                if _ % BATCH_SIZE == 0:
                    db.commit()
                    # Iniciar uma nova transação
                    db.begin()
            db.commit()
        except Exception as e:
            print(f"Erro durante a geração de dados: {e}")
            db.rollback()
            
        try:
            for _ in range(50000000):  # Altere conforme necessário
                imagem = Imagem(
                    media_url=fake.url(),
                    permalink=fake.url(),
                    caption=fake.text(max_nb_chars=100),
                    media_type=fake.pystr(max_chars=5),
                    origem_imagem=fake.pystr(max_chars=5),
                    updated_at=fake.date_time(),
                    fk_album=fake.random_int(min=1, max=100)
                )
                db.add(imagem)
                if _ % BATCH_SIZE == 0:
                    db.commit()
                    # Iniciar uma nova transação
                    db.begin()
            db.commit()
        except Exception as e:
            print(f"Erro durante a geração de dados: {e}")
            db.rollback()
            
        try:
            for _ in range(50000000):
                while True:
                    try:
                        tagImagem = TagImagem(
                            id_tag=fake.random_int(min=1, max=100),
                            id_imagem=fake.random_int(min=1, max=100)
                        )
                        db.add(tagImagem)
                        if _ % BATCH_SIZE == 0:
                            db.commit()
                            # Iniciar uma nova transação
                            db.begin()
                        break  # Se bem-sucedido, sai do loop
                    except IntegrityError:
                        # Se ocorrer uma exceção de integridade, gera novos valores e tenta novamente
                        db.rollback()
            db.commit()
        except Exception as e:
            print(f"Erro durante a geração de dados: {e}")
            db.rollback()
                

            
        try:
            for _ in range(50000000):
                while True:
                    try:
                        usuarioTema = UsuarioTema(
                            id_tema=fake.random_int(min=1, max=100),
                            id_usuario=fake.random_int(min=1, max=100)
                        )
                        db.add(usuarioTema)
                        if _ % BATCH_SIZE == 0:
                            db.commit()
                            # Iniciar uma nova transação
                            db.begin()
                        break  # Se bem-sucedido, sai do loop
                    except IntegrityError:
                        # Se ocorrer uma exceção de integridade, gera novos valores e tenta novamente
                        db.rollback()
            db.commit()
        except Exception as e:
            print(f"Erro durante a geração de dados: {e}")
            db.rollback()
                            
            
        try:
            for _ in range(50000000):  # Altere conforme necessário
                sessao = Sessao(
                    data_realizacao=fake.date_time(),
                    status_sessao=fake.word(),
                    created_at=fake.date_time(),
                    fk_fotografo=fake.random_int(min=1, max=100),
                    fk_cliente=fake.random_int(min=1, max=100),
                    fk_tema=fake.random_int(min=1, max=100)
                )
                db.add(sessao)
                if _ % BATCH_SIZE == 0:
                    db.commit()
                    # Iniciar uma nova transação
                    db.begin()
            db.commit()
        except Exception as e:
            print(f"Erro durante a geração de dados: {e}")
            db.rollback()
            
        try:
            for _ in range(50000000):  # Altere conforme necessário
                endereco = Endereco(
                    cep=fake.postcode(),
                    logradouro=fake.street_name(),
                    numero=fake.building_number(),
                    complemento=fake.secondary_address(),
                    bairro=fake.word(),
                    cidade=fake.city(),
                    estado=fake.state(),
                    fk_sessao=fake.random_int(min=1, max=100)
                )
                db.add(endereco)
                db.add(sessao)
                if _ % BATCH_SIZE == 0:
                    db.commit()
                    # Iniciar uma nova transação
                    db.begin()
            db.commit()
        except Exception as e:
            print(f"Erro durante a geração de dados: {e}")
            db.rollback()
            
        
        try:
            for _ in range(50000000):
                while True:
                    try:
                        pagamento = Pagamento(
                            forma=fake.word(),
                            valor=fake.pyfloat(min_value=0, max_value=1000),  # Ajuste os limites conforme necessário
                            parcelas=fake.random_int(min=1, max=12),
                            fk_sessao=fake.random_int(min=1, max=100)
                        )
                        db.add(pagamento)
                        if _ % BATCH_SIZE == 0:
                            db.commit()
                            # Iniciar uma nova transação
                            db.begin()
                        break  # Se bem-sucedido, sai do loop
                    except (IntegrityError, DataError):
                        # Se ocorrer uma exceção de integridade ou de dados, gera novos valores e tenta novamente
                        db.rollback()
            # Commit no final fora do loop
            db.commit()
        except Exception as e:
            print(f"Erro durante a geração de dados: {e}")
            db.rollback()
            
        try:
            for _ in range(50000000):  # Altere conforme necessário
                avaliacao = Avaliacao(
                    nota=fake.pyfloat(),
                    descricao=fake.text(max_nb_chars=300),
                    fk_sessao=fake.random_int(min=1, max=100)
                )
                db.add(avaliacao)
                if _ % BATCH_SIZE == 0:
                    db.commit()
                     # Iniciar uma nova transação
                    db.begin()
            db.commit()
        except Exception as e:
            print(f"Erro durante a geração de dados: {e}")
            db.rollback()
            
        try:
            for _ in range(50000000):  # Altere conforme necessário
                logSessao = LogSessao(
                    data_modificacao=fake.date_time(),
                    status_sessao=fake.word(),
                    data_realizacao=fake.date_time(),
                    fk_sessao=fake.random_int(min=1, max=100)
                )
                db.add(logSessao)
                if _ % BATCH_SIZE == 0:
                    db.commit()
                     # Iniciar uma nova transação
                    db.begin()
            db.commit()
        except Exception as e:
            print(f"Erro durante a geração de dados: {e}")
            db.rollback()
            
            
gerar_dados_ficticios()
