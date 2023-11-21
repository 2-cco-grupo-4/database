SET lc_time_names = 'pt_BR';

USE PICME;

-- View retorna quantos clientes 'imediatos' tivemos do mês, ou seja, quando clientes que se cadastraram e em menos de 1 semana criaram uma sessão
CREATE VIEW vw_clientes_imediatos_mes
AS
	SELECT
	    MONTHNAME(DATE_SUB(NOW(), INTERVAL 11 MONTH)) AS 'Mes',
		(SELECT COUNT(DISTINCT id_usuario) FROM (SELECT id_usuario FROM tb_usuario INNER JOIN tb_sessao ON tb_usuario.id_usuario = tb_sessao.fk_cliente WHERE DATEDIFF(tb_usuario.data_cadastro, tb_sessao.created_at) <= 7 AND tipo_usuario = 1 AND MONTHNAME(tb_sessao.created_at) LIKE MONTHNAME(DATE_SUB(NOW(), INTERVAL 11 MONTH)) AND MONTH(tb_usuario.data_cadastro) = MONTH(DATE_SUB(NOW(), INTERVAL 11 MONTH))) AS ClientesImediatos) AS 'Agendaram',
	    (SELECT COUNT(DISTINCT id_usuario) FROM tb_usuario WHERE MONTH(tb_usuario.data_cadastro) = (MONTH(NOW()) - 11) AND tipo_usuario = 1) AS 'Total',
	    (SELECT Total - Agendaram) AS 'Nao Agendaram'
	UNION
	SELECT
	    MONTHNAME(DATE_SUB(NOW(), INTERVAL 10 MONTH)) AS 'Mes',
		(SELECT COUNT(DISTINCT id_usuario) FROM (SELECT id_usuario FROM tb_usuario INNER JOIN tb_sessao ON tb_usuario.id_usuario = tb_sessao.fk_cliente WHERE DATEDIFF(tb_usuario.data_cadastro, tb_sessao.created_at) <= 7 AND tipo_usuario = 1 AND MONTHNAME(tb_sessao.created_at) LIKE MONTHNAME(DATE_SUB(NOW(), INTERVAL 10 MONTH)) AND MONTH(tb_usuario.data_cadastro) = MONTH(DATE_SUB(NOW(), INTERVAL 10 MONTH))) AS ClientesImediatos) AS 'Agendaram',
	    (SELECT COUNT(DISTINCT id_usuario) FROM tb_usuario WHERE MONTH(tb_usuario.data_cadastro) = (MONTH(NOW()) - 10) AND tipo_usuario = 1) AS 'Total',
	    (SELECT Total - Agendaram) AS 'Nao Agendaram'
	UNION
	SELECT
	    MONTHNAME(DATE_SUB(NOW(), INTERVAL 9 MONTH)) AS 'Mes',
		(SELECT COUNT(DISTINCT id_usuario) FROM (SELECT id_usuario FROM tb_usuario INNER JOIN tb_sessao ON tb_usuario.id_usuario = tb_sessao.fk_cliente WHERE DATEDIFF(tb_usuario.data_cadastro, tb_sessao.created_at) <= 7 AND tipo_usuario = 1 AND MONTHNAME(tb_sessao.created_at) LIKE MONTHNAME(DATE_SUB(NOW(), INTERVAL 9 MONTH)) AND MONTH(tb_usuario.data_cadastro) = MONTH(DATE_SUB(NOW(), INTERVAL 9 MONTH))) AS ClientesImediatos) AS 'Agendaram',
	    (SELECT COUNT(DISTINCT id_usuario) FROM tb_usuario WHERE MONTH(tb_usuario.data_cadastro) = (MONTH(NOW()) - 9) AND tipo_usuario = 1) AS 'Total',
	    (SELECT Total - Agendaram) AS 'Nao Agendaram'
	UNION
	SELECT
	    MONTHNAME(DATE_SUB(NOW(), INTERVAL 8 MONTH)) AS 'Mes',
		(SELECT COUNT(DISTINCT id_usuario) FROM (SELECT id_usuario FROM tb_usuario INNER JOIN tb_sessao ON tb_usuario.id_usuario = tb_sessao.fk_cliente WHERE DATEDIFF(tb_usuario.data_cadastro, tb_sessao.created_at) <= 7 AND tipo_usuario = 1 AND MONTHNAME(tb_sessao.created_at) LIKE MONTHNAME(DATE_SUB(NOW(), INTERVAL 8 MONTH)) AND MONTH(tb_usuario.data_cadastro) = MONTH(DATE_SUB(NOW(), INTERVAL 8 MONTH))) AS ClientesImediatos) AS 'Agendaram',
	    (SELECT COUNT(DISTINCT id_usuario) FROM tb_usuario WHERE MONTH(tb_usuario.data_cadastro) = (MONTH(NOW()) - 8) AND tipo_usuario = 1) AS 'Total',
	    (SELECT Total - Agendaram) AS 'Nao Agendaram'
	UNION
	SELECT
	    MONTHNAME(DATE_SUB(NOW(), INTERVAL 7 MONTH)) AS 'Mes',
		(SELECT COUNT(DISTINCT id_usuario) FROM (SELECT id_usuario FROM tb_usuario INNER JOIN tb_sessao ON tb_usuario.id_usuario = tb_sessao.fk_cliente WHERE DATEDIFF(tb_usuario.data_cadastro, tb_sessao.created_at) <= 7 AND tipo_usuario = 1 AND MONTHNAME(tb_sessao.created_at) LIKE MONTHNAME(DATE_SUB(NOW(), INTERVAL 7 MONTH)) AND MONTH(tb_usuario.data_cadastro) = MONTH(DATE_SUB(NOW(), INTERVAL 7 MONTH))) AS ClientesImediatos) AS 'Agendaram',
	    (SELECT COUNT(DISTINCT id_usuario) FROM tb_usuario WHERE MONTH(tb_usuario.data_cadastro) = (MONTH(NOW()) - 7) AND tipo_usuario = 1) AS 'Total',
	    (SELECT Total - Agendaram) AS 'Nao Agendaram'
	UNION
	SELECT
	    MONTHNAME(DATE_SUB(NOW(), INTERVAL 6 MONTH)) AS 'Mes',
		(SELECT COUNT(DISTINCT id_usuario) FROM (SELECT id_usuario FROM tb_usuario INNER JOIN tb_sessao ON tb_usuario.id_usuario = tb_sessao.fk_cliente WHERE DATEDIFF(tb_usuario.data_cadastro, tb_sessao.created_at) <= 7 AND tipo_usuario = 1 AND MONTHNAME(tb_sessao.created_at) LIKE MONTHNAME(DATE_SUB(NOW(), INTERVAL 6 MONTH)) AND MONTH(tb_usuario.data_cadastro) = MONTH(DATE_SUB(NOW(), INTERVAL 6 MONTH))) AS ClientesImediatos) AS 'Agendaram',
	    (SELECT COUNT(DISTINCT id_usuario) FROM tb_usuario WHERE MONTH(tb_usuario.data_cadastro) = (MONTH(NOW()) - 6) AND tipo_usuario = 1) AS 'Total',
	    (SELECT Total - Agendaram) AS 'Nao Agendaram'
	UNION
	SELECT
	    MONTHNAME(DATE_SUB(NOW(), INTERVAL 5 MONTH)) AS 'Mes',
		(SELECT COUNT(DISTINCT id_usuario) FROM (SELECT id_usuario FROM tb_usuario INNER JOIN tb_sessao ON tb_usuario.id_usuario = tb_sessao.fk_cliente WHERE DATEDIFF(tb_usuario.data_cadastro, tb_sessao.created_at) <= 7 AND tipo_usuario = 1 AND MONTHNAME(tb_sessao.created_at) LIKE MONTHNAME(DATE_SUB(NOW(), INTERVAL 5 MONTH)) AND MONTH(tb_usuario.data_cadastro) = MONTH(DATE_SUB(NOW(), INTERVAL 5 MONTH))) AS ClientesImediatos) AS 'Agendaram',
	    (SELECT COUNT(DISTINCT id_usuario) FROM tb_usuario WHERE MONTH(tb_usuario.data_cadastro) = (MONTH(NOW()) - 5) AND tipo_usuario = 1) AS 'Total',
	    (SELECT Total - Agendaram) AS 'Nao Agendaram'
	UNION
	SELECT
	    MONTHNAME(DATE_SUB(NOW(), INTERVAL 5 MONTH)) AS 'Mes',
		(SELECT COUNT(DISTINCT id_usuario) FROM (SELECT id_usuario FROM tb_usuario INNER JOIN tb_sessao ON tb_usuario.id_usuario = tb_sessao.fk_cliente WHERE DATEDIFF(tb_usuario.data_cadastro, tb_sessao.created_at) <= 7 AND tipo_usuario = 1 AND MONTHNAME(tb_sessao.created_at) LIKE MONTHNAME(DATE_SUB(NOW(), INTERVAL 4 MONTH)) AND MONTH(tb_usuario.data_cadastro) = MONTH(DATE_SUB(NOW(), INTERVAL 4 MONTH))) AS ClientesImediatos) AS 'Agendaram',
	    (SELECT COUNT(DISTINCT id_usuario) FROM tb_usuario WHERE MONTH(tb_usuario.data_cadastro) = (MONTH(NOW()) - 4) AND tipo_usuario = 1) AS 'Total',
	    (SELECT Total - Agendaram) AS 'Nao Agendaram'
	UNION
	SELECT
      	MONTHNAME(DATE_SUB(NOW(), INTERVAL 3 MONTH)) AS 'Mes',
		(SELECT COUNT(DISTINCT id_usuario) FROM (SELECT id_usuario FROM tb_usuario INNER JOIN tb_sessao ON tb_usuario.id_usuario = tb_sessao.fk_cliente WHERE DATEDIFF(tb_usuario.data_cadastro, tb_sessao.created_at) <= 7 AND tipo_usuario = 1 AND MONTHNAME(tb_sessao.created_at) LIKE MONTHNAME(DATE_SUB(NOW(), INTERVAL 3 MONTH)) AND MONTH(tb_usuario.data_cadastro) = MONTH(DATE_SUB(NOW(), INTERVAL 3 MONTH))) AS ClientesImediatos) AS 'Agendaram',
        (SELECT COUNT(DISTINCT id_usuario) FROM tb_usuario WHERE MONTH(tb_usuario.data_cadastro) = (MONTH(NOW()) - 3) AND tipo_usuario = 1) AS 'Total',
        (SELECT Total - Agendaram) AS 'Nao Agendaram'
     UNION
     SELECT
      	MONTHNAME(DATE_SUB(NOW(), INTERVAL 2 MONTH)) AS 'Mes',
		(SELECT COUNT(DISTINCT id_usuario) FROM (SELECT id_usuario FROM tb_usuario INNER JOIN tb_sessao ON tb_usuario.id_usuario = tb_sessao.fk_cliente WHERE DATEDIFF(tb_usuario.data_cadastro, tb_sessao.created_at) <= 7 AND tipo_usuario = 1 AND MONTHNAME(tb_sessao.created_at) LIKE MONTHNAME(DATE_SUB(NOW(), INTERVAL 2 MONTH)) AND MONTH(tb_usuario.data_cadastro) = MONTH(DATE_SUB(NOW(), INTERVAL 2 MONTH))) AS ClientesImediatos) AS 'Agendaram',
        (SELECT COUNT(DISTINCT id_usuario) FROM tb_usuario WHERE MONTH(tb_usuario.data_cadastro) = (MONTH(NOW()) - 2) AND tipo_usuario = 1) AS 'Total',
       	(SELECT Total - Agendaram) AS 'Nao Agendaram'
     UNION
     SELECT
      	MONTHNAME(DATE_SUB(NOW(), INTERVAL 1 MONTH)) AS 'Mes',
		(SELECT COUNT(DISTINCT id_usuario) FROM (SELECT id_usuario FROM tb_usuario INNER JOIN tb_sessao ON tb_usuario.id_usuario = tb_sessao.fk_cliente WHERE DATEDIFF(tb_usuario.data_cadastro, tb_sessao.created_at) <= 7 AND tipo_usuario = 1 AND MONTHNAME(tb_sessao.created_at) LIKE MONTHNAME(DATE_SUB(NOW(), INTERVAL 1 MONTH)) AND MONTH(tb_usuario.data_cadastro) = MONTH(DATE_SUB(NOW(), INTERVAL 1 MONTH))) AS ClientesImediatos) AS 'Agendaram',
        (SELECT COUNT(DISTINCT id_usuario) FROM tb_usuario WHERE MONTH(tb_usuario.data_cadastro) = (MONTH(NOW()) - 1) AND tipo_usuario = 1) AS 'Total',
        (SELECT Total - Agendaram) AS 'Nao Agendaram'
    UNION
	SELECT
		MONTHNAME(DATE_SUB(NOW(), INTERVAL 0 MONTH)) AS 'Mes',
		(SELECT COUNT(DISTINCT id_usuario) FROM (SELECT id_usuario FROM tb_usuario INNER JOIN tb_sessao ON tb_usuario.id_usuario = tb_sessao.fk_cliente WHERE DATEDIFF(tb_usuario.data_cadastro, tb_sessao.created_at) <= 7 AND tipo_usuario = 1 AND MONTHNAME(tb_sessao.created_at) LIKE MONTHNAME(DATE_SUB(NOW(), INTERVAL 0 MONTH)) AND MONTH(tb_usuario.data_cadastro) = MONTH(DATE_SUB(NOW(), INTERVAL 0 MONTH))) AS ClientesImediatos) AS 'Agendaram',
        (SELECT COUNT(DISTINCT id_usuario) FROM tb_usuario WHERE MONTH(tb_usuario.data_cadastro) = MONTH(NOW()) AND tipo_usuario = 1) AS 'Total',
        (SELECT Total - Agendaram) AS 'Nao Agendaram';
       
