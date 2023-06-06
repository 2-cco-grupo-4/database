INSERT INTO usuario (nome, cpf, email, senha, data_nascimento, autenticado, celular, data_cadastro, tipo_usuario, token_solicitacao, ultimo_login)
VALUES
  ('João Silva', '12345678901', 'joao@email.com', '$2a$12$axo/lw5G1O.WmrU0mbSyvuDn7TNwmc4j5OhRsyvEMarMLvTF3ISxK', '1990-01-01', 1, '9999999999', '2023-05-01', 1, 'token123', '2023-03-01'),
  ('Maria Santos', '98765432101', 'maria@email.com', '$2a$12$axo/lw5G1O.WmrU0mbSyvuDn7TNwmc4j5OhRsyvEMarMLvTF3ISxK', '1995-02-15', 1, '8888888888', '2023-05-02', 2, 'token456', '2023-02-28'),
  ('Pedro Oliveira', '54321678901', 'pedro@email.com', '$2a$12$axo/lw5G1O.WmrU0mbSyvuDn7TNwmc4j5OhRsyvEMarMLvTF3ISxK', '1988-08-20', 0, '7777777777', '2023-05-03', 1, NULL, NULL),
  ('Ana Souza', '98765432102', 'ana@email.com', '$2a$12$axo/lw5G1O.WmrU0mbSyvuDn7TNwmc4j5OhRsyvEMarMLvTF3ISxK', '1992-04-10', 1, '6666666666', '2023-05-04', 1, 'token789', '2023-01-31'),
  ('Lucas Santos', '12345098765', 'lucas@email.com', '$2a$12$axo/lw5G1O.WmrU0mbSyvuDn7TNwmc4j5OhRsyvEMarMLvTF3ISxK', '1993-11-25', 1, '5555555555', '2023-05-05', 2, 'tokenabc', '2023-03-05'),
  ('Élise Dupont', '111.111.111-11', 'elise.dupont@example.com', '$2a$12$axo/lw5G1O.WmrU0mbSyvuDn7TNwmc4j5OhRsyvEMarMLvTF3ISxK', '1990-05-15', 1, '(11) 99999-1111', '2023-05-28', 1, 'abc123', '2023-01-28'),
  ('Lucas Lefebvre', '222.222.222-22', 'lucas.lefebvre@example.com', '$2a$12$axo/lw5G1O.WmrU0mbSyvuDn7TNwmc4j5OhRsyvEMarMLvTF3ISxK', '1995-08-23', 1, '(11) 99999-2222', '2023-05-28', 1, 'def456', '2023-01-30'),
  ('Léa Martin', '333.333.333-33', 'lea.martin@example.com', '$2a$12$axo/lw5G1O.WmrU0mbSyvuDn7TNwmc4j5OhRsyvEMarMLvTF3ISxK', '1988-03-10', 1, '(11) 99999-3333', '2023-05-28', 2, 'ghi789', '2023-03-15'),
  ('Tom Lefevre', '888.888.888-88', 'tom.lefevre@example.com', '$2a$12$axo/lw5G1O.WmrU0mbSyvuDn7TNwmc4j5OhRsyvEMarMLvTF3ISxK', '1989-04-03', 1, '(11) 99999-8888', '2023-05-28', 2, '678stu', '2023-01-27'),
  ('Louise Simon', '999.999.999-99', 'louise.simon@example.com', '$2a$12$axo/lw5G1O.WmrU0mbSyvuDn7TNwmc4j5OhRsyvEMarMLvTF3ISxK', '1993-12-18', 1, '(11) 99999-9999', '2023-05-28', 1, '890vwx', '2023-03-02'),
  ('John Smith', '12345678901', 'john@example.com', '$2a$12$axo/lw5G1O.WmrU0mbSyvuDn7TNwmc4j5OhRsyvEMarMLvTF3ISxK', '1990-01-01', 1, '9999999999', '2023-05-01', 1, 'token123', NOW() - INTERVAL '1' DAY),
  ('Mary Johnson', '98765432101', 'mary@example.com', '$2a$12$axo/lw5G1O.WmrU0mbSyvuDn7TNwmc4j5OhRsyvEMarMLvTF3ISxK', '1995-02-15', 1, '8888888888', '2023-05-02', 2, 'token456', NOW() - INTERVAL '2' DAY),
  ('Robert Williams', '54321678901', 'robert@example.com', '$2a$12$axo/lw5G1O.WmrU0mbSyvuDn7TNwmc4j5OhRsyvEMarMLvTF3ISxK', '1988-08-20', 0, '7777777777', '2023-05-03', 1, NULL, NULL),
  ('Jennifer Brown', '98765432102', 'jennifer@example.com', '$2a$12$axo/lw5G1O.WmrU0mbSyvuDn7TNwmc4j5OhRsyvEMarMLvTF3ISxK', '1992-04-10', 1, '6666666666', '2023-05-04', 1, 'token789', NOW() - INTERVAL '3' DAY),
  ('Michael Davis', '12345098765', 'michael@example.com', '$2a$12$axo/lw5G1O.WmrU0mbSyvuDn7TNwmc4j5OhRsyvEMarMLvTF3ISxK', '1993-11-25', 1, '5555555555', '2023-05-05', 2, 'tokenabc', NOW() - INTERVAL '4' DAY),
  ('Linda Johnson', '111.111.111-11', 'linda@example.com', '$2a$12$axo/lw5G1O.WmrU0mbSyvuDn7TNwmc4j5OhRsyvEMarMLvTF3ISxK', '1990-05-15', 1, '(11) 99999-1111', '2023-05-28', 1, 'abc123', NOW() - INTERVAL '5' DAY),
  ('William Miller', '222.222.222-22', 'william@example.com', '$2a$12$axo/lw5G1O.WmrU0mbSyvuDn7TNwmc4j5OhRsyvEMarMLvTF3ISxK', '1995-08-23', 1, '(11) 99999-2222', '2023-05-28', 1, 'def456', NOW() - INTERVAL '6' DAY),
  ('Karen Anderson', '333.333.333-33', 'karen@example.com', '$2a$12$axo/lw5G1O.WmrU0mbSyvuDn7TNwmc4j5OhRsyvEMarMLvTF3ISxK', '1988-03-10', 1, '(11) 99999-3333', '2023-05-28', 2, 'ghi789', NOW() - INTERVAL '7' DAY),
  ('David Thompson', '888.888.888-88', 'david@example.com', '$2a$12$axo/lw5G1O.WmrU0mbSyvuDn7TNwmc4j5OhRsyvEMarMLvTF3ISxK', '1989-04-03', 1, '(11) 99999-8888', '2023-05-28', 2, '678stu', NOW() - INTERVAL '8' DAY),
  ('Susan Clark', '999.999.999-99', 'susan@example.com', '$2a$12$axo/lw5G1O.WmrU0mbSyvuDn7TNwmc4j5OhRsyvEMarMLvTF3ISxK', '1993-12-18', 1, '(11) 99999-9999', '2023-05-28', 1, '890vwx', NOW() - INTERVAL '9' DAY),
  ('James Wilson', '11122233344', 'james@example.com', '$2a$12$axo/lw5G1O.WmrU0mbSyvuDn7TNwmc4j5OhRsyvEMarMLvTF3ISxK', '1987-07-12', 1, '4445556666', '2023-05-28', 1, 'abc123', NOW() - INTERVAL '10' DAY),
  ('Sarah Taylor', '55566677788', 'sarah@example.com', '$2a$12$axo/lw5G1O.WmrU0mbSyvuDn7TNwmc4j5OhRsyvEMarMLvTF3ISxK', '1991-03-24', 1, '7778889999', '2023-05-28', 2, 'def456', NOW() - INTERVAL '11' DAY),
  ('Christopher Anderson', '12345678910', 'christopher@example.com', '$2a$12$axo/lw5G1O.WmrU0mbSyvuDn7TNwmc4j5OhRsyvEMarMLvTF3ISxK', '1994-09-05', 1, '1112223333', '2023-05-28', 1, 'ghi789', NOW() - INTERVAL '12' DAY),
  ('Jessica Martinez', '10111213141', 'jessica@example.com', '$2a$12$axo/lw5G1O.WmrU0mbSyvuDn7TNwmc4j5OhRsyvEMarMLvTF3ISxK', '1996-11-08', 1, '4445556666', '2023-05-28', 1, '678stu', NOW() - INTERVAL '13' DAY),
  ('Matthew Davis', '15161718192', 'matthew@example.com', '$2a$12$axo/lw5G1O.WmrU0mbSyvuDn7TNwmc4j5OhRsyvEMarMLvTF3ISxK', '1985-05-30', 1, '7778889999', '2023-05-28', 2, '890vwx', NOW() - INTERVAL '14' DAY),
  ('Emily Thompson', '20212223242', 'emily@example.com', '$2a$12$axo/lw5G1O.WmrU0mbSyvuDn7TNwmc4j5OhRsyvEMarMLvTF3ISxK', '1992-02-03', 1, '1112223333', '2023-05-28', 1, 'abc123', NOW() - INTERVAL '15' DAY),
  ('Daniel Johnson', '25262728293', 'daniel@example.com', '$2a$12$axo/lw5G1O.WmrU0mbSyvuDn7TNwmc4j5OhRsyvEMarMLvTF3ISxK', '1989-06-17', 1, '4445556666', '2023-05-28', 1, 'def456', NOW() - INTERVAL '16' DAY),
  ('Ashley Smith', '30313233343', 'ashley@example.com', '$2a$12$axo/lw5G1O.WmrU0mbSyvuDn7TNwmc4j5OhRsyvEMarMLvTF3ISxK', '1993-10-21', 1, '7778889999', '2023-05-28', 2, 'ghi789', NOW() - INTERVAL '17' DAY),
  ('Joseph Wilson', '34353637383', 'joseph@example.com', '$2a$12$axo/lw5G1O.WmrU0mbSyvuDn7TNwmc4j5OhRsyvEMarMLvTF3ISxK', '1997-01-14', 1, '1112223333', '2023-05-28', 1, '678stu', NOW() - INTERVAL '18' DAY),
  ('Olivia Taylor', '38394041424', 'olivia@example.com', '$2a$12$axo/lw5G1O.WmrU0mbSyvuDn7TNwmc4j5OhRsyvEMarMLvTF3ISxK', '1990-12-02', 1, '4445556666', '2023-05-28', 1, '890vwx', NOW() - INTERVAL '19' DAY),
  ('Andrew Anderson', '41424344454', 'andrew@example.com', '$2a$12$axo/lw5G1O.WmrU0mbSyvuDn7TNwmc4j5OhRsyvEMarMLvTF3ISxK', '1988-08-09', 1, '7778889999', '2023-05-28', 2, 'abc123', NOW() - INTERVAL '20' DAY),
  ('Elizabeth Martinez', '44454647484', 'elizabeth@example.com', '$2a$12$axo/lw5G1O.WmrU0mbSyvuDn7TNwmc4j5OhRsyvEMarMLvTF3ISxK', '1994-04-27', 1, '1112223333', '2023-05-28', 1, 'def456', NOW() - INTERVAL '21' DAY),
  ('Joshua Davis', '45464748495', 'joshua@example.com', '$2a$12$axo/lw5G1O.WmrU0mbSyvuDn7TNwmc4j5OhRsyvEMarMLvTF3ISxK', '1987-09-23', 1, '4445556666', '2023-05-28', 1, 'ghi789', NOW() - INTERVAL '22' DAY),
  ('Amanda Thompson', '49505152535', 'amanda@example.com', '$2a$12$axo/lw5G1O.WmrU0mbSyvuDn7TNwmc4j5OhRsyvEMarMLvTF3ISxK', '1991-08-12', 1, '7778889999', '2023-05-28', 2, '678stu', NOW() - INTERVAL '23' DAY),
  ('Justin Johnson', '51525354555', 'justin@example.com', '$2a$12$axo/lw5G1O.WmrU0mbSyvuDn7TNwmc4j5OhRsyvEMarMLvTF3ISxK', '1996-06-05', 1, '1112223333', '2023-05-28', 1, '890vwx', NOW() - INTERVAL '24' DAY),
  ('Samantha Smith', '55565758596', 'samantha@example.com', '$2a$12$axo/lw5G1O.WmrU0mbSyvuDn7TNwmc4j5OhRsyvEMarMLvTF3ISxK', '1985-02-19', 1, '4445556666', '2023-05-28', 1, 'abc123', NOW() - INTERVAL '25' DAY),
  ('Ryan Taylor', '56575859606', 'ryan@example.com', '$2a$12$axo/lw5G1O.WmrU0mbSyvuDn7TNwmc4j5OhRsyvEMarMLvTF3ISxK', '1992-11-27', 1, '7778889999', '2023-05-28', 2, 'def456', NOW() - INTERVAL '26' DAY),
  ('Melissa Anderson', '60616362636', 'melissa@example.com', '$2a$12$axo/lw5G1O.WmrU0mbSyvuDn7TNwmc4j5OhRsyvEMarMLvTF3ISxK', '1989-05-14', 1, '1112223333', '2023-05-28', 1, 'ghi789', NOW() - INTERVAL '27' DAY),
  ('Nathan Wilson', '63646566676', 'nathan@example.com', '$2a$12$axo/lw5G1O.WmrU0mbSyvuDn7TNwmc4j5OhRsyvEMarMLvTF3ISxK', '1993-04-08', 1, '4445556666', '2023-05-28', 1, '678stu', NOW() - INTERVAL '28' DAY),
  ('Lauren Taylor', '66676869706', 'lauren@example.com', '$2a$12$axo/lw5G1O.WmrU0mbSyvuDn7TNwmc4j5OhRsyvEMarMLvTF3ISxK', '1997-07-15', 1, '7778889999', '2023-05-28', 2, '890vwx', NOW() - INTERVAL '29' DAY),
  ('Brandon Davis', '69707172776', 'brandon@example.com', '$2a$12$axo/lw5G1O.WmrU0mbSyvuDn7TNwmc4j5OhRsyvEMarMLvTF3ISxK', '1990-03-26', 1, '1112223333', '2023-05-28', 1, 'abc123', NOW() - INTERVAL '30' DAY);

