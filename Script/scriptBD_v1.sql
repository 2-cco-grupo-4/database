CREATE DATABASE picme;

USE picme;

-- Criação da tabela Usuario
CREATE TABLE Usuario (
    idUsuario INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(50),
    cpf VARCHAR(11),
    email VARCHAR(100),
    senha VARCHAR(100),
    dataNascimento DATE,
    celular VARCHAR(20),
    dataCadastro DATE,
    tipoUsuario VARCHAR(20),
    token VARCHAR(100)
);

-- Criação da tabela Tema
CREATE TABLE Tema (
    idTema INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(50)
);

-- Criação da tabela TemasUsuario
CREATE TABLE TemasUsuario (
    idTema INT,
    idUsuario INT,
    FOREIGN KEY (idTema) REFERENCES Tema(idTema),
    FOREIGN KEY (idUsuario) REFERENCES Usuario(idUsuario),
    PRIMARY KEY (idTema, idUsuario)
);

-- Criação da tabela Evento
CREATE TABLE Evento (
    idEvento INT AUTO_INCREMENT PRIMARY KEY,
    dataRealizacao DATE,
    status VARCHAR(20),
    fkFotografo INT,
    fkTema INT,
    fkCliente INT,
    valor DECIMAL(10, 2),
    avaliacao INT,
    FOREIGN KEY (fkFotografo) REFERENCES Usuario(idUsuario),
    FOREIGN KEY (fkTema) REFERENCES Tema(idTema),
    FOREIGN KEY (fkCliente) REFERENCES Usuario(idUsuario)
);

-- Criação da tabela Endereco
CREATE TABLE Endereco (
    idEndereco INT AUTO_INCREMENT PRIMARY KEY,
    estado VARCHAR(50),
    cidade VARCHAR(50),
    cep VARCHAR(10),
    bairro VARCHAR(50),
    rua VARCHAR(100),
    numero VARCHAR(10),
    complemento VARCHAR(100),
    fkEndereco INT,
    FOREIGN KEY (fkEndereco) REFERENCES Evento(idEvento)
);

-- Criação da tabela Album
CREATE TABLE Album (
    idAlbum INT AUTO_INCREMENT PRIMARY KEY,
    titulo VARCHAR(100),
    fkFotografo INT,
    fkTema INT,
    FOREIGN KEY (fkFotografo) REFERENCES Usuario(idUsuario),
    FOREIGN KEY (fkTema) REFERENCES Tema(idTema)
);

-- Criação da tabela Imagem
CREATE TABLE Imagem (
    idImagem INT AUTO_INCREMENT PRIMARY KEY,
    url VARCHAR(200),
    idDono INT,
    momento DATE,
    fkAlbum INT,
    FOREIGN KEY (idDono) REFERENCES Usuario(idUsuario),
    FOREIGN KEY (fkAlbum) REFERENCES Album(idAlbum)
);

-- Criação da tabela Tag
CREATE TABLE Tag (
    idTag INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(50)
);

-- Criação da tabela TagsImagem
CREATE TABLE TagsImagem (
    idImagem INT,
    idTag INT,
    FOREIGN KEY (idImagem) REFERENCES Imagem(idImagem),
    FOREIGN KEY (idTag) REFERENCES Tag(idTag),
    PRIMARY KEY (idImagem, idTag)
);