-- View retorna contagem de quantos contatos foram iniciados para cada tema cadastrado 
CREATE VIEW vw_tema_count_sessoes
AS
	SELECT
		nome AS Tema,
		COUNT(fk_tema) AS Sessoes,
		ROUND(AVG(tb_pagamento.valor), 2) AS ValorGerado,
		MONTHNAME(data_realizacao) AS 'Mes', 
		YEAR(data_realizacao) AS 'Ano'
	FROM
		tb_sessao
	INNER JOIN
		tb_tema ON tb_sessao.fk_tema = tb_tema.id_tema
	INNER JOIN
		tb_pagamento ON tb_sessao.id_sessao = tb_pagamento.fk_sessao
	GROUP BY
		Tema, Mes, Ano
	ORDER BY
		ValorGerado DESC;
	
CREATE VIEW vw_estados_mais_sessoes
AS
	SELECT 
		estado, 
		COUNT(id_sessao) AS 'Total',
		MONTHNAME(data_realizacao) AS 'Mes', 
		YEAR(data_realizacao) AS 'Ano'
	FROM tb_endereco
	INNER JOIN 
		tb_sessao ON tb_sessao.id_sessao = tb_endereco.fk_sessao
	GROUP BY estado, Mes, Ano
	ORDER BY Total DESC;

        
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
CREATE VIEW vw_clientes_fotografos
AS
	SELECT
		MONTHNAME(DATE_SUB(NOW(), INTERVAL 11 MONTH)) AS 'Mes',
		(SELECT COUNT(id_usuario) FROM tb_usuario WHERE tipo_usuario = 1 AND MONTH(data_cadastro) = MONTH(DATE_SUB(NOW(), INTERVAL 11 MONTH))) AS 'Clientes',
		(SELECT COUNT(id_usuario) FROM tb_usuario WHERE tipo_usuario <> 0 AND MONTH(data_cadastro) = MONTH(DATE_SUB(NOW(), INTERVAL 11 MONTH))) AS 'Total',
        (SELECT COUNT(id_usuario) FROM tb_usuario WHERE tipo_usuario = 2 AND MONTH(data_cadastro) = MONTH(DATE_SUB(NOW(), INTERVAL 11 MONTH))) AS 'Fotografos'
    UNION
	SELECT
		MONTHNAME(DATE_SUB(NOW(), INTERVAL 10 MONTH)) AS 'Mes',
		(SELECT COUNT(id_usuario) FROM tb_usuario WHERE tipo_usuario = 1 AND MONTH(data_cadastro) = MONTH(DATE_SUB(NOW(), INTERVAL 10 MONTH))) AS 'Clientes',
		(SELECT COUNT(id_usuario) FROM tb_usuario WHERE tipo_usuario <> 0 AND MONTH(data_cadastro) = MONTH(DATE_SUB(NOW(), INTERVAL 10 MONTH))) AS 'Total',
        (SELECT COUNT(id_usuario) FROM tb_usuario WHERE tipo_usuario = 2 AND MONTH(data_cadastro) = MONTH(DATE_SUB(NOW(), INTERVAL 10 MONTH))) AS 'Fotografos'
    UNION
	SELECT
		MONTHNAME(DATE_SUB(NOW(), INTERVAL 9 MONTH)) AS 'Mes',
		(SELECT COUNT(id_usuario) FROM tb_usuario WHERE tipo_usuario = 1 AND MONTH(data_cadastro) = MONTH(DATE_SUB(NOW(), INTERVAL 9 MONTH))) AS 'Clientes',
		(SELECT COUNT(id_usuario) FROM tb_usuario WHERE tipo_usuario <> 0 AND MONTH(data_cadastro) = MONTH(DATE_SUB(NOW(), INTERVAL 9 MONTH))) AS 'Total',
        (SELECT COUNT(id_usuario) FROM tb_usuario WHERE tipo_usuario = 2 AND MONTH(data_cadastro) = MONTH(DATE_SUB(NOW(), INTERVAL 9 MONTH))) AS 'Fotografos'
    UNION
	SELECT
		MONTHNAME(DATE_SUB(NOW(), INTERVAL 8 MONTH)) AS 'Mes',
		(SELECT COUNT(id_usuario) FROM tb_usuario WHERE tipo_usuario = 1 AND MONTH(data_cadastro) = MONTH(DATE_SUB(NOW(), INTERVAL 8 MONTH))) AS 'Clientes',
		(SELECT COUNT(id_usuario) FROM tb_usuario WHERE tipo_usuario <> 0 AND MONTH(data_cadastro) = MONTH(DATE_SUB(NOW(), INTERVAL 8 MONTH))) AS 'Total',
        (SELECT COUNT(id_usuario) FROM tb_usuario WHERE tipo_usuario = 2 AND MONTH(data_cadastro) = MONTH(DATE_SUB(NOW(), INTERVAL 8 MONTH))) AS 'Fotografos'
    UNION
	SELECT
		MONTHNAME(DATE_SUB(NOW(), INTERVAL 7 MONTH)) AS 'Mes',
		(SELECT COUNT(id_usuario) FROM tb_usuario WHERE tipo_usuario = 1 AND MONTH(data_cadastro) = MONTH(DATE_SUB(NOW(), INTERVAL 7 MONTH))) AS 'Clientes',
		(SELECT COUNT(id_usuario) FROM tb_usuario WHERE tipo_usuario <> 0 AND MONTH(data_cadastro) = MONTH(DATE_SUB(NOW(), INTERVAL 7 MONTH))) AS 'Total',
        (SELECT COUNT(id_usuario) FROM tb_usuario WHERE tipo_usuario = 2 AND MONTH(data_cadastro) = MONTH(DATE_SUB(NOW(), INTERVAL 7 MONTH))) AS 'Fotografos'
    UNION
	SELECT
		MONTHNAME(DATE_SUB(NOW(), INTERVAL 6 MONTH)) AS 'Mes',
		(SELECT COUNT(id_usuario) FROM tb_usuario WHERE tipo_usuario = 1 AND MONTH(data_cadastro) = MONTH(DATE_SUB(NOW(), INTERVAL 6 MONTH))) AS 'Clientes',
		(SELECT COUNT(id_usuario) FROM tb_usuario WHERE tipo_usuario <> 0 AND MONTH(data_cadastro) = MONTH(DATE_SUB(NOW(), INTERVAL 6 MONTH))) AS 'Total',
        (SELECT COUNT(id_usuario) FROM tb_usuario WHERE tipo_usuario = 2 AND MONTH(data_cadastro) = MONTH(DATE_SUB(NOW(), INTERVAL 6 MONTH))) AS 'Fotografos'
    UNION
	SELECT
		MONTHNAME(DATE_SUB(NOW(), INTERVAL 5 MONTH)) AS 'Mes',
		(SELECT COUNT(id_usuario) FROM tb_usuario WHERE tipo_usuario = 1 AND MONTH(data_cadastro) = MONTH(DATE_SUB(NOW(), INTERVAL 5 MONTH))) AS 'Clientes',
		(SELECT COUNT(id_usuario) FROM tb_usuario WHERE tipo_usuario <> 0 AND MONTH(data_cadastro) = MONTH(DATE_SUB(NOW(), INTERVAL 5 MONTH))) AS 'Total',
        (SELECT COUNT(id_usuario) FROM tb_usuario WHERE tipo_usuario = 2 AND MONTH(data_cadastro) = MONTH(DATE_SUB(NOW(), INTERVAL 5 MONTH))) AS 'Fotografos'
    UNION
	SELECT
		MONTHNAME(DATE_SUB(NOW(), INTERVAL 4 MONTH)) AS 'Mes',
		(SELECT COUNT(id_usuario) FROM tb_usuario WHERE tipo_usuario = 1 AND MONTH(data_cadastro) = MONTH(DATE_SUB(NOW(), INTERVAL 4 MONTH))) AS 'Clientes',
		(SELECT COUNT(id_usuario) FROM tb_usuario WHERE tipo_usuario <> 0 AND MONTH(data_cadastro) = MONTH(DATE_SUB(NOW(), INTERVAL 4 MONTH))) AS 'Total',
        (SELECT COUNT(id_usuario) FROM tb_usuario WHERE tipo_usuario = 2 AND MONTH(data_cadastro) = MONTH(DATE_SUB(NOW(), INTERVAL 4 MONTH))) AS 'Fotografos'
    UNION
	SELECT
		MONTHNAME(DATE_SUB(NOW(), INTERVAL 3 MONTH)) AS 'Mes',
		(SELECT COUNT(id_usuario) FROM tb_usuario WHERE tipo_usuario = 1 AND MONTH(data_cadastro) = MONTH(DATE_SUB(NOW(), INTERVAL 3 MONTH))) AS 'Clientes',
		(SELECT COUNT(id_usuario) FROM tb_usuario WHERE tipo_usuario <> 0 AND MONTH(data_cadastro) = MONTH(DATE_SUB(NOW(), INTERVAL 3 MONTH))) AS 'Total',
        (SELECT COUNT(id_usuario) FROM tb_usuario WHERE tipo_usuario = 2 AND MONTH(data_cadastro) = MONTH(DATE_SUB(NOW(), INTERVAL 3 MONTH))) AS 'Fotografos'
    UNION
    SELECT
    	MONTHNAME(DATE_SUB(NOW(), INTERVAL 2 MONTH)) AS 'Mes',
		(SELECT COUNT(id_usuario) FROM tb_usuario WHERE tipo_usuario = 1 AND MONTH(data_cadastro) = MONTH(DATE_SUB(NOW(), INTERVAL 2 MONTH))) AS 'Clientes',
		(SELECT COUNT(id_usuario) FROM tb_usuario WHERE tipo_usuario <> 0 AND MONTH(data_cadastro) = MONTH(DATE_SUB(NOW(), INTERVAL 2 MONTH))) AS 'Total',
        (SELECT COUNT(id_usuario) FROM tb_usuario WHERE tipo_usuario = 2 AND MONTH(data_cadastro) = MONTH(DATE_SUB(NOW(), INTERVAL 2 MONTH))) AS 'Fotografos'
    UNION
    SELECT
    	MONTHNAME(DATE_SUB(NOW(), INTERVAL 1 MONTH)) AS 'Mes',
		(SELECT COUNT(id_usuario) FROM tb_usuario WHERE tipo_usuario = 1 AND MONTH(data_cadastro) = MONTH(DATE_SUB(NOW(), INTERVAL 1 MONTH))) AS 'Clientes',
		(SELECT COUNT(id_usuario) FROM tb_usuario WHERE tipo_usuario <> 0 AND MONTH(data_cadastro) = MONTH(DATE_SUB(NOW(), INTERVAL 1 MONTH))) AS 'Total',
        (SELECT COUNT(id_usuario) FROM tb_usuario WHERE tipo_usuario = 2 AND MONTH(data_cadastro) = MONTH(DATE_SUB(NOW(), INTERVAL 1 MONTH))) AS 'Fotografos'
    UNION
    SELECT
    	MONTHNAME(DATE_SUB(NOW(), INTERVAL 0 MONTH)) AS 'Mes',
		(SELECT COUNT(id_usuario) FROM tb_usuario WHERE tipo_usuario = 1 AND MONTH(data_cadastro) = MONTH(DATE_SUB(NOW(), INTERVAL 0 MONTH))) AS 'Clientes',
		(SELECT COUNT(id_usuario) FROM tb_usuario WHERE tipo_usuario <> 0 AND MONTH(data_cadastro) = MONTH(DATE_SUB(NOW(), INTERVAL 0 MONTH))) AS 'Total',
        (SELECT COUNT(id_usuario) FROM tb_usuario WHERE tipo_usuario = 2 AND MONTH(data_cadastro) = MONTH(DATE_SUB(NOW(), INTERVAL 0 MONTH))) AS 'Fotografos';
        
