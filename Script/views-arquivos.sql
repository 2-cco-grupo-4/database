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