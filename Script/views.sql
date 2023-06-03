-- View retorna quantos clientes que se cadastraram na semana e criaram um 'evento', e quantos clientes se cadastraram na semana
CREATE VIEW vw_clientes_acordo_1semana
AS
	SELECT
		'Fecharam' as Label, (SELECT COUNT(DISTINCT ID_USUARIO) FROM (SELECT ID_USUARIO FROM USUARIO INNER JOIN EVENTO ON USUARIO.ID_USUARIO = EVENTO.FK_CLIENTE WHERE DATEDIFF(CURDATE(), DATA_CADASTRO) <= 7 AND TIPO_USUARIO LIKE 1) AS ClientesImediatos) AS 'Quantidade'
	UNION
    SELECT
        'Não Fecharam' as Label, (SELECT COUNT(DISTINCT ID_USUARIO) FROM (SELECT ID_USUARIO FROM USUARIO WHERE DATEDIFF(CURDATE(), DATA_CADASTRO) <= 7 AND TIPO_USUARIO LIKE 1) AS CLIENTES_SEMANA) AS 'Quantidade';
 
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
			(SELECT COUNT(ID_USUARIO) FROM USUARIO WHERE TIMESTAMPDIFF(YEAR, DATA_NASCIMENTO, CURDATE()) > 18 AND TIMESTAMPDIFF(YEAR, DATA_NASCIMENTO, CURDATE()) <= 20 AND TIPO_USUARIO = 1) AS Quantidade
	UNION
	SELECT
		'21-25' AS Faixa,
			(SELECT COUNT(ID_USUARIO) FROM USUARIO WHERE TIMESTAMPDIFF(YEAR, DATA_NASCIMENTO, CURDATE()) > 20 AND TIMESTAMPDIFF(YEAR, DATA_NASCIMENTO, CURDATE()) <= 25 AND TIPO_USUARIO = 1) AS Quantidade
	UNION
	SELECT
		'26-30' AS Faixa,
			(SELECT COUNT(ID_USUARIO) FROM USUARIO WHERE TIMESTAMPDIFF(YEAR, DATA_NASCIMENTO, CURDATE()) > 25 AND TIMESTAMPDIFF(YEAR, DATA_NASCIMENTO, CURDATE()) <= 30 AND TIPO_USUARIO = 1) AS Quantidade
	UNION
	SELECT
		'31-35' AS Faixa,
		(SELECT COUNT(ID_USUARIO) FROM USUARIO WHERE TIMESTAMPDIFF(YEAR, DATA_NASCIMENTO, CURDATE()) > 30 AND TIMESTAMPDIFF(YEAR, DATA_NASCIMENTO, CURDATE()) <= 35 AND TIPO_USUARIO = 1) AS Quantidade
	UNION
	SELECT
		'36-40' AS Faixa,
		(SELECT COUNT(ID_USUARIO) FROM USUARIO WHERE TIMESTAMPDIFF(YEAR, DATA_NASCIMENTO, CURDATE()) > 35 AND TIMESTAMPDIFF(YEAR, DATA_NASCIMENTO, CURDATE()) <= 40 AND TIPO_USUARIO = 1) AS Quantidade
	UNION
	SELECT
		'41+' AS Faixa,
		(SELECT COUNT(ID_USUARIO) FROM USUARIO WHERE TIMESTAMPDIFF(YEAR, DATA_NASCIMENTO, CURDATE()) > 40 AND TIPO_USUARIO = 1) AS Quantidade;
        
        
