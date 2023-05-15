-- View retorna quantos clientes que se cadastraram na semana e criaram um 'evento', e quantos clientes se cadastraram na semana
CREATE VIEW vw_Clientes_acordo_1semana
AS
	SELECT
		(SELECT COUNT(DISTINCT idUsuario) FROM (SELECT idUsuario FROM Usuario INNER JOIN Evento ON Usuario.idUsuario = Evento.fkCliente WHERE DATEDIFF(CURDATE(), dataCadastro) <= 7 AND tipoUsuario LIKE 'Cliente') AS ClientesImediatos) AS 'Clientes Semana',
        (SELECT COUNT(DISTINCT idUsuario) FROM (SELECT idUsuario FROM Usuario WHERE DATEDIFF(CURDATE(), dataCadastro) <= 7 AND tipoUsuario LIKE 'Cliente') AS ClientesSemana) AS 'Clientes Totais'