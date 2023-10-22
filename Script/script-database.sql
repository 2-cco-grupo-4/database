-- Criar usuário para API Spring:
-- CREATE USER 'picmeUser'@'localhost' IDENTIFIED BY 'picme123';

-- Dropar database
-- DROP DATABASE picme;

CREATE DATABASE picme;
GRANT ALL PRIVILEGES ON picme.* TO 'picmeUser'@'localhost';
USE picme;

CREATE TABLE tb_usuario (
  id_usuario BIGINT PRIMARY KEY AUTO_INCREMENT NOT NULL,
  nome VARCHAR(120) NOT NULL,
  cpf CHAR(14),
  email VARCHAR(256),
  senha VARCHAR(100),
  data_nascimento DATE,
  celular VARCHAR(20),
  data_cadastro DATETIME,
  tipo_usuario TINYINT NOT NULL,
  token_solicitacao VARCHAR(200),
  cidade_preferencia VARCHAR(150),
  estado_preferencia VARCHAR(150),
  autenticado TINYINT,
  INDEX(cpf, email, nome)
);

CREATE TABLE tb_tag (
  id_tag BIGINT PRIMARY KEY AUTO_INCREMENT NOT NULL,
  nome VARCHAR(100) NOT NULL,
  INDEX(nome)
);

CREATE TABLE tb_tema (
  id_tema BIGINT PRIMARY KEY AUTO_INCREMENT NOT NULL,
  nome VARCHAR(50) NOT NULL,
  INDEX(nome)
);

CREATE TABLE tb_usuario_tag (
  id_tag BIGINT NOT NULL,
  id_usuario BIGINT NOT NULL,
  PRIMARY KEY (id_tag, id_usuario),
  FOREIGN KEY (id_tag) REFERENCES tb_tag(id_tag),
  FOREIGN KEY (id_usuario) REFERENCES tb_usuario(id_usuario)
);

CREATE TABLE tb_album (
  id_album BIGINT PRIMARY KEY AUTO_INCREMENT NOT NULL,
  titulo VARCHAR(100) NOT NULL,
  descricao VARCHAR(100),
  fk_fotografo BIGINT NOT NULL,
  fk_tema BIGINT NOT NULL,
  FOREIGN KEY (fk_fotografo) REFERENCES tb_usuario(id_usuario),
  FOREIGN KEY (fk_tema) REFERENCES tb_tema(id_tema),
  INDEX(titulo)
);

CREATE TABLE tb_log_acessos (
  id_log_acessos BIGINT PRIMARY KEY AUTO_INCREMENT NOT NULL,
  data_login DATETIME NOT NULL,
  fk_usuario BIGINT NOT NULL,
  FOREIGN KEY (fk_usuario) REFERENCES tb_usuario(id_usuario)
);

CREATE TABLE tb_log_pesquisas (
  id_log_pesquisas BIGINT PRIMARY KEY AUTO_INCREMENT NOT NULL,
  termo_busca VARCHAR(150) NOT NULL,
  data_pesquisa DATETIME NOT NULL,
  fk_usuario BIGINT NOT NULL,
  FOREIGN KEY (fk_usuario) REFERENCES tb_usuario(id_usuario),
  INDEX(termo_busca)
);

CREATE TABLE tb_imagem (
  id_imagem BIGINT PRIMARY KEY AUTO_INCREMENT NOT NULL,
  media_url VARCHAR(500),
  permalink VARCHAR(500),
  caption VARCHAR(100),
  media_type VARCHAR(5),
  origem_imagem VARCHAR(5) NOT NULL,
  updated_at DATETIME NOT NULL,
  fk_album BIGINT NOT NULL,
  FOREIGN KEY (fk_album) REFERENCES tb_album(id_album)
);

CREATE TABLE tb_tag_imagem (
  id_imagem BIGINT NOT NULL,
  id_tag BIGINT NOT NULL,
  PRIMARY KEY (id_imagem, id_tag),
  FOREIGN KEY (id_imagem) REFERENCES tb_imagem(id_imagem),
  FOREIGN KEY (id_tag) REFERENCES tb_tag(id_tag)
);

CREATE TABLE tb_usuario_tema (
  id_tema BIGINT NOT NULL,
  id_usuario BIGINT NOT NULL,
  PRIMARY KEY (id_tema, id_usuario),
  FOREIGN KEY (id_tema) REFERENCES tb_tema(id_tema),
  FOREIGN KEY (id_usuario) REFERENCES tb_usuario(id_usuario)
);

CREATE TABLE tb_sessao (
  id_sessao BIGINT PRIMARY KEY AUTO_INCREMENT NOT NULL,
  data_realizacao DATETIME NOT NULL,
  status_sessao VARCHAR(20),
  created_at DATETIME NOT NULL,
  fk_fotografo BIGINT NOT NULL,
  fk_tema BIGINT,
  fk_cliente BIGINT,
  FOREIGN KEY (fk_fotografo) REFERENCES tb_usuario(id_usuario),
  FOREIGN KEY (fk_tema) REFERENCES tb_tema(id_tema),
  FOREIGN KEY (fk_cliente) REFERENCES tb_usuario(id_usuario),
  INDEX(data_realizacao)
);

CREATE TABLE tb_endereco (
  id_endereco BIGINT PRIMARY KEY AUTO_INCREMENT NOT NULL,
  estado VARCHAR(150) NOT NULL,
  cidade VARCHAR(150) NOT NULL,
  cep VARCHAR(10) NOT NULL,
  bairro VARCHAR(80) NOT NULL,
  logradouro VARCHAR(100) NOT NULL,
  numero VARCHAR(10) NOT NULL,
  complemento VARCHAR(30),
  fk_sessao BIGINT NOT NULL,
  FOREIGN KEY (fk_sessao) REFERENCES tb_sessao(id_sessao),
  INDEX(estado, cidade)
);

CREATE TABLE tb_pagamento (
  id_pagamento BIGINT PRIMARY KEY AUTO_INCREMENT NOT NULL,
  forma VARCHAR(60) NOT NULL,
  valor DECIMAL(10, 2) NOT NULL,
  parcelas INT NOT NULL,
  fk_sessao BIGINT NOT NULL,
  FOREIGN KEY (fk_sessao) REFERENCES tb_sessao(id_sessao),
  INDEX(forma, valor)
);


CREATE TABLE tb_avaliacao (
  id_avaliacao BIGINT PRIMARY KEY AUTO_INCREMENT NOT NULL,
  descricao VARCHAR(300),
  nota DOUBLE NOT NULL,
  fk_sessao BIGINT NOT NULL,
  FOREIGN KEY (fk_sessao) REFERENCES tb_sessao(id_sessao),
  INDEX (nota)
);

CREATE TABLE tb_log_sessao (
  id_log_sessao BIGINT PRIMARY KEY AUTO_INCREMENT NOT NULL,
  data_modificacao DATETIME NOT NULL,
  status_sessao VARCHAR(20) NOT NULL,
  data_realizacao DATETIME NOT NULL,
  fk_sessao BIGINT NOT NULL,
  FOREIGN KEY (fk_sessao) REFERENCES tb_sessao(id_sessao)
);