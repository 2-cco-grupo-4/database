SET lc_time_names = 'pt_BR';

-- View retorna quantos clientes que se cadastraram na semana e criaram um 'evento', e quantos clientes se cadastraram na semana
CREATE VIEW vw_clientes_acordo_1semana
AS
	SELECT
		'Fecharam' as Label, (SELECT COUNT(DISTINCT id_usuario) FROM (SELECT id_usuario FROM usuario INNER JOIN evento ON usuario.id_usuario = evento.fk_cliente WHERE DATEDIFF(CURDATE(), data_cadastro) <= 7 AND tipo_usuario LIKE 1) AS ClientesImediatos) AS 'Quantidade'
	UNION
    SELECT
        'Não Fecharam' as Label, (SELECT COUNT(DISTINCT id_usuario) FROM (SELECT id_usuario FROM usuario WHERE DATEDIFF(CURDATE(), data_cadastro) <= 7 AND tipo_usuario LIKE 1) AS clientes_semana) AS 'Quantidade';
 
-- View retorna contagem de quantos contatos foram iniciados para cada tema cadastrado 
CREATE VIEW vw_contagem_tema_contato
AS
	SELECT
		nome AS Tema,
		COUNT(fk_tema) AS Contatos
	FROM
		evento
	INNER JOIN
		tema ON evento.fk_tema = tema.id_tema
	GROUP BY
		nome;

        
-- View que retorna contagem de usuario do tipo Cliente separados por faixa etária
CREATE VIEW vw_faixa_etaria_cliente
AS
	SELECT
		'18-20' AS Faixa,
			(SELECT COUNT(id_usuario) FROM usuario WHERE TIMESTAMPDIFF(YEAR, data_nascimento, CURDATE()) > 18 AND TIMESTAMPDIFF(YEAR, data_nascimento, CURDATE()) <= 20 AND tipo_usuario = 1) AS Quantidade
	UNION
	SELECT
		'21-25' AS Faixa,
			(SELECT COUNT(id_usuario) FROM usuario WHERE TIMESTAMPDIFF(YEAR, data_nascimento, CURDATE()) > 20 AND TIMESTAMPDIFF(YEAR, data_nascimento, CURDATE()) <= 25 AND tipo_usuario = 1) AS Quantidade
	UNION
	SELECT
		'26-30' AS Faixa,
			(SELECT COUNT(id_usuario) FROM usuario WHERE TIMESTAMPDIFF(YEAR, data_nascimento, CURDATE()) > 25 AND TIMESTAMPDIFF(YEAR, data_nascimento, CURDATE()) <= 30 AND tipo_usuario = 1) AS Quantidade
	UNION
	SELECT
		'31-35' AS Faixa,
		(SELECT COUNT(id_usuario) FROM usuario WHERE TIMESTAMPDIFF(YEAR, data_nascimento, CURDATE()) > 30 AND TIMESTAMPDIFF(YEAR, data_nascimento, CURDATE()) <= 35 AND tipo_usuario = 1) AS Quantidade
	UNION
	SELECT
		'36-40' AS Faixa,
		(SELECT COUNT(id_usuario) FROM usuario WHERE TIMESTAMPDIFF(YEAR, data_nascimento, CURDATE()) > 35 AND TIMESTAMPDIFF(YEAR, data_nascimento, CURDATE()) <= 40 AND tipo_usuario = 1) AS Quantidade
	UNION
	SELECT
		'41+' AS Faixa,
		(SELECT COUNT(id_usuario) FROM usuario WHERE TIMESTAMPDIFF(YEAR, data_nascimento, CURDATE()) > 40 AND tipo_usuario = 1) AS Quantidade;
        
        