-- View retorna quantas sessões foram finalizadas e quantas foram canceladas
CREATE VIEW vw_sessoes_realizadas_finalizadas
AS
SELECT
	MONTHNAME(DATE_SUB(NOW(), INTERVAL 11 MONTH)) AS 'Mes',
	(SELECT COUNT(id_sessao) FROM tb_sessao INNER JOIN tb_usuario ON tb_usuario.id_usuario = tb_sessao.fk_fotografo WHERE MONTH(created_at) = MONTH(DATE_SUB(NOW(), INTERVAL 11 MONTH)) AND status_sessao != 'Cancelada') AS 'Convertidas',
	(SELECT COUNT(id_sessao) FROM tb_sessao INNER JOIN tb_usuario ON tb_usuario.id_usuario = tb_sessao.fk_fotografo WHERE MONTH(created_at) = MONTH(DATE_SUB(NOW(), INTERVAL 11 MONTH))) AS 'Total',
	(SELECT COUNT(id_sessao) FROM tb_sessao INNER JOIN tb_usuario ON tb_usuario.id_usuario = tb_sessao.fk_fotografo WHERE MONTH(created_at) = MONTH(DATE_SUB(NOW(), INTERVAL 11 MONTH)) AND status_sessao = 'Cancelada') AS 'Interrompidas'
