CREATE DATABASE picme;

USE picme;

CREATE TABLE tb_usuario (
  id_usuario INT PRIMARY KEY,
  nome VARCHAR(120),
  cpf CHAR(14),
  email VARCHAR(120),
  senha VARCHAR(100),
  dataNascimento DATE,
  celular VARCHAR(15),
  data_cadastro DATE,
  tipo_usuario TINYINT,
  token_solicitacao VARCHAR(150),
  cidade_preferencia VARCHAR(150),
  estado_preferencia VARCHAR(150),
  autenticado TINYINT
);

CREATE TABLE tb_tag (
  id_tag INT PRIMARY KEY,
  nome VARCHAR(100)
);

CREATE TABLE tb_tema (
  id_tema INT PRIMARY KEY,
  nome VARCHAR(50)
);

CREATE TABLE tb_usuario_tag (
  id_tag INT,
  id_usuario INT,
  FOREIGN KEY (id_tag) REFERENCES tb_tag(id_tag),
  FOREIGN KEY (id_usuario) REFERENCES tb_usuario(id_usuario)
);

CREATE TABLE tb_album (
  id_album INT PRIMARY KEY,
  titulo VARCHAR(100),
  descricao VARCHAR(100),
  fk_fotografo INT,
  fk_tema INT,
  FOREIGN KEY (fk_fotografo) REFERENCES tb_usuario(id_usuario),
  FOREIGN KEY (fk_tema) REFERENCES tb_tema(id_tema)
);

CREATE TABLE tb_log_acessos (
  id_log_acessos INT PRIMARY KEY,
  data_login DATE,
  fk_usuario INT,
  FOREIGN KEY (fk_usuario) REFERENCES tb_usuario(id_usuario)
);

CREATE TABLE tb_log_pesquisas (
  id_log_pesquisas INT PRIMARY KEY,
  termo_busca VARCHAR(150),
  data_pesquisa DATE,
  fk_usuario INT,
  FOREIGN KEY (fk_usuario) REFERENCES tb_usuario(id_usuario)
);

CREATE TABLE tb_imagem (
  id_imagem INT PRIMARY KEY,
  media_url VARCHAR(500),
  permalink VARCHAR(500),
  caption VARCHAR(100),
  media_type VARCHAR(5),
  updated_at DATE,
  fk_album INT,
  FOREIGN KEY (fk_album) REFERENCES tb_album(id_album)
);

CREATE TABLE tb_tag_imagem (
  id_imagem INT,
  id_tag INT,
  FOREIGN KEY (id_imagem) REFERENCES tb_imagem(id_imagem),
  FOREIGN KEY (id_tag) REFERENCES tb_tag(id_tag)
);


CREATE TABLE tb_usuario_tema (
  id_tema INT,
  id_usuario INT,
  FOREIGN KEY (id_tema) REFERENCES tb_tema(id_tema),
  FOREIGN KEY (id_usuario) REFERENCES tb_usuario(id_usuario)
);

CREATE TABLE tb_sessao (
  id_sessao INT PRIMARY KEY,
  data_realizacao DATE,
  status_sessao VARCHAR(20),
  fk_fotografo INT,
  fk_tema INT,
  fk_cliente INT,
  FOREIGN KEY (fk_fotografo) REFERENCES tb_usuario(id_usuario),
  FOREIGN KEY (fk_tema) REFERENCES tb_tema(id_tema),
  FOREIGN KEY (fk_cliente) REFERENCES tb_usuario(id_usuario)
);

CREATE TABLE tb_endereco (
  id_endereco INT PRIMARY KEY,
  estado VARCHAR(150),
  cidade VARCHAR(150),
  cep VARCHAR(80),
  bairro VARCHAR(10),
  logradouro VARCHAR(100),
  numero VARCHAR(10),
  complemento VARCHAR(30),
  fk_sessao INT,
  FOREIGN KEY (fk_sessao) REFERENCES tb_sessao(id_sessao)
);

CREATE TABLE tb_pagamento (
  id_pagamento INT PRIMARY KEY,
  forma VARCHAR(60),
  valor DECIMAL,
  parcelas INT,
  fk_sessao INT,
  FOREIGN KEY (fk_sessao) REFERENCES tb_sessao(id_sessao)
);

CREATE TABLE tb_avaliacao (
  id_avaliacao INT PRIMARY KEY,
  descricao VARCHAR(300),
  nota DOUBLE,
  fk_sessao INT,
  FOREIGN KEY (fk_sessao) REFERENCES tb_sessao(id_sessao)
);

CREATE TABLE tb_log_sessao (
  id_log_sessao INT PRIMARY KEY,
  data_modificacao DATE,
  status_sessao VARCHAR(20),
  data_realizacao DATE,
  fk_sessao INT,
  FOREIGN KEY (fk_sessao) REFERENCES tb_sessao(id_sessao)
);