insert into usuario(nome, email, senha, autenticado, tipo_usuario) values ("admin", "admin@email.com", "$2a$12$knaHdd7zsqEV70S4gtOJsOtuVzV7q1iIUvE/hVcRJTdyuMl.Rhyo6", 0, 0);

INSERT INTO tema (nome)
VALUES
  ('Retratos'),
  ('Natureza'),
  ('Casamentos'),
  ('Paisagens'),
  ('Animais');


INSERT INTO usuario_tema (id_usuario, id_tema)
VALUES
  (1, 2),
  (1, 3),
  (2, 2),
  (2, 4),
  (3, 3),
  (3, 5),
  (4, 2),
  (5, 2),
  (5, 4);


INSERT INTO evento (data_realizacao, status_evento, fk_fotografo, fk_tema, fk_cliente, valor)
VALUES
  ('2023-06-10', 'Confirmado', 3, 3, 2, 500.00),
  ('2023-07-05', 'Pendente', 3, 1, 3, 350.00),
  ('2023-08-20', 'Confirmado', 5, 2, 4, 700.00),
  ('2023-09-15', 'Pendente', 5, 4, 2, 400.00),
  ('2023-10-12', 'Cancelado', 3, 5, 5, 250.00),
  ('2023-06-20', 'Proposta', 3, 1, 3, 400.00),
  ('2023-06-25', 'Negociando', 4, 2, 2, 600.00),
  ('2023-07-01', 'Confirmado', 5, 3, 2, 800.00),
  ('2023-07-05', 'Cancelado', 3, 4, 5, 300.00),
  ('2023-07-10', 'Finalizado', 2, 5, 4, 700.00),
  ('2023-07-15', 'Proposta', 3, 1, 3, 450.00),
  ('2023-07-20', 'Negociando', 4, 2, 5, 550.00),
  ('2023-07-25', 'Confirmado', 2, 3, 2, 900.00),
  ('2023-07-30', 'Cancelado', 5, 4, 2, 350.00),
  ('2023-08-05', 'Finalizado', 3, 5, 4, 750.00),
  ('2023-08-10', 'Proposta', 3, 1, 3, 400.00),
  ('2023-08-15', 'Negociando', 5, 2, 4, 550.00),
  ('2023-08-20', 'Confirmado', 2, 3, 2, 800.00),
  ('2023-08-25', 'Cancelado', 4, 4, 5, 300.00),
  ('2023-08-30', 'Finalizado', 3, 5, 2, 700.00),
  ('2023-09-05', 'Proposta', 3, 1, 3, 450.00),
  ('2023-09-10', 'Negociando', 4, 2, 2, 600.00),
  ('2023-09-15', 'Confirmado', 5, 3, 2, 850.00),
  ('2023-09-20', 'Cancelado', 2, 4, 4, 350.00),
  ('2023-09-25', 'Finalizado', 3, 5, 5, 800.00),
  ('2023-10-01', 'Proposta', 3, 1, 3, 400.00),
  ('2023-10-05', 'Negociando', 4, 2, 2, 550.00),
  ('2023-10-10', 'Confirmado', 2, 3, 2, 900.00),
  ('2023-10-15', 'Cancelado', 5, 4, 3, 300.00),
  ('2023-10-20', 'Finalizado', 3, 5, 4, 750.00),
  ('2023-10-25', 'Proposta', 3, 1, 2, 400.00),
  ('2023-10-30', 'Negociando', 5, 2, 4, 600.00),
  ('2023-11-05', 'Confirmado', 2, 3, 2, 850.00),
  ('2023-11-10', 'Cancelado', 4, 4, 3, 350.00),
  ('2023-11-15', 'Finalizado', 3, 5, 5, 800.00),
  ('2023-11-20', 'Proposta', 3, 1, 2, 450.00),
  ('2023-11-25', 'Negociando', 4, 2, 2, 600.00),
  ('2023-11-30', 'Confirmado', 2, 3, 3, 900.00),
  ('2023-12-05', 'Cancelado', 5, 4, 2, 350.00),
  ('2023-12-10', 'Finalizado', 3, 5, 2, 750.00),
  ('2023-12-15', 'Proposta', 3, 1, 4, 400.00),
  ('2023-12-20', 'Negociando', 4, 2, 5, 550.00),
  ('2023-12-25', 'Confirmado', 2, 3, 2, 800.00),
  ('2023-12-30', 'Cancelado', 5, 4, 2, 300.00),
  ('2024-01-05', 'Finalizado', 3, 5, 3, 700.00),
  ('2024-01-10', 'Proposta', 3, 1, 5, 450.00),
  ('2024-01-15', 'Negociando', 5, 2, 2, 600.00),
  ('2023-03-30', 'Finalizado', 2, 3, 3, 900.00),
  ('2023-01-05', 'Finalizado', 5, 4, 2, 350.00),
  ('2022-12-10', 'Finalizado', 3, 5, 2, 750.00),
  ('2023-04-15', 'Finalizado', 3, 1, 4, 400.00),
  ('2023-05-20', 'Finalizado', 4, 2, 5, 550.00),
  ('2023-05-25', 'Finalizado', 3, 3, 2, 800.00),
  ('2023-01-30', 'Finalizado', 5, 4, 2, 300.00),
  ('2024-03-05', 'Finalizado', 3, 5, 3, 700.00),
  ('2024-05-10', 'Finalizado', 3, 1, 5, 450.00);
      
