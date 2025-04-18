set serveroutput on
set VERIFY off

CREATE TABLE FUNCIONARIO (
    CD_FUNC NUMBER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    NM_FUNC VARCHAR2(100),
    SALARIO NUMBER(10),
    DT_ADM DATE
);

INSERT INTO FUNCIONARIO (NM_FUNC, SALARIO, DT_ADM) VALUES ('Marcel', 10000, '17-april-2000');
INSERT INTO FUNCIONARIO (NM_FUNC, SALARIO, DT_ADM) VALUES ('Claudia', 16000, '02-october-1998');
INSERT INTO FUNCIONARIO (NM_FUNC, SALARIO, DT_ADM) VALUES ('Joaquim', 5500, '17-july-2010');
INSERT INTO FUNCIONARIO (NM_FUNC, SALARIO, DT_ADM) VALUES ('Val�ria', 7300, '17-june-2015');

SELECT * FROM FUNCIONARIO;

-- Utilizando cursor com o la�o loop para realizar um SELECT
DECLARE
    CURSOR C_EXIBE IS SELECT NM_FUNC, SALARIO FROM FUNCIONARIO;
    V_EXIBE C_EXIBE%ROWTYPE;

BEGIN
    OPEN C_EXIBE;
    LOOP
        FETCH C_EXIBE INTO V_EXIBE;
    EXIT WHEN C_EXIBE%NOTFOUND;
    DBMS_OUTPUT.PUT_LINE('Nome: '||V_EXIBE.NM_FUNC||' - Sal�rio: '||V_EXIBE.SALARIO);
    END LOOP;
    CLOSE C_EXIBE;
END;

-- Utilizando cursor com o la�o for para realizar um SELECT
DECLARE
    CURSOR C_EXIBE IS SELECT NM_FUNC, SALARIO FROM FUNCIONARIO;
    
BEGIN
    FOR V_EXIBE IN C_EXIBE LOOP
        DBMS_OUTPUT.PUT_LINE('Nome: '||V_EXIBE.NM_FUNC||' - Sal�rio: '||V_EXIBE.SALARIO);
    END LOOP;
END;

-- Atividade
ALTER TABLE FUNCIONARIO ADD TEMPO NUMBER(5);

DECLARE 
    CURSOR C_ATUALIZA IS SELECT * FROM FUNCIONARIO;
    
BEGIN
    FOR V_ATUALIZA IN C_ATUALIZA LOOP
        UPDATE FUNCIONARIO 
        SET TEMPO = sysdate - V_ATUALIZA.DT_ADM
        WHERE CD_FUNC = V_ATUALIZA.CD_FUNC;
    END LOOP;
END;

SELECT * FROM FUNCIONARIO;

-- Atividade 02
DECLARE 
    CURSOR C_ATUALIZA IS SELECT * FROM FUNCIONARIO;
    V_MESES NUMBER(10) := 0;
    
BEGIN
    FOR V_ATUALIZA IN C_ATUALIZA LOOP
        V_MESES := V_ATUALIZA.TEMPO / 30;
        
        IF V_MESES >= 150 THEN
            UPDATE FUNCIONARIO 
            SET SALARIO = SALARIO * 1.1
            WHERE CD_FUNC = V_ATUALIZA.CD_FUNC;
        ELSE
            UPDATE FUNCIONARIO 
            SET SALARIO = SALARIO * 1.05
            WHERE CD_FUNC = V_ATUALIZA.CD_FUNC;
        END IF;
    END LOOP;
END;

SELECT * FROM FUNCIONARIO;