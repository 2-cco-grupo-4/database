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
WHERE tb_sessao.status_sessao = 'Finalizada'
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
   
   use PICME;
    
    
-- View que retorna as propostas recebidas no mês atual, não contabilizando as sessões realizadas e canceladas
CREATE VIEW vw_kpi_propostas_recebidas_mes_atual AS
SELECT
    tb_usuario.id_usuario AS 'Fotografo',
    MONTHNAME(NOW()) as 'MesAtual',
    -- Corrigir a partir daqui
    (SELECT COUNT(id_sessao) AS 'Total' FROM tb_sessao INNER JOIN tb_usuario ON tb_sessao.fk_fotografo = tb_usuario.id_usuario WHERE MONTH(tb_sessao.created_at) = MONTH(NOW()) AND tb_sessao.status_sessao != 'Realizada' AND  tb_sessao.status_sessao != 'Cancelada') as 'MesAtualTotal',
    MONTHNAME(DATE_SUB(NOW(), INTERVAL 1 MONTH)) AS 'MesAnterior',
    (SELECT COUNT(id_sessao) AS 'Total' FROM tb_sessao INNER JOIN tb_usuario ON tb_sessao.fk_fotografo = tb_usuario.id_usuario WHERE MONTH(tb_sessao.created_at) = MONTH(DATE_SUB(NOW(), INTERVAL 1 MONTH)) AND tb_sessao.status_sessao != 'Realizada' AND  tb_sessao.status_sessao != 'Cancelada') as 'MesAnteriorTotal'
FROM
    tb_sessao
inner join
	tb_usuario
on
	tb_usuario.id_usuario = tb_sessao.fk_fotografo
GROUP BY
    tb_usuario.id_usuario;
    

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
    tb_tema.id_tema,
    tb_tema.nome AS nome_tema,
    AVG(tb_avaliacao.nota) AS 'AvaliacaoMedia'
FROM
    tb_avaliacao
INNER JOIN
    tb_sessao ON tb_avaliacao.fk_sessao = tb_sessao.id_sessao
INNER JOIN
    tb_tema ON tb_sessao.fk_tema = tb_tema.id_tema
WHERE
    tb_sessao.status_sessao = 'Realizada'
GROUP BY
    tb_tema.id_tema, tb_tema.nome;
    
    
-- View que retorna a variação de lucro nos últimos meses
CREATE VIEW vw_variacao_lucro_ultimos_meses AS
SELECT
    tb_usuario.id_usuario AS id_fotografo,
    tb_usuario.nome AS nome_fotografo,
    (
        SELECT SUM(tb_pagamento.valor)
        FROM tb_pagamento
        INNER JOIN tb_sessao ON tb_pagamento.fk_sessao = tb_sessao.id_sessao
        WHERE
            tb_sessao.fk_fotografo = tb_usuario.id_usuario AND
            MONTH(tb_sessao.data_realizacao) = MONTH(NOW())
    ) AS lucro_mes_atual,
    (
        SELECT SUM(tb_pagamento.valor)
        FROM tb_pagamento
        INNER JOIN tb_sessao ON tb_pagamento.fk_sessao = tb_sessao.id_sessao
        WHERE
            tb_sessao.fk_fotografo = tb_usuario.id_usuario AND
            MONTH(tb_sessao.data_realizacao) = MONTH(NOW()) - 1
    ) AS lucro_mes_1_antes,
    (
        SELECT SUM(tb_pagamento.valor)
        FROM tb_pagamento
        INNER JOIN tb_sessao ON tb_pagamento.fk_sessao = tb_sessao.id_sessao
        WHERE
            tb_sessao.fk_fotografo = tb_usuario.id_usuario AND
            MONTH(tb_sessao.data_realizacao) = MONTH(NOW()) - 2
    ) AS lucro_mes_2_antes,
    (
        SELECT SUM(tb_pagamento.valor)
        FROM tb_pagamento
        INNER JOIN tb_sessao ON tb_pagamento.fk_sessao = tb_sessao.id_sessao
        WHERE
            tb_sessao.fk_fotografo = tb_usuario.id_usuario AND
            MONTH(tb_sessao.data_realizacao) = MONTH(NOW()) - 3
    ) AS lucro_mes_3_antes,
    (
        SELECT SUM(tb_pagamento.valor)
        FROM tb_pagamento
        INNER JOIN tb_sessao ON tb_pagamento.fk_sessao = tb_sessao.id_sessao
        WHERE
            tb_sessao.fk_fotografo = tb_usuario.id_usuario AND
            MONTH(tb_sessao.data_realizacao) = MONTH(NOW()) - 4
    ) AS lucro_mes_4_antes
FROM
    tb_usuario;


    



    
    