UNION
SELECT
	MONTHNAME(DATE_SUB(NOW(), INTERVAL 10 MONTH)) AS 'Mes',
	(SELECT COUNT(id_sessao) FROM tb_sessao INNER JOIN tb_usuario ON tb_usuario.id_usuario = tb_sessao.fk_fotografo WHERE MONTH(created_at) = MONTH(DATE_SUB(NOW(), INTERVAL 10 MONTH)) AND status_sessao != 'Cancelada') AS 'Convertidas',
	(SELECT COUNT(id_sessao) FROM tb_sessao INNER JOIN tb_usuario ON tb_usuario.id_usuario = tb_sessao.fk_fotografo WHERE MONTH(created_at) = MONTH(DATE_SUB(NOW(), INTERVAL 10 MONTH))) AS 'Total',
	(SELECT COUNT(id_sessao) FROM tb_sessao INNER JOIN tb_usuario ON tb_usuario.id_usuario = tb_sessao.fk_fotografo WHERE MONTH(created_at) = MONTH(DATE_SUB(NOW(), INTERVAL 10 MONTH)) AND status_sessao = 'Cancelada') AS 'Interrompidas'
UNION
SELECT
	MONTHNAME(DATE_SUB(NOW(), INTERVAL 9 MONTH)) AS 'Mes',
	(SELECT COUNT(id_sessao) FROM tb_sessao INNER JOIN tb_usuario ON tb_usuario.id_usuario = tb_sessao.fk_fotografo WHERE MONTH(created_at) = MONTH(DATE_SUB(NOW(), INTERVAL 9 MONTH)) AND status_sessao != 'Cancelada') AS 'Convertidas',
	(SELECT COUNT(id_sessao) FROM tb_sessao INNER JOIN tb_usuario ON tb_usuario.id_usuario = tb_sessao.fk_fotografo WHERE MONTH(created_at) = MONTH(DATE_SUB(NOW(), INTERVAL 9 MONTH))) AS 'Total',
	(SELECT COUNT(id_sessao) FROM tb_sessao INNER JOIN tb_usuario ON tb_usuario.id_usuario = tb_sessao.fk_fotografo WHERE MONTH(created_at) = MONTH(DATE_SUB(NOW(), INTERVAL 9 MONTH)) AND status_sessao = 'Cancelada') AS 'Interrompidas'
