SET lc_time_names = 'pt_BR';

use picme;

-- View que retorna valor médio cobrado das sessões do fotográfo (média de todas as sessões já realizadas)
CREATE VIEW vw_kpi_valor_medio_cobrado AS
SELECT
	tb_usuario.id_usuario as 'Fotografo',
    AVG(tb_pagamento.valor) AS 'Media'
FROM
    tb_pagamento
INNER JOIN
    tb_sessao ON tb_pagamento.fk_sessao = tb_sessao.id_sessao
INNER JOIN
    tb_usuario ON tb_sessao.fk_fotografo = tb_usuario.id_usuario
WHERE tb_sessao.status_sessao = 'Realizada'
GROUP BY
    tb_usuario.id_usuario;

-- View que retorna as sessões agendadas no mês atual do fotógrafo
CREATE VIEW vw_kpi_sessoes_agendadas_mes AS
SELECT
    tb_usuario.id_usuario AS 'Fotografo',
    COUNT(id_sessao) AS 'Total'
FROM
    tb_sessao
INNER JOIN
    tb_usuario ON tb_sessao.fk_fotografo = tb_usuario.id_usuario
WHERE
    MONTH(tb_sessao.created_at) = MONTH(NOW())
GROUP BY
    tb_usuario.id_usuario;
    
    
-- View que retorna as propostas recebidas no mês atual, não contabilizando as sessões realizadas e canceladas

SELECT * FROM VW_KPI_PROPOSTAS_RECEBIDAS_MES_ATUAL WHERE Fotografo = 5;
   
CREATE VIEW vw_kpi_propostas_recebidas_mes_atual AS
SELECT
    tb_usuario.id_usuario AS 'Fotografo',
    MONTHNAME(NOW()) as 'MesAtual',
    (
        SELECT COUNT(tb_sessao.id_sessao) AS 'Total'
        FROM tb_sessao
        INNER JOIN tb_usuario AS usuario_sessaos ON tb_sessao.fk_fotografo = usuario_sessaos.id_usuario
        WHERE
            MONTH(tb_sessao.created_at) = MONTH(NOW())
            AND usuario_sessaos.id_usuario = tb_usuario.id_usuario
            AND tb_sessao.status_sessao != 'Realizada'
            AND tb_sessao.status_sessao != 'Cancelada'
    ) as 'MesAtualTotal',
    MONTHNAME(DATE_SUB(NOW(), INTERVAL 1 MONTH)) AS 'MesAnterior',
    (
        SELECT COUNT(tb_sessao.id_sessao) AS 'Total'
        FROM tb_sessao
        INNER JOIN tb_usuario AS usuario_sessaos ON tb_sessao.fk_fotografo = usuario_sessaos.id_usuario
        WHERE
            MONTH(tb_sessao.created_at) = MONTH(DATE_SUB(NOW(), INTERVAL 1 MONTH))
            AND usuario_sessaos.id_usuario = tb_usuario.id_usuario
            AND tb_sessao.status_sessao != 'Realizada'
            AND tb_sessao.status_sessao != 'Cancelada'
    ) as 'MesAnteriorTotal'
FROM
    tb_sessao
INNER JOIN
    tb_usuario
ON
    tb_usuario.id_usuario = tb_sessao.fk_fotografo
GROUP BY tb_usuario.id_usuario;
    

-- View que retorna a variação do lucro no mês atual, comparando com o mês anterior
CREATE VIEW vw_kpi_variacao_lucro_mensal AS
SELECT
    tb_sessao.fk_fotografo AS 'Fotografo',
    SUM(CASE WHEN MONTH(tb_sessao.data_realizacao) = MONTH(NOW()) and tb_sessao.status_sessao like 'Realizada' THEN tb_pagamento.valor ELSE 0 END) AS 'Atual',
    SUM(CASE WHEN MONTH(tb_sessao.data_realizacao) = MONTH(NOW()) - 1 THEN tb_pagamento.valor ELSE 0 END) AS 'Passado'
FROM
    tb_pagamento
INNER JOIN
    tb_sessao ON tb_pagamento.fk_sessao = tb_sessao.id_sessao
INNER JOIN
    tb_usuario ON tb_sessao.fk_fotografo = tb_usuario.id_usuario
WHERE
    MONTH(tb_sessao.data_realizacao) = MONTH(NOW()) OR
    MONTH(tb_sessao.data_realizacao) = MONTH(NOW()) - 1
GROUP BY
    tb_sessao.fk_fotografo, tb_usuario.nome;
    
    
-- View que retorna a média de avaliação por tema
CREATE VIEW vw_media_avaliacao_por_tema AS
SELECT
    tb_tema.nome AS 'Tema',
    AVG(tb_avaliacao.nota) AS 'Media',
    tb_usuario.id_usuario AS 'User'
FROM
    tb_avaliacao
INNER JOIN
    tb_sessao ON tb_avaliacao.fk_sessao = tb_sessao.id_sessao