-- Procedure que retorna contagem de usuario do tipo Cliente separados por faixa etária categorizados por tema (USAR WHERE)
-- Exemplo de chamada de procedure: CALL proc_faixa_etaria_cliente_tema('Casamentos')
DELIMITER //
CREATE PROCEDURE proc_faixa_etaria_cliente_tema
(
	tema_param VARCHAR(100)
)
BEGIN
	SELECT
		'18-20' AS Faixa,
			(SELECT COUNT(DISTINCT evento.fk_cliente) AS QuantidadeClientes FROM evento INNER JOIN usuario ON usuario.id_usuario = evento.fk_cliente INNER JOIN tema ON tema.id_tema = evento.fk_tema WHERE TIMESTAMPDIFF(YEAR, usuario.data_nascimento, CURDATE()) > 18 AND TIMESTAMPDIFF(YEAR, usuario.data_nascimento, CURDATE()) <= 20 AND usuario.tipo_usuario = 1 AND tema.nome = tema_param) AS Quantidade
	UNION
	SELECT
		'21-25' AS Faixa,
			(SELECT COUNT(DISTINCT evento.fk_cliente) AS QuantidadeClientes FROM evento INNER JOIN usuario ON usuario.id_usuario = evento.fk_cliente INNER JOIN tema ON tema.id_tema = evento.fk_tema WHERE TIMESTAMPDIFF(YEAR, usuario.data_nascimento, CURDATE()) > 21 AND TIMESTAMPDIFF(YEAR, usuario.data_nascimento, CURDATE()) <= 25 AND usuario.tipo_usuario = 1 AND tema.nome = tema_param) AS Quantidade
	UNION
	SELECT
		'26-30' AS Faixa,
			(SELECT COUNT(DISTINCT evento.fk_cliente) AS QuantidadeClientes FROM evento INNER JOIN usuario ON usuario.id_usuario = evento.fk_cliente INNER JOIN tema ON tema.id_tema = evento.fk_tema WHERE TIMESTAMPDIFF(YEAR, usuario.data_nascimento, CURDATE()) > 25 AND TIMESTAMPDIFF(YEAR, usuario.data_nascimento, CURDATE()) <= 30 AND usuario.tipo_usuario = 1 AND tema.nome = tema_param) AS Quantidade
	UNION
	SELECT
		'31-35' AS Faixa,
		(SELECT COUNT(DISTINCT evento.fk_cliente) AS QuantidadeClientes FROM evento INNER JOIN usuario ON usuario.id_usuario = evento.fk_cliente INNER JOIN tema ON tema.id_tema = evento.fk_tema WHERE TIMESTAMPDIFF(YEAR, usuario.data_nascimento, CURDATE()) > 30 AND TIMESTAMPDIFF(YEAR, usuario.data_nascimento, CURDATE()) <= 35 AND usuario.tipo_usuario = 1 AND tema.nome = tema_param) AS Quantidade
	UNION
	SELECT
		'36-40' AS Faixa,
		(SELECT COUNT(DISTINCT evento.fk_cliente) AS QuantidadeClientes FROM evento INNER JOIN usuario ON usuario.id_usuario = evento.fk_cliente INNER JOIN tema ON tema.id_tema = evento.fk_tema WHERE TIMESTAMPDIFF(YEAR, usuario.data_nascimento, CURDATE()) > 45 AND TIMESTAMPDIFF(YEAR, usuario.data_nascimento, CURDATE()) <= 40 AND usuario.tipo_usuario = 1 AND tema.nome = tema_param) AS Quantidade
	UNION
	SELECT
		'41+' AS Faixa,
		(SELECT COUNT(DISTINCT evento.fk_cliente) AS QuantidadeClientes FROM evento INNER JOIN usuario ON usuario.id_usuario = evento.fk_cliente INNER JOIN tema ON tema.id_tema = evento.fk_tema WHERE TIMESTAMPDIFF(YEAR, usuario.data_nascimento, CURDATE()) > 40 AND usuario.tipo_usuario = 1) AS Quantidade;
END //
DELIMITER ;

