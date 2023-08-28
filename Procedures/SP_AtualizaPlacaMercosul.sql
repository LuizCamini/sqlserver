CREATE PROCEDURE AtualizaPlacaMercosul (@Placa AS VARCHAR(8))
AS
BEGIN
        SET nocount ON;
    DECLARE 
        @placamercosul VARCHAR(8)
        ,@placa2 VARCHAR(8)

    SET @placa2 = (    
    SELECT  
        CASE 
            when SUBSTRING(PlacaVeiculo,6,1) = 0 THEN UPPER(SUBSTRING(PlacaVeiculo,1,5)) + 'A'  + SUBSTRING(PlacaVeiculo,7,2) 
            when SUBSTRING(PlacaVeiculo,6,1) = 1 THEN UPPER(SUBSTRING(PlacaVeiculo,1,5)) + 'B'  + SUBSTRING(PlacaVeiculo,7,2) 
            when SUBSTRING(PlacaVeiculo,6,1) = 2 THEN UPPER(SUBSTRING(PlacaVeiculo,1,5)) + 'C'  + SUBSTRING(PlacaVeiculo,7,2) 
            when SUBSTRING(PlacaVeiculo,6,1) = 3 THEN UPPER(SUBSTRING(PlacaVeiculo,1,5)) + 'D'  + SUBSTRING(PlacaVeiculo,7,2) 
            when SUBSTRING(PlacaVeiculo,6,1) = 4 THEN UPPER(SUBSTRING(PlacaVeiculo,1,5)) + 'E'  + SUBSTRING(PlacaVeiculo,7,2) 
            when SUBSTRING(PlacaVeiculo,6,1) = 5 THEN UPPER(SUBSTRING(PlacaVeiculo,1,5)) + 'F'  + SUBSTRING(PlacaVeiculo,7,2) 
            when SUBSTRING(PlacaVeiculo,6,1) = 6 THEN UPPER(SUBSTRING(PlacaVeiculo,1,5)) + 'G'  + SUBSTRING(PlacaVeiculo,7,2) 
            when SUBSTRING(PlacaVeiculo,6,1) = 7 THEN UPPER(SUBSTRING(PlacaVeiculo,1,5)) + 'H'  + SUBSTRING(PlacaVeiculo,7,2) 
            when SUBSTRING(PlacaVeiculo,6,1) = 8 THEN UPPER(SUBSTRING(PlacaVeiculo,1,5)) + 'I'  + SUBSTRING(PlacaVeiculo,7,2) 
            when SUBSTRING(PlacaVeiculo,6,1) = 9 THEN UPPER(SUBSTRING(PlacaVeiculo,1,5)) + 'J'  + SUBSTRING(PlacaVeiculo,7,2) 
        END AS PLACA_MERCOSUL
    FROM Veiculos WHERE PlacaVeiculo = @Placa
                  )

    SET @placamercosul = @Placa2

    UPDATE Veiculos SET PlacaVeiculoMercosul = @placamercosul WHERE PlacaVeiculo = @Placa

END

GO


