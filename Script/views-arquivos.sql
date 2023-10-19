USE PICME;

-- View para exportação do arquivo plain text (TXT) de preferências dos usuários em relação aos temas
CREATE VIEW vw_export_usuario_preferencias_temas AS
SELECT 
	tb_usuario.id_usuario, 
	tb_usuario.nome AS 'nome_user', 
	data_nascimento, 
	celular, 
	data_cadastro, 
	tipo_usuario, 
	cidade_preferencia, 
	estado_preferencia, 
	tb_tema.id_tema, 
	tb_tema.nome AS 'nome_tema' 
FROM tb_usuario
INNER JOIN tb_usuario_tema
ON
	tb_usuario.id_usuario = tb_usuario_tema.id_usuario
INNER JOIN tb_tema
ON
	tb_usuario_tema.id_tema = tb_tema.id_tema;
	

-- View para exportação do arquivo CSV com as sessões do fotógrafo na plataforma
drop view vw_export_csv_sessoes_fotografo;

CREATE VIEW vw_export_csv_sessoes_fotografo AS
SELECT
	tb_usuario.id_usuario AS 'ID_FOTOGRAFO',
	(SELECT tb_usuario.nome FROM tb_usuario WHERE id_usuario = tb_sessao.fk_cliente) AS 'NOME_CLIENTE',
	tb_tema.nome  AS 'TEMA',
	tb_sessao.status_sessao AS 'STATUS',
	tb_sessao.data_realizacao AS 'DATA_SESSAO',
	tb_endereco.logradouro AS 'RUA',
	tb_endereco.numero AS 'NUMERO',
	tb_endereco.complemento AS 'COMPLEMENTO',
	tb_endereco.bairro AS 'BAIRRO',
	tb_endereco.cep AS 'CEP',
	tb_endereco.cidade AS 'CIDADE',
	tb_endereco.estado  AS 'ESTADO',
	tb_pagamento.forma AS 'FORMA_PAGAMENTO',
	tb_pagamento.valor AS 'VALOR',
	tb_pagamento.parcelas 'PARCELAS'
FROM tb_usuario
INNER JOIN
	tb_sessao ON tb_usuario.id_usuario = tb_sessao.fk_fotografo
INNER JOIN
	tb_tema ON tb_sessao.fk_tema = tb_tema.id_tema
INNER JOIN
	tb_endereco ON tb_endereco.fk_sessao = tb_sessao.id_sessao
INNER JOIN
	tb_pagamento ON tb_pagamento.fk_sessao = tb_sessao.id_sessao;