-- Procedure que retorna contagem de usuario do tipo Cliente separados por faixa etária categorizados por tema (USAR WHERE)
-- Exemplo de chamada de procedure: CALL proc_faixa_etaria_cliente_tema('Casamentos')
DELIMITER //
CREATE PROCEDURE proc_faixa_etaria_cliente_tema
(
	TEMA_PARAM VARCHAR(100)
)
BEGIN
	SELECT
		'18-20' AS Faixa,
			(SELECT COUNT(DISTINCT EVENTO.FK_CLIENTE) AS QuantidadeClientes FROM EVENTO INNER JOIN USUARIO ON USUARIO.ID_USUARIO = EVENTO.FK_CLIENTE INNER JOIN TEMA ON TEMA.ID_TEMA = EVENTO.FK_TEMA WHERE TIMESTAMPDIFF(YEAR, USUARIO.DATA_NASCIMENTO, CURDATE()) > 18 AND TIMESTAMPDIFF(YEAR, USUARIO.DATA_NASCIMENTO, CURDATE()) <= 20 AND USUARIO.TIPO_USUARIO = 1 AND TEMA.NOME = TEMA_PARAM) AS Quantidade
	UNION
	SELECT
		'21-25' AS Faixa,
			(SELECT COUNT(DISTINCT EVENTO.FK_CLIENTE) AS QuantidadeClientes FROM EVENTO INNER JOIN USUARIO ON USUARIO.ID_USUARIO = EVENTO.FK_CLIENTE INNER JOIN TEMA ON TEMA.ID_TEMA = EVENTO.FK_TEMA WHERE TIMESTAMPDIFF(YEAR, USUARIO.DATA_NASCIMENTO, CURDATE()) > 21 AND TIMESTAMPDIFF(YEAR, USUARIO.DATA_NASCIMENTO, CURDATE()) <= 25 AND USUARIO.TIPO_USUARIO = 1 AND TEMA.NOME = TEMA_PARAM) AS Quantidade
	UNION
	SELECT
		'26-30' AS Faixa,
			(SELECT COUNT(DISTINCT EVENTO.FK_CLIENTE) AS QuantidadeClientes FROM EVENTO INNER JOIN USUARIO ON USUARIO.ID_USUARIO = EVENTO.FK_CLIENTE INNER JOIN TEMA ON TEMA.ID_TEMA = EVENTO.FK_TEMA WHERE TIMESTAMPDIFF(YEAR, USUARIO.DATA_NASCIMENTO, CURDATE()) > 25 AND TIMESTAMPDIFF(YEAR, USUARIO.DATA_NASCIMENTO, CURDATE()) <= 30 AND USUARIO.TIPO_USUARIO = 1 AND TEMA.NOME = TEMA_PARAM) AS Quantidade
	UNION
	SELECT
		'31-35' AS Faixa,
		(SELECT COUNT(DISTINCT EVENTO.FK_CLIENTE) AS QuantidadeClientes FROM EVENTO INNER JOIN USUARIO ON USUARIO.ID_USUARIO = EVENTO.FK_CLIENTE INNER JOIN TEMA ON TEMA.ID_TEMA = EVENTO.FK_TEMA WHERE TIMESTAMPDIFF(YEAR, USUARIO.DATA_NASCIMENTO, CURDATE()) > 30 AND TIMESTAMPDIFF(YEAR, USUARIO.DATA_NASCIMENTO, CURDATE()) <= 35 AND USUARIO.TIPO_USUARIO = 1 AND TEMA.NOME = TEMA_PARAM) AS Quantidade
	UNION
	SELECT
		'36-40' AS Faixa,
		(SELECT COUNT(DISTINCT EVENTO.FK_CLIENTE) AS QuantidadeClientes FROM EVENTO INNER JOIN USUARIO ON USUARIO.ID_USUARIO = EVENTO.FK_CLIENTE INNER JOIN TEMA ON TEMA.ID_TEMA = EVENTO.FK_TEMA WHERE TIMESTAMPDIFF(YEAR, USUARIO.DATA_NASCIMENTO, CURDATE()) > 45 AND TIMESTAMPDIFF(YEAR, USUARIO.DATA_NASCIMENTO, CURDATE()) <= 40 AND USUARIO.TIPO_USUARIO = 1 AND TEMA.NOME = TEMA_PARAM) AS Quantidade
	UNION
	SELECT
		'41+' AS Faixa,
		(SELECT COUNT(DISTINCT EVENTO.FK_CLIENTE) AS QuantidadeClientes FROM EVENTO INNER JOIN USUARIO ON USUARIO.ID_USUARIO = EVENTO.FK_CLIENTE INNER JOIN TEMA ON TEMA.ID_TEMA = EVENTO.FK_TEMA WHERE TIMESTAMPDIFF(YEAR, USUARIO.DATA_NASCIMENTO, CURDATE()) > 40 AND USUARIO.TIPO_USUARIO = 1) AS Quantidade;
