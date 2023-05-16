-- Tabela Usuario
CREATE TABLE Usuario (
  idUsuario INT PRIMARY KEY,
  nome VARCHAR(120),
  cpf CHAR(14),
  email VARCHAR(120),
  senha VARCHAR(100),
  dataNascimento DATE,
  celular VARCHAR(15),
  dataCadastro DATE,
  tipoUsuario VARCHAR(50),
  token VARCHAR(150)
);

-- Tabela Evento
CREATE TABLE Evento (
  idEvento INT PRIMARY KEY,
  dataRealizacao DATE,
  status VARCHAR(80),
  fkFotografo INT,
  fkTema INT,
  fkCliente INT,
  valor DOUBLE,
  avaliacao INT
);

-- Tabela Tema
CREATE TABLE Tema (
  idTema INT PRIMARY KEY,
  nome VARCHAR(100)
);

-- Tabela Album
CREATE TABLE Album (
  idAlbum INT PRIMARY KEY,
  titulo VARCHAR(80),
  fkFotografo INT,
  fkTema INT
);

-- Tabela Imagem
CREATE TABLE Imagem (
  idImagem INT PRIMARY KEY,
  url VARCHAR(250),
  idDono INT,
  momento DATE,
  fkAlbum INT
);

-- Tabela Tag
CREATE TABLE Tag (
  idTag INT PRIMARY KEY,
  nome VARCHAR(100)
);

-- Tabela TagsImagem
CREATE TABLE TagsImagem (
  idImagem INT,
  idTag INT,
  PRIMARY KEY (idImagem, idTag),
  FOREIGN KEY (idImagem) REFERENCES Imagem(idImagem),
  FOREIGN KEY (idTag) REFERENCES Tag(idTag)
);

-- Tabela InteressesTags
CREATE TABLE InteressesTags (
  idTag INT,
  idUsuario INT,
  PRIMARY KEY (idTag, idUsuario),
  FOREIGN KEY (idTag) REFERENCES Tag(idTag),
  FOREIGN KEY (idUsuario) REFERENCES Usuario(idUsuario)
);

-- Tabela TemasUsuario
CREATE TABLE TemasUsuario (
  idTema INT,
  idUsuario INT,
  PRIMARY KEY (idTema, idUsuario),
  FOREIGN KEY (idTema) REFERENCES Tema(idTema),
  FOREIGN KEY (idUsuario) REFERENCES Usuario(idUsuario)
);

-- Tabela Endereco
CREATE TABLE Endereco (
  idEndereco INT PRIMARY KEY,
  estado VARCHAR(80),
  cidade VARCHAR(80),
  cep VARCHAR(9),
  bairro VARCHAR(80),
  rua VARCHAR(80),
  numero VARCHAR(10),
  complemento VARCHAR(10),
  fkEvento INT,
  FOREIGN KEY (fkEvento) REFERENCES Evento(idEvento)
);

-- Tabela LogsPaginasSite
CREATE TABLE LogsPaginasSite (
  id INT PRIMARY KEY,
  sessoesAtivas INT,
  tempoDuracaoSessao DOUBLE,
  data DATE,
  novasSessoes INT,
  totalVisualizacaoPagina INT,
  logs_paginas_sitecol VARCHAR(45)
);
