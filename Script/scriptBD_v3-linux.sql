CREATE USER 'picmeUser'@'localhost' IDENTIFIED BY 'picme123';
DROP DATABASE picme;
CREATE DATABASE picme;
GRANT ALL PRIVILEGES ON picme.* TO 'picmeUser'@'localhost';
USE picme;



-- Criação da tabela Usuario
CREATE TABLE usuario (
    id_usuario BIGINT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(50),
    cpf VARCHAR(100),
    email VARCHAR(100),
    senha VARCHAR(100),
    data_nascimento DATE,
    autenticado BOOL,
    celular VARCHAR(20),
    data_cadastro DATE,
    tipo_usuario TINYINT,
    token_solicitacao VARCHAR(100),
    ultimo_login DATE DEFAULT NULL
);

-- Criação da tabela Tema
CREATE TABLE tema (
    id_tema BIGINT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(50)
);

-- Criação da tabela TemasUsuario
CREATE TABLE usuario_tema (
  id_usuario BIGINT,
  id_tema BIGINT,
  PRIMARY KEY (id_usuario, id_tema),
  FOREIGN KEY (id_tema) REFERENCES tema(id_tema),
  FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario)
);

-- Criação da tabela Evento
CREATE TABLE evento (
    id_evento BIGINT AUTO_INCREMENT PRIMARY KEY,
    data_realizacao DATE,
    status_evento VARCHAR(20),
    fk_fotografo BIGINT,
    fk_tema BIGINT,
    fk_cliente BIGINT,
    valor DECIMAL(10, 2),
    FOREIGN KEY (fk_fotografo) REFERENCES usuario(id_usuario),
    FOREIGN KEY (fk_tema) REFERENCES tema(id_tema),
    FOREIGN KEY (fk_cliente) REFERENCES usuario(id_usuario)
);

-- Criação da tabela Endereco
CREATE TABLE endereco (
    id_endereco BIGINT AUTO_INCREMENT PRIMARY KEY,
    estado VARCHAR(50),
    cidade VARCHAR(50),
    cep VARCHAR(10),
    bairro VARCHAR(50),
    logradouro VARCHAR(100),
    numero VARCHAR(10),
    complemento VARCHAR(100),
    fk_evento BIGINT,
    FOREIGN KEY (fk_evento) REFERENCES evento(id_evento)
);

-- Criação da tabela Album
CREATE TABLE album (
    id_album BIGINT AUTO_INCREMENT PRIMARY KEY,
    titulo VARCHAR(100),
    descricao VARCHAR(100),
    fk_fotografo BIGINT,
    fk_tema BIGINT,
    FOREIGN KEY (fk_fotografo) REFERENCES usuario(id_usuario),
    FOREIGN KEY (fk_tema) REFERENCES tema(id_tema)
);

-- Criação da tabela Imagem
CREATE TABLE imagem (
    id_imagem BIGINT AUTO_INCREMENT PRIMARY KEY,
    caminho VARCHAR(500),
    descricao VARCHAR(100),
    formato VARCHAR(5),
    fk_album BIGINT,
    FOREIGN KEY (fk_album) REFERENCES album(id_album)
);

-- Tabela Tag
CREATE TABLE tag (
  id_tag BIGINT PRIMARY KEY,
  nome VARCHAR(100)
);

-- Tabela TagsImagem
CREATE TABLE tag_imagem (
  id_imagem BIGINT,
  id_tag BIGINT,
  PRIMARY KEY (id_imagem, id_tag),
  FOREIGN KEY (id_imagem) REFERENCES imagem(id_imagem),
  FOREIGN KEY (id_tag) REFERENCES tag(id_tag)
);

-- Tabela InteressesTags
CREATE TABLE interesse_tag (
  id_tag BIGINT,
  id_usuario BIGINT,
  PRIMARY KEY (id_tag, id_usuario),
  FOREIGN KEY (id_tag) REFERENCES tag(id_tag),
  FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario)
);

-- Tabela LogsPaginasSite
CREATE TABLE log_pagina_site (
  id_log_pagina_site INT PRIMARY KEY,
  sessao_ativa INT,
  tempo_duracao_sessao DOUBLE,
  data_sessao DATE,
  qtd_nova_sessao INT,
  total_view_pagina INT,
  log_pagina_sitecol VARCHAR(45)
);