UNION
SELECT
	MONTHNAME(DATE_SUB(NOW(), INTERVAL 8 MONTH)) AS 'Mes',
	(SELECT COUNT(id_sessao) FROM tb_sessao INNER JOIN tb_usuario ON tb_usuario.id_usuario = tb_sessao.fk_fotografo WHERE MONTH(created_at) = MONTH(DATE_SUB(NOW(), INTERVAL 8 MONTH)) AND status_sessao != 'Cancelada') AS 'Convertidas',
	(SELECT COUNT(id_sessao) FROM tb_sessao INNER JOIN tb_usuario ON tb_usuario.id_usuario = tb_sessao.fk_fotografo WHERE MONTH(created_at) = MONTH(DATE_SUB(NOW(), INTERVAL 8 MONTH))) AS 'Total',
	(SELECT COUNT(id_sessao) FROM tb_sessao INNER JOIN tb_usuario ON tb_usuario.id_usuario = tb_sessao.fk_fotografo WHERE MONTH(created_at) = MONTH(DATE_SUB(NOW(), INTERVAL 8 MONTH)) AND status_sessao = 'Cancelada') AS 'Interrompidas'
UNION
SELECT
	MONTHNAME(DATE_SUB(NOW(), INTERVAL 7 MONTH)) AS 'Mes',
	(SELECT COUNT(id_sessao) FROM tb_sessao INNER JOIN tb_usuario ON tb_usuario.id_usuario = tb_sessao.fk_fotografo WHERE MONTH(created_at) = MONTH(DATE_SUB(NOW(), INTERVAL 7 MONTH)) AND status_sessao != 'Cancelada') AS 'Convertidas',
	(SELECT COUNT(id_sessao) FROM tb_sessao INNER JOIN tb_usuario ON tb_usuario.id_usuario = tb_sessao.fk_fotografo WHERE MONTH(created_at) = MONTH(DATE_SUB(NOW(), INTERVAL 7 MONTH))) AS 'Total',
	(SELECT COUNT(id_sessao) FROM tb_sessao INNER JOIN tb_usuario ON tb_usuario.id_usuario = tb_sessao.fk_fotografo WHERE MONTH(created_at) = MONTH(DATE_SUB(NOW(), INTERVAL 7 MONTH)) AND status_sessao = 'Cancelada') AS 'Interrompidas'
UNION
SELECT
	MONTHNAME(DATE_SUB(NOW(), INTERVAL 6 MONTH)) AS 'Mes',
	(SELECT COUNT(id_sessao) FROM tb_sessao INNER JOIN tb_usuario ON tb_usuario.id_usuario = tb_sessao.fk_fotografo WHERE MONTH(created_at) = MONTH(DATE_SUB(NOW(), INTERVAL 6 MONTH)) AND status_sessao != 'Cancelada') AS 'Convertidas',
	(SELECT COUNT(id_sessao) FROM tb_sessao INNER JOIN tb_usuario ON tb_usuario.id_usuario = tb_sessao.fk_fotografo WHERE MONTH(created_at) = MONTH(DATE_SUB(NOW(), INTERVAL 6 MONTH))) AS 'Total',
	(SELECT COUNT(id_sessao) FROM tb_sessao INNER JOIN tb_usuario ON tb_usuario.id_usuario = tb_sessao.fk_fotografo WHERE MONTH(created_at) = MONTH(DATE_SUB(NOW(), INTERVAL 6 MONTH)) AND status_sessao = 'Cancelada') AS 'Interrompidas'