-- View retorna quantos clientes são fotógrafos e quantos são clientes
CREATE VIEW vw_total_clientes_fotografos
AS
	SELECT
		'Clientes' as Label, (SELECT COUNT(id_usuario) FROM usuario WHERE tipo_usuario = 1) AS 'Quantidade'
	UNION
    SELECT
        'Fotógrafos' as Label, (SELECT COUNT(id_usuario) FROM usuario WHERE tipo_usuario = 2) AS 'Quantidade';
        
-- View retorna quantas sessões foram finalizadas e quantas foram canceladas
CREATE VIEW vw_total_sessoes_finalizadas_canceladas
AS
	SELECT
		'Convertidos' as Label, (SELECT COUNT(id_evento) FROM evento WHERE status_evento LIKE 'Finalizado') AS 'Quantidade'
	UNION
    SELECT
        'Interrompidos' as Label, (SELECT COUNT(id_evento) FROM evento WHERE status_evento LIKE 'Cancelado') AS 'Quantidade';
        
-- View que retorna a progressão da quantidade de usuários cadastrados nos últimos 6 meses
CREATE VIEW vw_progressao_cadastro_usuarios
AS
	SELECT
		MONTHNAME(DATE_SUB(NOW(), INTERVAL 6 MONTH)) AS 'Mes', COUNT(id_usuario) AS 'Quantidade' FROM usuario WHERE TIMESTAMPDIFF(MONTH, data_cadastro, CURDATE()) = 6
	UNION
    SELECT
		MONTHNAME(DATE_SUB(NOW(), INTERVAL 5 MONTH)) AS 'Mes', COUNT(id_usuario) AS 'Quantidade' FROM usuario WHERE TIMESTAMPDIFF(MONTH, data_cadastro, CURDATE()) = 5
	UNION
    SELECT
		MONTHNAME(DATE_SUB(NOW(), INTERVAL 4 MONTH)) AS 'Mes', COUNT(id_usuario) AS 'Quantidade' FROM usuario WHERE TIMESTAMPDIFF(MONTH, data_cadastro, CURDATE()) = 4
	UNION
    SELECT
		MONTHNAME(DATE_SUB(NOW(), INTERVAL 3 MONTH)) AS 'Mes', COUNT(id_usuario) AS 'Quantidade' FROM usuario WHERE TIMESTAMPDIFF(MONTH, data_cadastro, CURDATE()) = 3
	UNION
    SELECT
		MONTHNAME(DATE_SUB(NOW(), INTERVAL 2 MONTH)) AS 'Mes', COUNT(id_usuario) AS 'Quantidade' FROM usuario WHERE TIMESTAMPDIFF(MONTH, data_cadastro, CURDATE()) = 2
	UNION
    SELECT
		MONTHNAME(DATE_SUB(NOW(), INTERVAL 1 MONTH)) AS 'Mes', COUNT(id_usuario) AS 'Quantidade' FROM usuario WHERE TIMESTAMPDIFF(MONTH, data_cadastro, CURDATE()) = 1
	UNION
	SELECT
		MONTHNAME(DATE_SUB(NOW(), INTERVAL 0 MONTH)) AS 'Mes', COUNT(id_usuario) AS 'Quantidade' FROM usuario WHERE TIMESTAMPDIFF(MONTH, data_cadastro, CURDATE()) = 0;
        
