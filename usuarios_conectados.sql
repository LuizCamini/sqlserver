-- usuarios conectados sql server
SELECT
    processos.login_time AS [Data Inicio]
    ,DATEDIFF(minute,processos.login_time,getdate()) AS [Tempo Conectado]
    ,processos.spid AS [SPID]
    ,bases.name AS [Banco]
    ,processos.loginame AS [Usuario]
    ,processos.hostname AS [Hostname]
    ,processos.program_name AS [Programa]
    ,processos.cmd AS [Comando]
    
FROM
    sysprocesses processos
    INNER JOIN sysdatabases bases ON (
        processos.dbid=bases.dbid
    )
    INNER JOIN sysusers usuarios ON (
        processos.uid=usuarios.uid
    )
WHERE bases.name NOT IN ('master','model','msdb','tempdb')
ORDER BY
    [Tempo Conectado] desc;