INNER JOIN
    tb_tema ON tb_sessao.fk_tema = tb_tema.id_tema
INNER JOIN
	tb_usuario ON tb_usuario.id_usuario = tb_sessao.fk_fotografo
WHERE
    tb_sessao.status_sessao = 'Realizada';
      
-- View que retorna a variação de lucro nos últimos meses
CREATE VIEW vw_variacao_lucro_ultimos_meses AS
SELECT
	MONTHNAME(DATE_SUB(NOW(), INTERVAL 4 MONTH)) AS 'Mes',
	(SELECT (COALESCE(SUM(tb_pagamento.valor), 0)) FROM tb_pagamento INNER JOIN tb_sessao ON tb_pagamento.fk_sessao = tb_sessao.id_sessao WHERE tb_sessao.fk_fotografo = tb_usuario.id_usuario AND MONTH(tb_sessao.data_realizacao) = MONTH(NOW()) - 4) AS Lucro,
	id_usuario as 'User' FROM tb_usuario
UNION
SELECT
	MONTHNAME(DATE_SUB(NOW(), INTERVAL 3 MONTH)) AS 'Mes',
	(SELECT (COALESCE(SUM(tb_pagamento.valor), 0)) FROM tb_pagamento INNER JOIN tb_sessao ON tb_pagamento.fk_sessao = tb_sessao.id_sessao WHERE tb_sessao.fk_fotografo = tb_usuario.id_usuario AND MONTH(tb_sessao.data_realizacao) = MONTH(NOW()) - 3) AS Lucro,
	id_usuario as 'User' FROM tb_usuario
UNION
SELECT
	MONTHNAME(DATE_SUB(NOW(), INTERVAL 2 MONTH)) AS 'Mes',
	(SELECT (COALESCE(SUM(tb_pagamento.valor), 0)) FROM tb_pagamento INNER JOIN tb_sessao ON tb_pagamento.fk_sessao = tb_sessao.id_sessao WHERE tb_sessao.fk_fotografo = tb_usuario.id_usuario AND MONTH(tb_sessao.data_realizacao) = MONTH(NOW()) - 2) AS Lucro,
	id_usuario as 'User' FROM tb_usuario
UNION
SELECT
	MONTHNAME(DATE_SUB(NOW(), INTERVAL 1 MONTH)) AS 'Mes',
    (SELECT (COALESCE(SUM(tb_pagamento.valor), 0)) FROM tb_pagamento INNER JOIN tb_sessao ON tb_pagamento.fk_sessao = tb_sessao.id_sessao WHERE tb_sessao.fk_fotografo = tb_usuario.id_usuario AND MONTH(tb_sessao.data_realizacao) = MONTH(NOW()) - 1) AS Lucro,
	id_usuario as 'User' FROM tb_usuario
UNION
SELECT
	MONTHNAME(DATE_SUB(NOW(), INTERVAL 0 MONTH)) AS 'Mes',
    (SELECT (COALESCE(SUM(tb_pagamento.valor), 0)) FROM tb_pagamento INNER JOIN tb_sessao ON tb_pagamento.fk_sessao = tb_sessao.id_sessao WHERE tb_sessao.fk_fotografo = tb_usuario.id_usuario AND MONTH(tb_sessao.data_realizacao) = MONTH(NOW())) AS Lucro,
	id_usuario as 'User' FROM tb_usuario;

-- View que retorna a taxa de conversão / interrupções de conversas do fotógrafo no último ano
CREATE VIEW vw_contatos_convertidos_sessao AS
SELECT
    meses.mes AS 'Mes',
    COALESCE(COUNT(tb_sessao.id_sessao), 0) AS 'Convertidas',
    COALESCE(COUNT(tb_sessao.id_sessao), 0) AS 'Total',
    COALESCE(COUNT(tb_sessao.id_sessao), 0) AS 'Interrompidas',
    tb_usuario.id_usuario as 'User'
FROM (
    SELECT 'January' AS mes
    UNION SELECT 'February'
    UNION SELECT 'March'
    UNION SELECT 'April'
    UNION SELECT 'May'
    UNION SELECT 'June'
    UNION SELECT 'July'
    UNION SELECT 'August'
    UNION SELECT 'September'
    UNION SELECT 'October'
    UNION SELECT 'November'
    UNION SELECT 'December'
) meses
LEFT JOIN tb_usuario ON 1 = 1
LEFT JOIN tb_sessao ON
    tb_usuario.id_usuario = tb_sessao.fk_fotografo
    AND meses.mes = MONTHNAME(tb_sessao.created_at)
    AND YEAR(tb_sessao.created_at) = YEAR(DATE_SUB(NOW(), INTERVAL 1 YEAR))
GROUP BY meses.mes, tb_usuario.id_usuario
ORDER BY meses.mes, tb_usuario.id_usuario;

select * from VW_CONTATOS_CONVERTIDOS_SESSAO where User = 5;



