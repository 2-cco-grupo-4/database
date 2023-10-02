SET lc_time_names = 'pt_BR';

USE PICME;

SELECT * FROM VW_CLIENTES_IMEDIATOS_MES VCIM;

-- View retorna quantos clientes 'imediatos' tivemos do mês, ou seja, quando clientes que se cadastraram e em menos de 1 semana criaram uma sessão
CREATE VIEW vw_clientes_imediatos_mes
AS
	SELECT
		MONTHNAME(DATE_SUB(NOW(), INTERVAL 0 MONTH)) AS 'Mes',
		(SELECT COUNT(DISTINCT id_usuario) FROM (SELECT id_usuario FROM tb_usuario INNER JOIN tb_sessao ON tb_usuario.id_usuario = tb_sessao.fk_cliente WHERE DATEDIFF(tb_usuario.data_cadastro, tb_sessao.created_at) <= 7 AND tipo_usuario LIKE 1 AND MONTHNAME(tb_sessao.created_at) LIKE MONTHNAME(DATE_SUB(NOW(), INTERVAL 0 MONTH))) AS ClientesImediatos) AS 'Agendaram',
        (SELECT COUNT(DISTINCT id_usuario) FROM tb_usuario WHERE MONTH(tb_usuario.data_cadastro) = MONTH(NOW()) AND tipo_usuario = 1) AS 'Total',
        (SELECT Total - Agendaram) AS 'Nao Agendaram'
     UNION
     SELECT
      	MONTHNAME(DATE_SUB(NOW(), INTERVAL 1 MONTH)) AS 'Mes',
		(SELECT COUNT(DISTINCT id_usuario) FROM (SELECT id_usuario FROM tb_usuario INNER JOIN tb_sessao ON tb_usuario.id_usuario = tb_sessao.fk_cliente WHERE DATEDIFF(tb_usuario.data_cadastro, tb_sessao.created_at) <= 7 AND tipo_usuario LIKE 1 AND MONTHNAME(tb_sessao.created_at) LIKE MONTHNAME(DATE_SUB(NOW(), INTERVAL 1 MONTH))) AS ClientesImediatos) AS 'Agendaram',
        (SELECT COUNT(DISTINCT id_usuario) FROM tb_usuario WHERE MONTH(tb_usuario.data_cadastro) = (MONTH(NOW()) - 1) AND tipo_usuario = 1) AS 'Total',
        (SELECT Total - Agendaram) AS 'Nao Agendaram'
     UNION
     SELECT
      	MONTHNAME(DATE_SUB(NOW(), INTERVAL 2 MONTH)) AS 'Mes',
		(SELECT COUNT(DISTINCT id_usuario) FROM (SELECT id_usuario FROM tb_usuario INNER JOIN tb_sessao ON tb_usuario.id_usuario = tb_sessao.fk_cliente WHERE DATEDIFF(tb_usuario.data_cadastro, tb_sessao.created_at) <= 7 AND tipo_usuario LIKE 1 AND MONTHNAME(tb_sessao.created_at) LIKE MONTHNAME(DATE_SUB(NOW(), INTERVAL 2 MONTH))) AS ClientesImediatos) AS 'Agendaram',
        (SELECT COUNT(DISTINCT id_usuario) FROM tb_usuario WHERE MONTH(tb_usuario.data_cadastro) = (MONTH(NOW()) - 2) AND tipo_usuario = 1) AS 'Total',
       	(SELECT Total - Agendaram) AS 'Nao Agendaram'
     UNION
     SELECT
      	MONTHNAME(DATE_SUB(NOW(), INTERVAL 3 MONTH)) AS 'Mes',
		(SELECT COUNT(DISTINCT id_usuario) FROM (SELECT id_usuario FROM tb_usuario INNER JOIN tb_sessao ON tb_usuario.id_usuario = tb_sessao.fk_cliente WHERE DATEDIFF(tb_usuario.data_cadastro, tb_sessao.created_at) <= 7 AND tipo_usuario LIKE 1 AND MONTHNAME(tb_sessao.created_at) LIKE MONTHNAME(DATE_SUB(NOW(), INTERVAL 3 MONTH))) AS ClientesImediatos) AS 'Agendaram',
        (SELECT COUNT(DISTINCT id_usuario) FROM tb_usuario WHERE MONTH(tb_usuario.data_cadastro) = (MONTH(NOW()) - 3) AND tipo_usuario = 1) AS 'Total',
        (SELECT Total - Agendaram) AS 'Nao Agendaram'
     UNION
     SELECT
      	MONTHNAME(DATE_SUB(NOW(), INTERVAL 4 MONTH)) AS 'Mes',
		(SELECT COUNT(DISTINCT id_usuario) FROM (SELECT id_usuario FROM tb_usuario INNER JOIN tb_sessao ON tb_usuario.id_usuario = tb_sessao.fk_cliente WHERE DATEDIFF(tb_usuario.data_cadastro, tb_sessao.created_at) <= 7 AND tipo_usuario LIKE 1 AND MONTHNAME(tb_sessao.created_at) LIKE MONTHNAME(DATE_SUB(NOW(), INTERVAL 4 MONTH))) AS ClientesImediatos) AS 'Agendaram',
        (SELECT COUNT(DISTINCT id_usuario) FROM tb_usuario WHERE MONTH(tb_usuario.data_cadastro) = (MONTH(NOW()) - 4) AND tipo_usuario = 1) AS 'Total',
        (SELECT Total - Agendaram) AS 'Nao Agendaram';
       
