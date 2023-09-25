CREATE DATABASE picme;

USE picme;

CREATE TABLE tb_usuario (
  id_usuario BIGINT PRIMARY KEY AUTO_INCREMENT,
  nome VARCHAR(120),
  cpf CHAR(14),
  email VARCHAR(256),
  senha VARCHAR(100),
  data_nascimento DATE,
  celular VARCHAR(20),
  data_cadastro DATETIME,
  tipo_usuario TINYINT,
  token_solicitacao VARCHAR(200),
  cidade_preferencia VARCHAR(150),
  estado_preferencia VARCHAR(150),
  autenticado TINYINT,
  INDEX(cpf, email)
);

CREATE TABLE tb_tag (
  id_tag BIGINT PRIMARY KEY AUTO_INCREMENT,
  nome VARCHAR(100)
);

CREATE TABLE tb_tema (
  id_tema BIGINT PRIMARY KEY AUTO_INCREMENT,
  nome VARCHAR(50)
);

CREATE TABLE tb_usuario_tag (
  id_tag BIGINT,
  id_usuario BIGINT,
  PRIMARY KEY (id_tag, id_usuario),
  FOREIGN KEY (id_tag) REFERENCES tb_tag(id_tag),
  FOREIGN KEY (id_usuario) REFERENCES tb_usuario(id_usuario)
);

CREATE TABLE tb_album (
  id_album BIGINT PRIMARY KEY AUTO_INCREMENT,
  titulo VARCHAR(100),
  descricao VARCHAR(100),
  fk_fotografo BIGINT,
  fk_tema BIGINT,
  FOREIGN KEY (fk_fotografo) REFERENCES tb_usuario(id_usuario),
  FOREIGN KEY (fk_tema) REFERENCES tb_tema(id_tema)
);

CREATE TABLE tb_log_acessos (
  id_log_acessos BIGINT PRIMARY KEY AUTO_INCREMENT,
  data_login DATETIME,
  fk_usuario BIGINT,
  FOREIGN KEY (fk_usuario) REFERENCES tb_usuario(id_usuario)
);

CREATE TABLE tb_log_pesquisas (
  id_log_pesquisas BIGINT PRIMARY KEY AUTO_INCREMENT,
  termo_busca VARCHAR(150),
  data_pesquisa DATETIME,
  fk_usuario BIGINT,
  FOREIGN KEY (fk_usuario) REFERENCES tb_usuario(id_usuario)
);

CREATE TABLE tb_imagem (
  id_imagem BIGINT PRIMARY KEY AUTO_INCREMENT,
  media_url VARCHAR(500),
  permalink VARCHAR(500),
  caption VARCHAR(100),
  media_type VARCHAR(5),
  updated_at DATETIME,
  fk_album BIGINT,
  FOREIGN KEY (fk_album) REFERENCES tb_album(id_album)
);

CREATE TABLE tb_tag_imagem (
  id_imagem BIGINT,
  id_tag BIGINT,
  PRIMARY KEY (id_imagem, id_tag),
  FOREIGN KEY (id_imagem) REFERENCES tb_imagem(id_imagem),
  FOREIGN KEY (id_tag) REFERENCES tb_tag(id_tag)
);

CREATE TABLE tb_usuario_tema (
  id_tema BIGINT,
  id_usuario BIGINT,
  PRIMARY KEY (id_tema, id_usuario),
  FOREIGN KEY (id_tema) REFERENCES tb_tema(id_tema),
  FOREIGN KEY (id_usuario) REFERENCES tb_usuario(id_usuario)
);

CREATE TABLE tb_sessao (
  id_sessao BIGINT PRIMARY KEY AUTO_INCREMENT,
  data_realizacao DATETIME,
  status_sessao VARCHAR(20),
  fk_fotografo BIGINT,
  fk_tema BIGINT,
  fk_cliente BIGINT,
  created_at DATETIME,
  FOREIGN KEY (fk_fotografo) REFERENCES tb_usuario(id_usuario),
  FOREIGN KEY (fk_tema) REFERENCES tb_tema(id_tema),
  FOREIGN KEY (fk_cliente) REFERENCES tb_usuario(id_usuario)
);

CREATE TABLE tb_endereco (
  id_endereco BIGINT PRIMARY KEY AUTO_INCREMENT,
  estado VARCHAR(150),
  cidade VARCHAR(150),
  cep VARCHAR(10),
  bairro VARCHAR(80),
  logradouro VARCHAR(100),
  numero VARCHAR(10),
  complemento VARCHAR(30),
  fk_sessao BIGINT,
  FOREIGN KEY (fk_sessao) REFERENCES tb_sessao(id_sessao)
);

CREATE TABLE tb_pagamento (
  id_pagamento BIGINT PRIMARY KEY AUTO_INCREMENT,
  forma VARCHAR(60),
  valor DECIMAL,
  parcelas INT,
  fk_sessao BIGINT,
  FOREIGN KEY (fk_sessao) REFERENCES tb_sessao(id_sessao)
);

CREATE TABLE tb_avaliacao (
  id_avaliacao BIGINT PRIMARY KEY AUTO_INCREMENT,
  descricao VARCHAR(300),
  nota DOUBLE,
  fk_sessao BIGINT,
  FOREIGN KEY (fk_sessao) REFERENCES tb_sessao(id_sessao),
  INDEX (nota)
);

CREATE TABLE tb_log_sessao (
  id_log_sessao BIGINT PRIMARY KEY AUTO_INCREMENT,
  data_modificacao DATETIME,
  status_sessao VARCHAR(20),
  data_realizacao DATETIME,
  fk_sessao BIGINT,
  FOREIGN KEY (fk_sessao) REFERENCES tb_sessao(id_sessao)
);