-- View que retorna a progressão da quantidade de eventos concluidos
CREATE VIEW vw_progressao_sessoes_realizadas
AS
	SELECT
		MONTHNAME(DATE_SUB(NOW(), INTERVAL 6 MONTH)) AS 'Mes', COUNT(id_evento) AS 'Quantidade' FROM evento WHERE TIMESTAMPDIFF(MONTH, data_realizacao, CURDATE()) = 6 AND status_evento = 'Finalizado'
	UNION
    SELECT
		MONTHNAME(DATE_SUB(NOW(), INTERVAL 5 MONTH)) AS 'Mes', COUNT(id_evento) AS 'Quantidade' FROM evento WHERE TIMESTAMPDIFF(MONTH, data_realizacao, CURDATE()) = 5 AND status_evento = 'Finalizado'
	UNION
    SELECT
		MONTHNAME(DATE_SUB(NOW(), INTERVAL 4 MONTH)) AS 'Mes', COUNT(id_evento) AS 'Quantidade' FROM evento WHERE TIMESTAMPDIFF(MONTH, data_realizacao, CURDATE()) = 4 AND status_evento = 'Finalizado'
	UNION
    SELECT
		MONTHNAME(DATE_SUB(NOW(), INTERVAL 3 MONTH)) AS 'Mes', COUNT(id_evento) AS 'Quantidade' FROM evento WHERE TIMESTAMPDIFF(MONTH, data_realizacao, CURDATE()) = 3 AND status_evento = 'Finalizado'
	UNION
    SELECT
		MONTHNAME(DATE_SUB(NOW(), INTERVAL 2 MONTH)) AS 'Mes', COUNT(id_evento) AS 'Quantidade' FROM evento WHERE TIMESTAMPDIFF(MONTH, data_realizacao, CURDATE()) = 2 AND status_evento = 'Finalizado'
	UNION
    SELECT
		MONTHNAME(DATE_SUB(NOW(), INTERVAL 1 MONTH)) AS 'Mes', COUNT(id_evento) AS 'Quantidade' FROM evento WHERE TIMESTAMPDIFF(MONTH, data_realizacao, CURDATE()) = 1 AND status_evento = 'Finalizado'
	UNION
	SELECT
		MONTHNAME(DATE_SUB(NOW(), INTERVAL 0 MONTH)) AS 'Mes', COUNT(id_evento) AS 'Quantidade' FROM evento WHERE TIMESTAMPDIFF(MONTH, data_realizacao, CURDATE()) = 0 AND status_evento = 'Finalizado';
        
-- View KPI 1 - Total usuários e usuários cadastrados no último mês
CREATE VIEW vw_kpi_usuarios_mes
AS 
	SELECT 
		'Total' as Label, (SELECT COUNT(id_usuario) FROM usuario) AS 'Quantidade'
	UNION 
    SELECT 
		'Mes' as Label, (SELECT COUNT(id_usuario) FROM usuario WHERE DATEDIFF(CURDATE(), data_cadastro) <= 31)
	UNION 
    SELECT 
		'MesPassado' as Label, (SELECT COUNT(id_usuario) FROM usuario WHERE DATEDIFF(CURDATE(), data_cadastro) > 31 AND DATEDIFF(CURDATE(), data_cadastro) <= 62);
        
-- View KPI 2 - Total de sessões de fotos realizadas        
CREATE VIEW vw_total_sessoes_realizadas
AS
	SELECT 
		'SessoesRealizadas' as Label, (SELECT COUNT(id_evento) FROM evento WHERE status_evento = 'Finalizado')
	UNION
    SELECT 
		'SessoesRealizadasMes' as Label, (SELECT COUNT(id_evento) FROM evento WHERE status_evento = 'Finalizado' AND DATEDIFF(CURDATE(), data_realizacao) <= 31)
	UNION
    SELECT 
		'SessoesRealizadasMesPassado' as Label, (SELECT COUNT(id_evento) FROM evento WHERE status_evento = 'Finalizado' AND DATEDIFF(CURDATE(), data_realizacao) > 31 AND DATEDIFF(CURDATE(), data_realizacao) <= 62);

-- View KPI 3 - Total de acessos          
CREATE VIEW vw_acessos_mes
AS
	SELECT 
		'Acessos' as Label, (SELECT COUNT(id_usuario) FROM usuario WHERE ultimo_login > '1960-01-01')
	UNION
    SELECT 
		'AcessosMes' as Label, (SELECT COUNT(id_usuario) FROM usuario WHERE DATEDIFF(CURDATE(), ultimo_login) <= 31)
	UNION
    SELECT 
		'AcessosMesPassado' as Label, (SELECT COUNT(id_usuario) FROM usuario WHERE DATEDIFF(CURDATE(), ultimo_login) > 31 AND DATEDIFF(CURDATE(), ultimo_login) <= 62);
	