INSERT INTO endereco (estado, cidade, cep, bairro, logradouro, numero, complemento, fk_evento)
VALUES
  ('São Paulo', 'São Paulo', '01234-567', 'Centro', 'Rua A', '123', 'Apto 4', 1),
  ('Rio de Janeiro', 'Rio de Janeiro', '98765-432', 'Copacabana', 'Avenida B', '456', NULL, 2),
  ('São Paulo', 'São Paulo', '01234-567', 'Centro', 'Rua C', '789', 'Casa 2', 3),
  ('Rio de Janeiro', 'Rio de Janeiro', '98765-432', 'Ipanema', 'Avenida D', '1011', NULL, 4),
  ('São Paulo', 'São Paulo', '01234-567', 'Centro', 'Rua E', '1213', 'Apto 5', 5);


INSERT INTO album (titulo, descricao, fk_fotografo, fk_tema)
VALUES
  ('Álbum 1', 'Fotos do evento 1', 2, 3),
  ('Álbum 2', 'Fotos do evento 2', 2, 1),
  ('Álbum 3', 'Fotos do evento 3', 5, 2),
  ('Álbum 4', 'Fotos do evento 4', 5, 4),
  ('Álbum 5', 'Fotos do evento 5', 2, 5);


INSERT INTO imagem (caminho, descricao, formato, fk_album)
VALUES
  ('caminho1.jpg', 'Foto 1', 'jpg', 1),
  ('caminho2.jpg', 'Foto 2', 'jpg', 1),
  ('caminho3.jpg', 'Foto 3', 'jpg', 2),
  ('caminho4.jpg', 'Foto 4', 'jpg', 3),
  ('caminho5.jpg', 'Foto 5', 'jpg', 4),
  ('caminho6.jpg', 'Foto 6', 'jpg', 5);


