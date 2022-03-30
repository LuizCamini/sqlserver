------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------
--FONTE: https://dba-pro.com/como-monitorar-iniciar-e-parar-servicos-do-windows-no-sql-server/--------------
------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------



------------------------------------------------------------------
-- Gerenciando serviços do Windows via SQL
------------------------------------------------------------------
 
--------------------------------------------------
-- Quero só consultar o status de um serviço:
--------------------------------------------------
exec xp_servicecontrol 'querystate', 'Spooler'
 
 
--------------------------------------------------
-- Quero fazer STOP/START dos serviços:
--------------------------------------------------
-- PASSO 1) Pré-requisito: Permissão de start/stop para a conta do SQL Server no serviço do windows. 
/* 
= Jeito fácil para 1 estação:
Download da do subinacl: http://www.microsoft.com/en-us/download/details.aspx?id=23510
Fornecer a permissão: subinacl /service spooler /grant=MSSQLSERVER=F
 
= Configuração via GPO para domínios:
https://social.technet.microsoft.com/wiki/contents/articles/5752.how-to-grant-users-rights-to-manage-services-start-stop-etc.aspx
 
*/
 
-- PASSO 2) xp_ServiceControl: Gerencia serviços do Windows
exec xp_servicecontrol 'stop', 'Spooler'
exec xp_servicecontrol 'querystate', 'Spooler'
exec xp_servicecontrol 'start', 'Spooler'
exec xp_servicecontrol 'querystate', 'Spooler'
 
 
--------------------------------------------------
-- Quero listar só os serviços do SQL
--------------------------------------------------
-- Só serviços do SQL
select * from sys.dm_server_services
 
 
--------------------------------------------------
-- Quero listar TODOS os serviços do Windows
--------------------------------------------------
-- Existem várias formas, "sp_cmdshell + SC" é uma das mais rápidas
 
-- PASSO 1) Fornecer permissão para o SQL acessar o MSDOS
exec sp_configure 'show advanced options', 1
reconfigure
exec sp_configure 'ole Automation Procedures', 1
exec sp_configure 'xp_cmdshell', 1
reconfigure
go
 
-- PASSO 2) Listar serviços usando utilitário SC do Windows com a xp_cmdshell
if object_id('tempdb.dbo.#info_servicos') is not null drop table #info_servicos
create table #info_servicos(linha smallint identity(1,1) primary key clustered, conteudo varchar(max))
insert into #info_servicos(conteudo) exec master.dbo.xp_cmdshell 'sc queryex type= service state= all'
 
select
    substring(l1.conteudo, 15, 200) as servico,
    substring(l2.conteudo, 15, 200) as display_name,
    substring(l3.conteudo, 33, 200) as status
from #info_servicos l1
inner join #info_servicos l2 on l1.linha = l2.linha - 1
inner join #info_servicos l3 on l1.linha = l3.linha - 3
where l1.conteudo like 'service_name%'
