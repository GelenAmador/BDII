set serveroutput on;

/*
Tarea #2 PL/SQL 
Gelen Amador 20191003672
*/

-- Ejercicio #1

DECLARE
    TYPE Persona IS RECORD
    (
        nombre Varchar2(100) := 'Manuel',
        apellido1 Varchar2(100):= 'Lopez',
        apellido2 Varchar2(100):= 'Castro'
    );
    
    descrip Persona;
    
BEGIN
    dbms_output.put_line(descrip.nombre);
    dbms_output.put_line(descrip.apellido1);
    dbms_output.put_line(descrip.apellido2);
    dbms_output.put_line('Lo que solicita el ejericio1 es lo siguiente:');
    DBMS_OUTPUT.put_line( RPAD(descrip.nombre,1) || '.' || RPAD(descrip.apellido1,1) || '.' || RPAD(descrip.apellido2,1));
END;

-- Ejercicio #2

DECLARE
    numero number(4):=10;
BEGIN
    dbms_output.put_line(MOD (numero, 4));
    
    IF (MOD (numero, 2)) = 0  THEN
        dbms_output.put_line('El numero ingresado es par');
    ELSE
        dbms_output.put_line('El numero ingresado es impar');
    END IF;
END;

-- Ejercicio #3

DECLARE
    salario_maximo number; 
BEGIN
    select MAX(Salary) into salario_maximo FROM EMPLOYEES WHERE DEPARTMENT_ID=100;
    dbms_output.put_line('El salario maximo es de: ' || salario_maximo);
END;


-- Ejercicio #4

DECLARE
    ID_DEP DEPARTMENTS.DEPARTMENT_ID%TYPE := 10;
    nombre Varchar2(50); 
    cant_emple Number;
BEGIN
    select department_name into nombre FROM DEPARTMENTS WHERE DEPARTMENTS.department_id = ID_DEP;
    dbms_output.put_line('Nombre del departamento: ' ||nombre);
    
    SELECT COUNT(EMPLOYEE_ID) into cant_emple FROM EMPLOYEES WHERE EMPLOYEES.DEPARTMENT_ID=ID_DEP;
    dbms_output.put_line('Cantidad de empleados: ' ||cant_emple);
END;


-- Ejercicio #5

DECLARE
    salario_maximo Number;
    salario_minimo Number;
    dif Number;
BEGIN
    select MAX(Salary) into salario_maximo FROM EMPLOYEES WHERE DEPARTMENT_ID=100;
    dbms_output.put_line('El salario maximo es de: ' || salario_maximo);
    
    select MIN(Salary) into salario_minimo FROM EMPLOYEES WHERE DEPARTMENT_ID=100;
    dbms_output.put_line('El salario salario_minimo es de: ' || salario_minimo);
    
    dif:=salario_maximo-salario_minimo;
    dbms_output.put_line('Diferencia de salarios: ' || dif );
END;