END //
DELIMITER ;

-- View retorna quantos clientes são fotógrafos e quantos são clientes
CREATE VIEW vw_total_clientes_fotografos
AS
	SELECT
		'Clientes' as Label, (SELECT COUNT(ID_USUARIO) FROM USUARIO WHERE TIPO_USUARIO = 1) AS 'Quantidade'
	UNION
    SELECT
        'Fotógrafos' as Label, (SELECT COUNT(ID_USUARIO) FROM USUARIO WHERE TIPO_USUARIO = 2) AS 'Quantidade';
        
-- View retorna quantas sessões foram finalizadas e quantas foram canceladas
CREATE VIEW vw_total_sessoes_finalizadas_canceladas
AS
	SELECT
		'Convertidos' as Label, (SELECT COUNT(ID_EVENTO) FROM EVENTO WHERE STATUS_EVENTO LIKE 'Finalizado') AS 'Quantidade'
	UNION
    SELECT
        'Interrompidos' as Label, (SELECT COUNT(ID_EVENTO) FROM EVENTO WHERE STATUS_EVENTO LIKE 'Cancelado') AS 'Quantidade';
        
-- View KPI 1 - Total usuários e usuários cadastrados no último mês
CREATE VIEW vw_kpi_usuarios_mes
AS 
	SELECT 
		'Total' as Label, (SELECT COUNT(ID_USUARIO) FROM USUARIO) AS 'Quantidade'
	UNION 
    SELECT 
		'Mes' as Label, (SELECT COUNT(ID_USUARIO) FROM USUARIO WHERE DATEDIFF(CURDATE(), DATA_CADASTRO) <= 31)
	UNION 
    SELECT 
		'MesPassado' as Label, (SELECT COUNT(ID_USUARIO) FROM USUARIO WHERE DATEDIFF(CURDATE(), DATA_CADASTRO) > 31 AND DATEDIFF(CURDATE(), DATA_CADASTRO) <= 62);
        
-- View KPI 2 - Total de sessões de fotos realizadas        
CREATE VIEW vw_total_sessoes_realizadas
AS
	SELECT 
		'SessoesRealizadas' as Label, (SELECT COUNT(ID_EVENTO) FROM EVENTO WHERE STATUS_EVENTO = 'Finalizado')
	UNION
    SELECT 
		'SessoesRealizadasMes' as Label, (SELECT COUNT(ID_EVENTO) FROM EVENTO WHERE STATUS_EVENTO = 'Finalizado' AND DATEDIFF(CURDATE(), DATA_REALIZACAO) <= 31)
	UNION
    SELECT 
		'SessoesRealizadasMesPassado' as Label, (SELECT COUNT(ID_EVENTO) FROM EVENTO WHERE STATUS_EVENTO = 'Finalizado' AND DATEDIFF(CURDATE(), DATA_REALIZACAO) > 31 AND DATEDIFF(CURDATE(), DATA_REALIZACAO) <= 62);

-- View KPI 3 - Total de acessos          
CREATE VIEW vw_acessos_mes
AS
	SELECT 
		'Acessos' as Label, (SELECT COUNT(ID_USUARIO) FROM USUARIO WHERE ULTIMO_LOGIN > '1960-01-01')
	UNION
    SELECT 
		'AcessosMes' as Label, (SELECT COUNT(ID_USUARIO) FROM USUARIO WHERE DATEDIFF(CURDATE(), ULTIMO_LOGIN) <= 31)
	UNION
    SELECT 
		'AcessosMesPassado' as Label, (SELECT COUNT(ID_USUARIO) FROM USUARIO WHERE DATEDIFF(CURDATE(), ULTIMO_LOGIN) > 31 AND DATEDIFF(CURDATE(), ULTIMO_LOGIN) <= 62);
	