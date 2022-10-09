/*
TAREA #3
GELEN AMADOR 20191003672
*/

SET SERVEROUT ON;

--Ejercicio #1 inciso a

DECLARE
  CURSOR C1 IS SELECT * FROM employees; -- declaro el cursor
  
BEGIN
    FOR i IN C1 LOOP   -- recorro con el cursor
        -- Para que no me muestre el sueldo del jefe
        IF i.FIRST_NAME = 'Peter' AND i.LAST_NAME = 'Tucker' THEN
            RAISE_APPLICATION_ERROR(-20010, 'PETER TUCKER IS A BOOS' );
        END IF;
        DBMS_OUTPUT.PUT_LINE(i.FIRST_NAME || ' ' || i.SALARY);
    END LOOP;
END;


--Ejercicio #1 inciso b

DECLARE
  CURSOR C1(ID_DEPART NUMBER) 
  IS SELECT * FROM EMPLOYEES
  WHERE department_id = ID_DEPART; 
  contador NUMBER;
BEGIN
    FOR i IN C1(90) LOOP
        contador:= C1%ROWCOUNT;
    END LOOP;
    DBMS_OUTPUT.PUT_LINE('Numero de empleados del departamento: ' || contador);
END;

--Ejercicio #1 inciso c
-- Solo mostrando en consola
DECLARE
    CURSOR C1 IS SELECT * FROM EMPLOYEES;
    salario EMPLOYEES.SALARY%TYPE;
BEGIN
    FOR i in C1 LOOP
        IF i.salary > 8000 THEN
            salario:= (i.salary + i.salary*0.2);
            DBMS_OUTPUT.PUT_LINE(i.FIRST_NAME || ' Su nuevo salario es de: '|| salario);
        ELSE
            salario:= (i.salary + i.salary*0.3);
            DBMS_OUTPUT.PUT_LINE(i.FIRST_NAME || ' Su nuevo salario es de: ' || salario);
        END IF; 
    END LOOP;       
END;

--modificando ya la tabla
DECLARE
    CURSOR C1 IS SELECT * FROM EMPLOYEES FOR UPDATE;
BEGIN
    FOR i in C1 LOOP
        IF i.salary > 8000 THEN
            UPDATE employees SET salary = (i.salary + i.salary*0.2) WHERE CURRENT OF C1;
        ELSE
             UPDATE employees SET salary = (i.salary + i.salary*0.3) WHERE CURRENT OF C1;
        END IF; 
    END LOOP;       
END;


--Ejercicio #2 - FUNCIONES

CREATE OR REPLACE FUNCTION CREAR_REGION
    (nameRegion IN COUNTRIES.COUNTRY_NAME%TYPE) 
RETURN NUMBER 
IS
    indMax NUMBER:=0;
    codRegion NUMBER:=0;
    country CHAR;
BEGIN
SELECT MAX(Region_ID)INTO indMax FROM COUNTRIES;
codRegion:=(indMax+1);
return codRegion;
country:= UPPER(SUBSTR(nameRegion,1,2));

INSERT INTO countries VALUES(   
          country
        , nameRegion  
        , codRegion  
        );  
EXCEPTION
    WHEN NO_DATA_FOUND THEN
       DBMS_OUTPUT.PUT_line('NO EXISTE');
END;

set serveroutput on
DECLARE
  R NUMBER:=0;
begin
    R:= CREAR_REGION('HONDURAS');
 DBMS_OUTPUT.PUT_LINE('El nuevo indice es de:'||R);
end;

--Ejercicio #3 - PROCEDIMIENTOS inciso a

CREATE OR REPLACE PROCEDURE Calculadora 
(Op in VARCHAR2, num1 in NUMBER, num2 in NUMBER, res out Number)
IS   
BEGIN
        CASE Op
        WHEN 'multiplicar' THEN 
            res:=num1*num2; 
        DBMS_OUTPUT.PUT_LINE(num1 || ' * ' || num2  || ' = ' ||res);
    
        WHEN 'sumar' THEN 
              res:=num1+num2; 
        DBMS_OUTPUT.PUT_LINE(num1 || ' + ' || num2  || ' = ' ||res);
        
        WHEN 'restar' THEN 
                res:=num1-num2; 
        DBMS_OUTPUT.PUT_LINE(num1 || ' - ' || num2  || ' = ' ||res);
        
        WHEN 'dividir' THEN 
            IF num2 = 0 THEN
                RAISE_APPLICATION_ERROR(-20010, 'No se puede dividir entre cero' );
            END IF;
            res:=num1/num2; 
        DBMS_OUTPUT.PUT_LINE(num1 || ' / ' || num2  || ' = ' ||res);
        else
            DBMS_OUTPUT.PUT_LINE('Operación invalida');
        END CASE;
END;


set serveroutput on
DECLARE
    R NUMBER:=0;
begin
  Calculadora('sumar', 10,20, R);
end;

--Ejercicio #3 - PROCEDIMIENTOS inciso B

CREATE TABLE
EMPLOYEES_COPIA
 (EMPLOYEE_ID NUMBER (6,0) PRIMARY KEY,
FIRST_NAME VARCHAR2(20 BYTE),
LAST_NAME VARCHAR2(25 BYTE),
EMAIL VARCHAR2(25 BYTE),
PHONE_NUMBER VARCHAR2(20 BYTE),
HIRE_DATE DATE,
JOB_ID VARCHAR2(10 BYTE),
SALARY NUMBER(8,2),
COMMISSION_PCT NUMBER(2,2),
MANAGER_ID NUMBER(6,0),
DEPARTMENT_ID NUMBER(4,0)
 );

CREATE OR REPLACE PROCEDURE INSERTAR
IS

BEGIN

INSERT INTO EMPLOYEES_COPIA VALUES     
        ( 107    
        , 'Diana'    
        , 'Lorentz'    
        , 'DLORENTZ'    
        , '590.423.5567'    
        , TO_DATE('07-02-2007', 'dd-MM-yyyy')    
        , 'IT_PROG'    
        , 4200    
        , NULL    
        , 103    
        , 60    
        );    
INSERT INTO EMPLOYEES_COPIA VALUES     
        ( 108    
        , 'Nancy'    
        , 'Greenberg'    
        , 'NGREENBE'    
        , '515.124.4569'    
        , TO_DATE('17-08-2002', 'dd-MM-yyyy')    
        , 'FI_MGR'    
        , 12008    
        , NULL    
        , 101    
        , 100    
        );    
    
INSERT INTO EMPLOYEES_COPIA VALUES     
        ( 109    
        , 'Daniel'    
        , 'Faviet'    
        , 'DFAVIET'    
        , '515.124.4169'    
        , TO_DATE('16-08-2002', 'dd-MM-yyyy')    
        , 'FI_ACCOUNT'    
        , 9000    
        , NULL    
        , 108    
        , 100    
        );    

DBMS_OUTPUT.PUT_LINE('Carga Finalizada');      

EXCEPTION
    WHEN no_data_found THEN
        dbms_output.put_line('ERROR, EMPLEADO INEXISTENTE');
    WHEN OTHERS THEN
        dbms_output.put_line('ERROR INDEFINIDO');
END;

EXEC Insertar;

select * from EMPLOYEES_COPIA;

