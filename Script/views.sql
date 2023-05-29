-- View retorna quantos clientes que se cadastraram na semana e criaram um 'evento', e quantos clientes se cadastraram na semana
CREATE VIEW vw_clientes_acordo_1semana
AS
	SELECT
		(SELECT COUNT(DISTINCT ID_USUARIO) FROM (SELECT ID_USUARIO FROM USUARIO INNER JOIN EVENTO ON USUARIO.ID_USUARIO = EVENTO.FK_CLIENTE WHERE DATEDIFF(CURDATE(), DATA_CADASTRO) <= 7 AND TIPO_USUARIO LIKE 'Cliente') AS ClientesImediatos) AS 'Clientes com Contato',
        (SELECT COUNT(DISTINCT ID_USUARIO) FROM (SELECT ID_USUARIO FROM USUARIO WHERE DATEDIFF(CURDATE(), DATA_CADASTRO) <= 7 AND TIPO_USUARIO LIKE 'Cliente') AS CLIENTES_SEMANA) AS 'Clientes Totais';
 
-- View retorna contagem de quantos contatos foram iniciados para cada tema cadastrado 
CREATE VIEW vw_contagem_tema_contato
AS
	SELECT
		NOME AS Tema,
		COUNT(FK_TEMA) AS Contatos
	FROM
		EVENTO
	INNER JOIN
		TEMA ON EVENTO.FK_TEMA = TEMA.ID_TEMA
	GROUP BY
		NOME;

        
-- View que retorna contagem de usuario do tipo Cliente separados por faixa etária
CREATE VIEW vw_faixa_etaria_cliente
AS
	SELECT
		'18-20' AS Faixa,
			(SELECT COUNT(ID_USUARIO) FROM USUARIO WHERE TIMESTAMPDIFF(YEAR, DATA_NASCIMENTO, CURDATE()) > 18 AND TIMESTAMPDIFF(YEAR, DATA_NASCIMENTO, CURDATE()) <= 20 AND TIPO_USUARIO = 'Cliente') AS Quantidade
	UNION
	SELECT
		'21-25' AS Faixa,
			(SELECT COUNT(ID_USUARIO) FROM USUARIO WHERE TIMESTAMPDIFF(YEAR, DATA_NASCIMENTO, CURDATE()) > 20 AND TIMESTAMPDIFF(YEAR, DATA_NASCIMENTO, CURDATE()) <= 25 AND TIPO_USUARIO = 'Cliente') AS Quantidade
	UNION
	SELECT
		'26-30' AS Faixa,
			(SELECT COUNT(ID_USUARIO) FROM USUARIO WHERE TIMESTAMPDIFF(YEAR, DATA_NASCIMENTO, CURDATE()) > 25 AND TIMESTAMPDIFF(YEAR, DATA_NASCIMENTO, CURDATE()) <= 30 AND TIPO_USUARIO = 'Cliente') AS Quantidade
	UNION
	SELECT
		'31-35' AS Faixa,
		(SELECT COUNT(ID_USUARIO) FROM USUARIO WHERE TIMESTAMPDIFF(YEAR, DATA_NASCIMENTO, CURDATE()) > 30 AND TIMESTAMPDIFF(YEAR, DATA_NASCIMENTO, CURDATE()) <= 35 AND TIPO_USUARIO = 'Cliente') AS Quantidade
	UNION
	SELECT
		'36-40' AS Faixa,
		(SELECT COUNT(ID_USUARIO) FROM USUARIO WHERE TIMESTAMPDIFF(YEAR, DATA_NASCIMENTO, CURDATE()) > 35 AND TIMESTAMPDIFF(YEAR, DATA_NASCIMENTO, CURDATE()) <= 40 AND TIPO_USUARIO = 'Cliente') AS Quantidade
	UNION
	SELECT
		'41+' AS Faixa,
		(SELECT COUNT(ID_USUARIO) FROM USUARIO WHERE TIMESTAMPDIFF(YEAR, DATA_NASCIMENTO, CURDATE()) > 40 AND TIPO_USUARIO = 'Cliente') AS Quantidade;