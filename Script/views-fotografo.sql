SET lc_time_names = 'pt_BR';


-- View que retorna valor médio cobrado das sessões do fotográfo (média de todas as sessões já realizadas)
CREATE VIEW vw_kpi_valor_medio_cobrado AS
SELECT
    u.id_usuario AS id_fotografo,
    u.nome AS nome_fotografo,
    AVG(p.valor) AS valor_medio_cobrado
FROM
    tb_pagamento p
INNER JOIN
    tb_sessao s ON p.fk_sessao = s.id_sessao
INNER JOIN
    tb_usuario u ON s.fk_fotografo = u.id_usuario
    
WHERE tb_sessao.status_sessao = 'Finalizada'

GROUP BY
    u.id_usuario, u.nome;

-- View que retorna as sessões agendadas no mês atual do fotógrafo
CREATE VIEW vw_kpi_sessoes_agendadas_mes AS
SELECT
    u.id_usuario AS id_fotografo,
    u.nome AS nome_fotografo,
    COUNT(*) AS total_sessoes_agendadas_mes
FROM
    tb_sessao s
INNER JOIN
    tb_usuario u ON s.fk_fotografo = u.id_usuario
WHERE
    MONTH(s.data_realizacao) = MONTH(NOW())
GROUP BY
    u.id_usuario, u.nome;
    
    
-- View que retorna as propostas recebidas no mês atual, não contabilizando as sessões realizadas e canceladas
CREATE VIEW vw_kpi_propostas_recebidas_mes_atual AS
SELECT
    u.id_usuario AS id_fotografo,
    u.nome AS nome_fotografo,
    COUNT(*) AS total_propostas_recebidas_mes_atual
FROM
    tb_sessao s
INNER JOIN
    tb_usuario u ON s.fk_fotografo = u.id_usuario
WHERE
    MONTH(s.data_realizacao) = MONTH(NOW()) AND
    s.status_sessao != 'Realizada' AND  s.status_sessao != 'Cancelada'
GROUP BY
    u.id_usuario, u.nome;
    

-- View que retorna a variação do lucro no mês atual, comparando com o mês anterior
CREATE VIEW vw_kpi_variacao_lucro_mensal AS
SELECT
    s.fk_fotografo AS id_fotografo,
    u.nome AS nome_fotografo,
    SUM(CASE WHEN MONTH(s.data_realizacao) = MONTH(NOW()) THEN p.valor ELSE 0 END) AS lucro_mes_atual,
    SUM(CASE WHEN MONTH(s.data_realizacao) = MONTH(NOW()) - 1 THEN p.valor ELSE 0 END) AS lucro_mes_anterior
FROM
    tb_pagamento p
INNER JOIN
    tb_sessao s ON p.fk_sessao = s.id_sessao
INNER JOIN
    tb_usuario u ON s.fk_fotografo = u.id_usuario
WHERE
    MONTH(s.data_realizacao) = MONTH(NOW()) OR
    MONTH(s.data_realizacao) = MONTH(NOW()) - 1
GROUP BY
    s.fk_fotografo, u.nome;
    
    
-- View que retorna a média de avaliação por tema

CREATE VIEW vw_kpi_media_avaliacao_por_tema AS
SELECT
    t.id_tema,
    t.nome AS nome_tema,
    AVG(a.nota) AS media_avaliacao
FROM
    tb_avaliacao a
INNER JOIN
    tb_sessao s ON a.fk_sessao = s.id_sessao
INNER JOIN
    tb_tema t ON s.fk_tema = t.id_tema
WHERE
    s.status_sessao = 'Realizada'
GROUP BY
    t.id_tema, t.nome;
    
    
-- View que retorna a variação de lucro nos últimos meses
CREATE VIEW vw_kpi_variacao_lucro_ultimos_meses AS
SELECT
    u.id_usuario AS id_fotografo,
    u.nome AS nome_fotografo,
    (
        SELECT SUM(p.valor)
        FROM tb_pagamento p
        INNER JOIN tb_sessao s ON p.fk_sessao = s.id_sessao
        WHERE
            s.fk_fotografo = u.id_usuario AND
            MONTH(s.data_realizacao) = MONTH(NOW())
    ) AS lucro_mes_atual,
    (
        SELECT SUM(p.valor)
        FROM tb_pagamento p
        INNER JOIN tb_sessao s ON p.fk_sessao = s.id_sessao
        WHERE
            s.fk_fotografo = u.id_usuario AND
            MONTH(s.data_realizacao) = MONTH(NOW()) - 1
    ) AS lucro_mes_1_antes,
    (
        SELECT SUM(p.valor)
        FROM tb_pagamento p
        INNER JOIN tb_sessao s ON p.fk_sessao = s.id_sessao
        WHERE
            s.fk_fotografo = u.id_usuario AND
            MONTH(s.data_realizacao) = MONTH(NOW()) - 2
    ) AS lucro_mes_2_antes,
    (
        SELECT SUM(p.valor)
        FROM tb_pagamento p
        INNER JOIN tb_sessao s ON p.fk_sessao = s.id_sessao
        WHERE
            s.fk_fotografo = u.id_usuario AND
            MONTH(s.data_realizacao) = MONTH(NOW()) - 3
    ) AS lucro_mes_3_antes,
    (
        SELECT SUM(p.valor)
        FROM tb_pagamento p
        INNER JOIN tb_sessao s ON p.fk_sessao = s.id_sessao
        WHERE
            s.fk_fotografo = u.id_usuario AND
            MONTH(s.data_realizacao) = MONTH(NOW()) - 4
    ) AS lucro_mes_4_antes
FROM
    tb_usuario u;
    
    SELECT * FROM vw_kpi_variacao_lucro_ultimos_meses;


    



    
    




