--EXTRAI SOMENTE STRING
CREATE FUNCTION [dbo].[fnOnlyString] ( @str VARCHAR(500) )
RETURNS VARCHAR(500)
BEGIN
 
    DECLARE @startingIndex INT = 0
    
    WHILE (1 = 1)
    BEGIN
        
        SET @startingIndex = PATINDEX('%[^a-Z|^ ]%', @str)
        
        IF @startingIndex <> 0
        BEGIN
            SET @str = REPLACE(@str, SUBSTRING(@str, @startingIndex, 1), '')
        END
        ELSE
            BREAK
 
    END
 
    RETURN @str
 
END
GO

--EXTRAI SOMENTE NUMEROS DE UMA STRNING
CREATE FUNCTION [dbo].[fnOnlyNumb](
	@Resultado VARCHAR(8000)
)
 RETURNS VARCHAR(8000)
 AS
 BEGIN
    DECLARE @CharInvalido SMALLINT
    SET @CharInvalido = PATINDEX('%[^0-9]%', @Resultado)
    WHILE @CharInvalido > 0
    BEGIN
       SET @Resultado = STUFF(@Resultado, @CharInvalido, 1, '')
       SET @CharInvalido = PATINDEX('%[^0-9]%', @Resultado)
    END
    SET @Resultado = @Resultado
    RETURN @Resultado
 END
GO



--REMOVE ACENTO STRING
Create Function [dbo].[fnTiraAcento] (@cExpressao varchar(max))
Returns varchar(max)
as
Begin
   Declare @cRetorno varchar(max)
   
   Set @cRetorno = @cExpressao collate sql_latin1_general_cp1251_cs_as
   
   Return @cRetorno
   
End

GO

CREATE FUNCTION [dbo].[fnRemoveAcentuacao](
    @String VARCHAR(MAX)
)
RETURNS VARCHAR(MAX)
AS
BEGIN
    
    /****************************************************************************************************************/
    /** RETIRA ACENTUAÇÃO DAS VOGAIS **/
    /****************************************************************************************************************/
    SET @String = REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(@String,'á','a'),'à','a'),'â','a'),'ã','a'),'ä','a')
    SET @String = REPLACE(REPLACE(REPLACE(REPLACE(@String,'é','e'),'è','e'),'ê','e'),'ë','e')
    SET @String = REPLACE(REPLACE(REPLACE(REPLACE(@String,'í','i'),'ì','i'),'î','i'),'ï','i')
    SET @String = REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(@String,'ó','o'),'ò','o'),'ô','o'),'õ','o'),'ö','o')
    SET @String = REPLACE(REPLACE(REPLACE(REPLACE(@String,'ú','u'),'ù','u'),'û','u'),'ü','u')
    
    /****************************************************************************************************************/
    /** RETIRA ACENTUAÇÃO DAS CONSOANTES **/
    /****************************************************************************************************************/
    SET @String = REPLACE(@String,'ý','y')
    SET @String = REPLACE(@String,'ñ','n')
    SET @String = REPLACE(@String,'ç','c')
    SET @String = REPLACE(@String,'-',' ')
    SET @String = REPLACE(@String,'''',' ')
    
    RETURN UPPER(@String)

END

GO



--TESTE DE FUNÇÕES
SELECT 
	DBO.fnOnlyString('CAIQUE456LUIZ546987QUEIROZ789798CAMINI5465464') as Strings
	,DBO.fnOnlyNumb ('CAIQUE456LUIZ546987QUEIROZ789798CAMINI5465464') as Numbers
	,DBO.fnTiraAcento('Ãã âÂ á õ ç ú') as SemAcento
	,DBO.fnRemoveAcentuacao('Ãã âÂ á õ ç ú') as SemAcento2