INSERT INTO tag (id_tag, nome)
VALUES
  (1, 'Casamento'),
  (2, 'Retrato'),
  (3, 'Natureza'),
  (4, 'Animais'),
  (5, 'Paisagem');



INSERT INTO tag_imagem (id_imagem, id_tag)
VALUES
  (1, 1),
  (2, 2),
  (3, 3),
  (4, 4),
  (5, 5),
  (6, 1),
  (6, 2);


INSERT INTO interesse_tag (id_tag, id_usuario)
VALUES
  (1, 1),
  (2, 1),
  (2, 2),
  (3, 3),
  (3, 5),
  (4, 4),
  (4, 5),
  (5, 1),
  (5, 2);


INSERT INTO log_pagina_site (id_log_pagina_site, sessao_ativa, tempo_duracao_sessao, data_sessao, qtd_nova_sessao, total_view_pagina, log_pagina_sitecol)
VALUES
  (1, 1, 120.5, '2023-05-01', 5, 10, 'Página 1'),
  (2, 0, 60.2, '2023-05-02', 3, 8, 'Página 2'),
  (3, 1, 180.8, '2023-05-03', 7, 15, 'Página 1'),
  (4, 0, 90.3, '2023-05-04', 4, 12, 'Página 3'),
  (5, 1, 150.0, '2023-05-05', 6, 11, 'Página 2');