-- View retorna contagem de quantos contatos foram iniciados para cada tema cadastrado 
CREATE VIEW vw_tema_count_sessoes
AS
	SELECT
		nome AS Tema,
		COUNT(fk_tema) AS Sessoes
	FROM
		tb_sessao
	INNER JOIN
		tb_tema ON tb_sessao.fk_tema = tb_tema.id_tema
	GROUP BY
		Tema;

        
-- View que retorna contagem de usuario do tipo Cliente separados por faixa etária
CREATE VIEW vw_faixa_etaria_cliente
AS
	SELECT
		'18-20' AS Faixa,
			(SELECT COUNT(id_usuario) FROM tb_usuario WHERE TIMESTAMPDIFF(YEAR, data_nascimento, CURDATE()) > 18 AND TIMESTAMPDIFF(YEAR, data_nascimento, CURDATE()) <= 20 AND tipo_usuario = 1) AS Quantidade
	UNION
	SELECT
		'21-25' AS Faixa,
			(SELECT COUNT(id_usuario) FROM tb_usuario WHERE TIMESTAMPDIFF(YEAR, data_nascimento, CURDATE()) > 20 AND TIMESTAMPDIFF(YEAR, data_nascimento, CURDATE()) <= 25 AND tipo_usuario = 1) AS Quantidade
	UNION
	SELECT
		'26-30' AS Faixa,
			(SELECT COUNT(id_usuario) FROM tb_usuario WHERE TIMESTAMPDIFF(YEAR, data_nascimento, CURDATE()) > 25 AND TIMESTAMPDIFF(YEAR, data_nascimento, CURDATE()) <= 30 AND tipo_usuario = 1) AS Quantidade
	UNION
	SELECT
		'31-35' AS Faixa,
		(SELECT COUNT(id_usuario) FROM tb_usuario WHERE TIMESTAMPDIFF(YEAR, data_nascimento, CURDATE()) > 30 AND TIMESTAMPDIFF(YEAR, data_nascimento, CURDATE()) <= 35 AND tipo_usuario = 1) AS Quantidade
	UNION
	SELECT
		'36-40' AS Faixa,
		(SELECT COUNT(id_usuario) FROM tb_usuario WHERE TIMESTAMPDIFF(YEAR, data_nascimento, CURDATE()) > 35 AND TIMESTAMPDIFF(YEAR, data_nascimento, CURDATE()) <= 40 AND tipo_usuario = 1) AS Quantidade
	UNION
	SELECT
		'41+' AS Faixa,
		(SELECT COUNT(id_usuario) FROM tb_usuario WHERE TIMESTAMPDIFF(YEAR, data_nascimento, CURDATE()) > 40 AND tipo_usuario = 1) AS Quantidade;
        

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
        
-- View KPI 1 - Usuários cadastros no mês atual e no último mês
CREATE VIEW vw_kpi_usuarios_mes
AS 
    SELECT 
		MONTHNAME(NOW()) AS 'Mes', (SELECT COUNT(id_usuario) FROM tb_usuario WHERE DATEDIFF(CURDATE(), data_cadastro) <= 31) AS 'Quantidade'
	UNION
    SELECT 
		MONTHNAME(DATE_SUB(NOW(), INTERVAL 1 MONTH)) AS 'Mes', (SELECT COUNT(id_usuario) FROM tb_usuario WHERE DATEDIFF(CURDATE(), data_cadastro) > 31 AND DATEDIFF(CURDATE(), data_cadastro) <= 62) AS 'MesPassado';
        
-- View KPI 2 - Sessões realizadas no mês atual e no último mês     
CREATE VIEW vw_kpi_sessoes_mes
AS
    SELECT 
		MONTHNAME(NOW()) AS 'Mes', (SELECT COUNT(id_sessao) FROM tb_sessao WHERE status_sessao = 'Finalizado' AND DATEDIFF(CURDATE(), data_realizacao) <= 31) AS 'Sessoes'
	UNION
    SELECT 
		MONTHNAME(DATE_SUB(NOW(), INTERVAL 1 MONTH)) AS 'Mes', (SELECT COUNT(id_sessao) FROM tb_sessao WHERE status_sessao = 'Finalizado' AND DATEDIFF(CURDATE(), data_realizacao) > 31 AND DATEDIFF(CURDATE(), data_realizacao) <= 62) AS 'Sessoes';

-- View KPI 3 - Acessos no mês atual e no último mês         
CREATE VIEW vw_kpi_acessos_mes
AS
    SELECT 
		MONTHNAME(NOW()) AS 'Mes', (SELECT COUNT(fk_usuario) FROM tb_log_acessos WHERE DATEDIFF(CURDATE(), data_login) <= 31) AS 'Acessos'
	UNION
    SELECT 
		MONTHNAME(DATE_SUB(NOW(), INTERVAL 1 MONTH)) AS 'Mes', (SELECT COUNT(fk_usuario) FROM tb_log_acessos WHERE DATEDIFF(CURDATE(), data_login) > 31 AND DATEDIFF(CURDATE(), data_login) <= 62) AS 'Acessos';
	