UNION
SELECT
	MONTHNAME(DATE_SUB(NOW(), INTERVAL 5 MONTH)) AS 'Mes',
	(SELECT COUNT(id_sessao) FROM tb_sessao INNER JOIN tb_usuario ON tb_usuario.id_usuario = tb_sessao.fk_fotografo WHERE MONTH(created_at) = MONTH(DATE_SUB(NOW(), INTERVAL 5 MONTH)) AND status_sessao != 'Cancelada') AS 'Convertidas',
	(SELECT COUNT(id_sessao) FROM tb_sessao INNER JOIN tb_usuario ON tb_usuario.id_usuario = tb_sessao.fk_fotografo WHERE MONTH(created_at) = MONTH(DATE_SUB(NOW(), INTERVAL 5 MONTH))) AS 'Total',
	(SELECT COUNT(id_sessao) FROM tb_sessao INNER JOIN tb_usuario ON tb_usuario.id_usuario = tb_sessao.fk_fotografo WHERE MONTH(created_at) = MONTH(DATE_SUB(NOW(), INTERVAL 5 MONTH)) AND status_sessao = 'Cancelada') AS 'Interrompidas'
UNION
SELECT
	MONTHNAME(DATE_SUB(NOW(), INTERVAL 4 MONTH)) AS 'Mes',
	(SELECT COUNT(id_sessao) FROM tb_sessao INNER JOIN tb_usuario ON tb_usuario.id_usuario = tb_sessao.fk_fotografo WHERE MONTH(created_at) = MONTH(DATE_SUB(NOW(), INTERVAL 4 MONTH)) AND status_sessao != 'Cancelada') AS 'Convertidas',
	(SELECT COUNT(id_sessao) FROM tb_sessao INNER JOIN tb_usuario ON tb_usuario.id_usuario = tb_sessao.fk_fotografo WHERE MONTH(created_at) = MONTH(DATE_SUB(NOW(), INTERVAL 4 MONTH))) AS 'Total',
	(SELECT COUNT(id_sessao) FROM tb_sessao INNER JOIN tb_usuario ON tb_usuario.id_usuario = tb_sessao.fk_fotografo WHERE MONTH(created_at) = MONTH(DATE_SUB(NOW(), INTERVAL 4 MONTH)) AND status_sessao = 'Cancelada') AS 'Interrompidas'
UNION
SELECT
	MONTHNAME(DATE_SUB(NOW(), INTERVAL 3 MONTH)) AS 'Mes',
	(SELECT COUNT(id_sessao) FROM tb_sessao INNER JOIN tb_usuario ON tb_usuario.id_usuario = tb_sessao.fk_fotografo WHERE MONTH(created_at) = MONTH(DATE_SUB(NOW(), INTERVAL 3 MONTH)) AND status_sessao != 'Cancelada') AS 'Convertidas',
	(SELECT COUNT(id_sessao) FROM tb_sessao INNER JOIN tb_usuario ON tb_usuario.id_usuario = tb_sessao.fk_fotografo WHERE MONTH(created_at) = MONTH(DATE_SUB(NOW(), INTERVAL 3 MONTH))) AS 'Total',
	(SELECT COUNT(id_sessao) FROM tb_sessao INNER JOIN tb_usuario ON tb_usuario.id_usuario = tb_sessao.fk_fotografo WHERE MONTH(created_at) = MONTH(DATE_SUB(NOW(), INTERVAL 3 MONTH)) AND status_sessao = 'Cancelada') AS 'Interrompidas'
UNION
SELECT
	MONTHNAME(DATE_SUB(NOW(), INTERVAL 2 MONTH)) AS 'Mes',
	(SELECT COUNT(id_sessao) FROM tb_sessao INNER JOIN tb_usuario ON tb_usuario.id_usuario = tb_sessao.fk_fotografo WHERE MONTH(created_at) = MONTH(DATE_SUB(NOW(), INTERVAL 2 MONTH)) AND status_sessao != 'Cancelada') AS 'Convertidas',
	(SELECT COUNT(id_sessao) FROM tb_sessao INNER JOIN tb_usuario ON tb_usuario.id_usuario = tb_sessao.fk_fotografo WHERE MONTH(created_at) = MONTH(DATE_SUB(NOW(), INTERVAL 2 MONTH))) AS 'Total',
	(SELECT COUNT(id_sessao) FROM tb_sessao INNER JOIN tb_usuario ON tb_usuario.id_usuario = tb_sessao.fk_fotografo WHERE MONTH(created_at) = MONTH(DATE_SUB(NOW(), INTERVAL 2 MONTH)) AND status_sessao = 'Cancelada') AS 'Interrompidas'
UNION
SELECT
	MONTHNAME(DATE_SUB(NOW(), INTERVAL 1 MONTH)) AS 'Mes',
	(SELECT COUNT(id_sessao) FROM tb_sessao INNER JOIN tb_usuario ON tb_usuario.id_usuario = tb_sessao.fk_fotografo WHERE MONTH(created_at) = MONTH(DATE_SUB(NOW(), INTERVAL 1 MONTH)) AND status_sessao != 'Cancelada') AS 'Convertidas',
	(SELECT COUNT(id_sessao) FROM tb_sessao INNER JOIN tb_usuario ON tb_usuario.id_usuario = tb_sessao.fk_fotografo WHERE MONTH(created_at) = MONTH(DATE_SUB(NOW(), INTERVAL 1 MONTH))) AS 'Total',
	(SELECT COUNT(id_sessao) FROM tb_sessao INNER JOIN tb_usuario ON tb_usuario.id_usuario = tb_sessao.fk_fotografo WHERE MONTH(created_at) = MONTH(DATE_SUB(NOW(), INTERVAL 1 MONTH)) AND status_sessao = 'Cancelada') AS 'Interrompidas'
UNION
SELECT
	MONTHNAME(DATE_SUB(NOW(), INTERVAL 0 MONTH)) AS 'Mes',
	(SELECT COUNT(id_sessao) FROM tb_sessao INNER JOIN tb_usuario ON tb_usuario.id_usuario = tb_sessao.fk_fotografo WHERE MONTH(created_at) = MONTH(DATE_SUB(NOW(), INTERVAL 0 MONTH)) AND status_sessao != 'Cancelada') AS 'Convertidas',
	(SELECT COUNT(id_sessao) FROM tb_sessao INNER JOIN tb_usuario ON tb_usuario.id_usuario = tb_sessao.fk_fotografo WHERE MONTH(created_at) = MONTH(DATE_SUB(NOW(), INTERVAL 0 MONTH))) AS 'Total',
	(SELECT COUNT(id_sessao) FROM tb_sessao INNER JOIN tb_usuario ON tb_usuario.id_usuario = tb_sessao.fk_fotografo WHERE MONTH(created_at) = MONTH(DATE_SUB(NOW(), INTERVAL 0 MONTH)) AND status_sessao = 'Cancelada') AS 'Interrompidas';

        
-- View que retorna a progressão da quantidade de usuários cadastrados nos últimos 6 meses
CREATE VIEW vw_progressao_cadastro_usuarios
AS
	SELECT
		MONTHNAME(DATE_SUB(NOW(), INTERVAL 11 MONTH)) AS 'Mes', COUNT(id_usuario) AS 'Quantidade' FROM tb_usuario WHERE TIMESTAMPDIFF(MONTH, data_cadastro, CURDATE()) = 11
	UNION
	SELECT
		MONTHNAME(DATE_SUB(NOW(), INTERVAL 10 MONTH)) AS 'Mes', COUNT(id_usuario) AS 'Quantidade' FROM tb_usuario WHERE TIMESTAMPDIFF(MONTH, data_cadastro, CURDATE()) = 10
	UNION
	SELECT
		MONTHNAME(DATE_SUB(NOW(), INTERVAL 9 MONTH)) AS 'Mes', COUNT(id_usuario) AS 'Quantidade' FROM tb_usuario WHERE TIMESTAMPDIFF(MONTH, data_cadastro, CURDATE()) = 9
	UNION
	SELECT
		MONTHNAME(DATE_SUB(NOW(), INTERVAL 8 MONTH)) AS 'Mes', COUNT(id_usuario) AS 'Quantidade' FROM tb_usuario WHERE TIMESTAMPDIFF(MONTH, data_cadastro, CURDATE()) = 8
	UNION
	SELECT
		MONTHNAME(DATE_SUB(NOW(), INTERVAL 7 MONTH)) AS 'Mes', COUNT(id_usuario) AS 'Quantidade' FROM tb_usuario WHERE TIMESTAMPDIFF(MONTH, data_cadastro, CURDATE()) = 7
	UNION
	SELECT
		MONTHNAME(DATE_SUB(NOW(), INTERVAL 6 MONTH)) AS 'Mes', COUNT(id_usuario) AS 'Quantidade' FROM tb_usuario WHERE TIMESTAMPDIFF(MONTH, data_cadastro, CURDATE()) = 6
	UNION
    SELECT
		MONTHNAME(DATE_SUB(NOW(), INTERVAL 5 MONTH)) AS 'Mes', COUNT(id_usuario) AS 'Quantidade' FROM tb_usuario WHERE TIMESTAMPDIFF(MONTH, data_cadastro, CURDATE()) = 5
	UNION
    SELECT
		MONTHNAME(DATE_SUB(NOW(), INTERVAL 4 MONTH)) AS 'Mes', COUNT(id_usuario) AS 'Quantidade' FROM tb_usuario WHERE TIMESTAMPDIFF(MONTH, data_cadastro, CURDATE()) = 4
	UNION
    SELECT
		MONTHNAME(DATE_SUB(NOW(), INTERVAL 3 MONTH)) AS 'Mes', COUNT(id_usuario) AS 'Quantidade' FROM tb_usuario WHERE TIMESTAMPDIFF(MONTH, data_cadastro, CURDATE()) = 3
	UNION
    SELECT
		MONTHNAME(DATE_SUB(NOW(), INTERVAL 2 MONTH)) AS 'Mes', COUNT(id_usuario) AS 'Quantidade' FROM tb_usuario WHERE TIMESTAMPDIFF(MONTH, data_cadastro, CURDATE()) = 2
	UNION
    SELECT
		MONTHNAME(DATE_SUB(NOW(), INTERVAL 1 MONTH)) AS 'Mes', COUNT(id_usuario) AS 'Quantidade' FROM tb_usuario WHERE TIMESTAMPDIFF(MONTH, data_cadastro, CURDATE()) = 1
	UNION
	SELECT
		MONTHNAME(DATE_SUB(NOW(), INTERVAL 0 MONTH)) AS 'Mes', COUNT(id_usuario) AS 'Quantidade' FROM tb_usuario WHERE TIMESTAMPDIFF(MONTH, data_cadastro, CURDATE()) = 0;
        
-- View que retorna a progressão da quantidade de eventos concluidos
CREATE VIEW vw_progressao_sessoes_realizadas
AS
	SELECT
		MONTHNAME(DATE_SUB(NOW(), INTERVAL 11 MONTH)) AS 'Mes', COUNT(id_sessao) AS 'Quantidade' FROM tb_sessao WHERE TIMESTAMPDIFF(MONTH, data_realizacao, CURDATE()) = 11 AND status_sessao = 'Realizada'
	UNION
	SELECT
		MONTHNAME(DATE_SUB(NOW(), INTERVAL 10 MONTH)) AS 'Mes', COUNT(id_sessao) AS 'Quantidade' FROM tb_sessao WHERE TIMESTAMPDIFF(MONTH, data_realizacao, CURDATE()) = 10 AND status_sessao = 'Realizada'
	UNION
	SELECT
		MONTHNAME(DATE_SUB(NOW(), INTERVAL 9 MONTH)) AS 'Mes', COUNT(id_sessao) AS 'Quantidade' FROM tb_sessao WHERE TIMESTAMPDIFF(MONTH, data_realizacao, CURDATE()) = 9 AND status_sessao = 'Realizada'
	UNION
	SELECT
		MONTHNAME(DATE_SUB(NOW(), INTERVAL 8 MONTH)) AS 'Mes', COUNT(id_sessao) AS 'Quantidade' FROM tb_sessao WHERE TIMESTAMPDIFF(MONTH, data_realizacao, CURDATE()) = 8 AND status_sessao = 'Realizada'
	UNION
	SELECT
		MONTHNAME(DATE_SUB(NOW(), INTERVAL 7 MONTH)) AS 'Mes', COUNT(id_sessao) AS 'Quantidade' FROM tb_sessao WHERE TIMESTAMPDIFF(MONTH, data_realizacao, CURDATE()) = 7 AND status_sessao = 'Realizada'
	UNION
	SELECT
		MONTHNAME(DATE_SUB(NOW(), INTERVAL 6 MONTH)) AS 'Mes', COUNT(id_sessao) AS 'Quantidade' FROM tb_sessao WHERE TIMESTAMPDIFF(MONTH, data_realizacao, CURDATE()) = 6 AND status_sessao = 'Realizada'
	UNION
    SELECT
		MONTHNAME(DATE_SUB(NOW(), INTERVAL 5 MONTH)) AS 'Mes', COUNT(id_sessao) AS 'Quantidade' FROM tb_sessao WHERE TIMESTAMPDIFF(MONTH, data_realizacao, CURDATE()) = 5 AND status_sessao = 'Realizada'
	UNION
    SELECT
		MONTHNAME(DATE_SUB(NOW(), INTERVAL 4 MONTH)) AS 'Mes', COUNT(id_sessao) AS 'Quantidade' FROM tb_sessao WHERE TIMESTAMPDIFF(MONTH, data_realizacao, CURDATE()) = 4 AND status_sessao = 'Realizada'
	UNION
    SELECT
		MONTHNAME(DATE_SUB(NOW(), INTERVAL 3 MONTH)) AS 'Mes', COUNT(id_sessao) AS 'Quantidade' FROM tb_sessao WHERE TIMESTAMPDIFF(MONTH, data_realizacao, CURDATE()) = 3 AND status_sessao = 'Realizada'
	UNION
    SELECT
		MONTHNAME(DATE_SUB(NOW(), INTERVAL 2 MONTH)) AS 'Mes', COUNT(id_sessao) AS 'Quantidade' FROM tb_sessao WHERE TIMESTAMPDIFF(MONTH, data_realizacao, CURDATE()) = 2 AND status_sessao = 'Realizada'
	UNION
    SELECT
		MONTHNAME(DATE_SUB(NOW(), INTERVAL 1 MONTH)) AS 'Mes', COUNT(id_sessao) AS 'Quantidade' FROM tb_sessao WHERE TIMESTAMPDIFF(MONTH, data_realizacao, CURDATE()) = 1 AND status_sessao = 'Realizada'
	UNION
	SELECT
		MONTHNAME(DATE_SUB(NOW(), INTERVAL 0 MONTH)) AS 'Mes', COUNT(id_sessao) AS 'Quantidade' FROM tb_sessao WHERE TIMESTAMPDIFF(MONTH, data_realizacao, CURDATE()) = 0 AND status_sessao = 'Realizada';
	
-- SET lc_time_names = 'pt_BR';
CREATE VIEW vw_fluxo_sessoes_covertidas
AS
	SELECT 
		COALESCE(COUNT(id_sessao), 0) as 'Quantidade', MONTHNAME(data_realizacao) AS 'Mes', YEAR(data_realizacao) AS 'Ano', 'Total' AS 'StatusSessao' FROM tb_sessao
	UNION
	SELECT 
		COALESCE(COUNT(id_sessao), 0) as 'Quantidade', MONTHNAME(data_realizacao) AS 'Mes', YEAR(data_realizacao) AS 'Ano', 'Propostas' AS 'StatusSessao' FROM tb_sessao WHERE status_sessao IN ('Proposta', 'Aceita', 'Em Negociação', 'Agendada', 'Realizada')
	UNION
	SELECT 
		COALESCE(COUNT(id_sessao), 0) as 'Quantidade', MONTHNAME(data_realizacao) AS 'Mes', YEAR(data_realizacao) AS 'Ano', 'Aceitas' AS 'StatusSessao' FROM tb_sessao WHERE status_sessao IN ('Aceita', 'Em Negociação', 'Agendada', 'Realizada')
	UNION
	SELECT 
		COALESCE(COUNT(id_sessao), 0) as 'Quantidade', MONTHNAME(data_realizacao) AS 'Mes', YEAR(data_realizacao) AS 'Ano', 'Em Negociação' AS 'StatusSessao' FROM tb_sessao WHERE status_sessao IN ('Em Negociação', 'Agendada', 'Realizada')
	UNION
	SELECT 
		COALESCE(COUNT(id_sessao), 0) as 'Quantidade', MONTHNAME(data_realizacao) AS 'Mes', YEAR(data_realizacao) AS 'Ano', 'Agendadas' AS 'StatusSessao' FROM tb_sessao WHERE status_sessao IN ('Agendada', 'Realizada')
	UNION
	SELECT 
		COALESCE(COUNT(id_sessao), 0), MONTHNAME(data_realizacao) AS 'Mes', YEAR(data_realizacao) AS 'Ano', 'Realizadas' AS 'StatusSessao' FROM tb_sessao WHERE status_sessao = 'Realizada'
	GROUP BY Mes, Ano;

CREATE VIEW vw_formas_pagamentos_populares
AS
	SELECT 
		forma,
		COUNT(id_pagamento) as 'Total', 
		MONTHNAME(data_realizacao) AS 'Mes', 
		YEAR(data_realizacao) AS 'Ano' 
	FROM tb_pagamento INNER JOIN tb_sessao ON tb_sessao.id_sessao = tb_pagamento.fk_sessao
	GROUP BY forma, Mes, Ano
	ORDER BY Total DESC
	LIMIT 5;
        
-- View KPI 1 - Usuários cadastros no mês atual e no último mês
CREATE VIEW vw_kpi_usuarios_mes
AS 
    SELECT 
		MONTHNAME(NOW()) AS 'Mes', (SELECT COUNT(id_usuario) FROM tb_usuario WHERE DATEDIFF(CURDATE(), data_cadastro) <= 31) AS 'Quantidade'
	UNION
    SELECT 
		MONTHNAME(DATE_SUB(NOW(), INTERVAL 1 MONTH)) AS 'Mes', (SELECT COUNT(id_usuario) FROM tb_usuario WHERE DATEDIFF(CURDATE(), data_cadastro) > 31 AND DATEDIFF(CURDATE(), data_cadastro) <= 62);
	
-- View KPI 2 - Sessões realizadas no mês atual e no último mês
CREATE VIEW vw_kpi_sessoes_mes
AS
    SELECT 
		MONTHNAME(NOW()) AS 'Mes', (SELECT COUNT(id_sessao) FROM tb_sessao WHERE status_sessao != 'Cancelada' AND DATEDIFF(CURDATE(), data_realizacao) <= 31) AS 'Sessoes'
	UNION
    SELECT 
		MONTHNAME(DATE_SUB(NOW(), INTERVAL 1 MONTH)) AS 'Mes', (SELECT COUNT(id_sessao) FROM tb_sessao WHERE status_sessao != 'Cancelada' AND DATEDIFF(CURDATE(), data_realizacao) > 31 AND DATEDIFF(CURDATE(), data_realizacao) <= 62) AS 'Sessoes';

-- View KPI 3 - Acessos no mês atual e no último mês         
CREATE VIEW vw_kpi_acessos_mes
AS
    SELECT 
		MONTHNAME(NOW()) AS 'Mes', (SELECT COUNT(fk_usuario) FROM tb_log_acessos WHERE DATEDIFF(CURDATE(), data_login) <= 31) AS 'Acessos'
	UNION
    SELECT 
		MONTHNAME(DATE_SUB(NOW(), INTERVAL 1 MONTH)) AS 'Mes', (SELECT COUNT(fk_usuario) FROM tb_log_acessos WHERE DATEDIFF(CURDATE(), data_login) > 31 AND DATEDIFF(CURDATE(), data_login) <= 62) AS 'Acessos';