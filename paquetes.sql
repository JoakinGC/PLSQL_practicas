 /*DROP TABLE ALUMNOS cascade constraints;



 



CREATE TABLE ALUMNOS



(



  DNI VARCHAR2(10) NOT NULL,



  APENOM VARCHAR2(30),



  DIREC VARCHAR2(30),



  POBLA  VARCHAR2(15),



  TELEF  VARCHAR2(10) 



);



 



DROP TABLE ASIGNATURAS cascade constraints;



 



CREATE TABLE ASIGNATURAS



(



  COD NUMBER(2) NOT NULL,



  NOMBRE VARCHAR2(25)



) ;



 



DROP TABLE NOTAS cascade constraints;



 



CREATE TABLE NOTAS



(



  DNI VARCHAR2(10) NOT NULL,



  COD NUMBER(2) NOT NULL,



  NOTA NUMBER(2)



) ;



 



INSERT INTO ASIGNATURAS VALUES (1,'Prog. Leng. Estr.');



INSERT INTO ASIGNATURAS VALUES (2,'Sist. Informáticos');



INSERT INTO ASIGNATURAS VALUES (3,'Análisis');



INSERT INTO ASIGNATURAS VALUES (4,'FOL');



INSERT INTO ASIGNATURAS VALUES (5,'RET');



INSERT INTO ASIGNATURAS VALUES (6,'Entornos Gráficos');



INSERT INTO ASIGNATURAS VALUES (7,'Aplic. Entornos 4ªGen');



 



INSERT INTO ALUMNOS VALUES



('12344345','Alcalde García, Elena', 'C/Las Matas, 24','Madrid','917766545');



 



INSERT INTO ALUMNOS VALUES



('4448242','Cerrato Vela, Luis', 'C/Mina 28 - 3A', 'Madrid','916566545');



 



INSERT INTO ALUMNOS VALUES



('56882942','Díaz Fernández, María', 'C/Luis Vives 25', 'Móstoles','915577545');



 



INSERT INTO NOTAS VALUES('12344345', 1,6);



INSERT INTO NOTAS VALUES('12344345', 2,5);



INSERT INTO NOTAS VALUES('12344345', 3,6);



 



INSERT INTO NOTAS VALUES('4448242', 4,6);



INSERT INTO NOTAS VALUES('4448242', 5,8);



INSERT INTO NOTAS VALUES('4448242', 6,4);



INSERT INTO NOTAS VALUES('4448242', 7,5);



 



INSERT INTO NOTAS VALUES('56882942', 4,8);



INSERT INTO NOTAS VALUES('56882942', 5,7);



INSERT INTO NOTAS VALUES('56882942', 6,8);



INSERT INTO NOTAS VALUES('56882942', 7,9);

COMMIT;
*/


-- Crea un paquete llamada CURSO  que contenga las siguientes funciones/procedimientos

 -- Diseña un procedimiento al que pasemos como parámetro de entrada el nombre de uno de los módulos existentes en la BD y visualice el nombre de los alumnos que lo han cursado junto a su nota.

 -- Diseña un procedimiento al que pasemos como parámetro de entrada el nombre de uno de los módulos existentes en la BD y visualice el nº de suspensos, aprobados, notables y sobresalientes.

 -- Diseña un procedimiento al que pasemos como parámetro de entrada el nombre de uno de los módulos existentes en la BD y visualice los nombres y notas de los alumnos que tengan la nota más alta y la más baja.

 -- Diseña un procedimiento al que pasemos como parámetro de entrada el nombre de uno de los módulos existentes en la BD y el informe completo, es decir, llamará a los procedimientos anteriormente creados. Debes comprobar previamente que las tablas tengan almacenada información y que exista el módulo cuyo nombre pasamos como parámetro al procedimiento.
 
 
 CREATE OR REPLACE PACKAGE COLEGIO
AS
    PROCEDURE visualizarAlu (NOM_ASIG IN ASIGNATURAS.NOMBRE%TYPE);
    PROCEDURE visualizarNotas (NOM_ASIG IN ASIGNATURAS.NOMBRE%TYPE);
    PROCEDURE visualizarAltaBaja (NOM_ASIG IN ASIGNATURAS.NOMBRE%TYPE);
    PROCEDURE visualizarTodas (NOM_ASIG IN ASIGNATURAS.NOMBRE%TYPE);

    
END COLEGIO;

CREATE OR REPLACE PACKAGE BODY COLEGIO
AS
    
 PROCEDURE visualizarAlu (NOM_ASIG IN ASIGNATURAS.NOMBRE%TYPE )
 AS 
 BEGIN 
      FOR CUR IN (SELECT N.NOTA , ALU.APENOM 
                    FROM ASIGNATURAS ASIG, NOTAS N, ALUMNOS ALU  
                    WHERE NOM_ASIG = ASIG.NOMBRE 
                    AND N.COD = ASIG.COD 
                    AND N.DNI = ALU.DNI)
      
      LOOP 
         dbms_output.put_line(CUR.APENOM || ': ' || CUR.NOTA);
      END LOOP;
 END;
 
 
 
PROCEDURE visualizarNotas (NOM_ASIG IN ASIGNATURAS.NOMBRE%TYPE )
 AS 
 SUSPENSOS NUMBER := 0;
 APROBADOS NUMBER := 0;
 SOBRE NUMBER := 0;
 NOTABLE NUMBER := 0;
 
 BEGIN 
      FOR CUR IN (SELECT N.NOTA FROM ASIGNATURAS ASIG, NOTAS N WHERE NOM_ASIG = ASIG.NOMBRE AND N.COD = ASIG.COD)
     
      LOOP 
            IF CUR.NOTA > 9 THEN 
                SOBRE := SOBRE  + 1;
            END IF; 
            
            IF CUR.NOTA > 7 AND CUR.NOTA <= 8 THEN 
                NOTABLE := NOTABLE  + 1;
            END IF; 
            
            IF CUR.NOTA > 5 AND CUR.NOTA <= 7 THEN 
                APROBADOS := APROBADOS  + 1;
            END IF; 
            
            IF CUR.NOTA < 5  THEN 
                SUSPENSOS := SUSPENSOS + 1;
            END IF; 
      
      END LOOP;
      
      dbms_output.put_line('SOBRESALIENTES: ' || SOBRE );
      dbms_output.put_line('NOTABLES: ' || NOTABLE );
      dbms_output.put_line('APROBADOS: ' || APROBADOS );
      dbms_output.put_line('SUSPENSOS: ' || SUSPENSOS );
 END;
 
 
 
PROCEDURE visualizarAltaBaja (NOM_ASIG IN ASIGNATURAS.NOMBRE%TYPE )
 
 AS 
 NOMBRE_ALU ALUMNOS.APENOM%TYPE;
 NOTA NOTAS.NOTA%TYPE;
 N_MAX NOTAS.NOTA%TYPE;
 N_MIN NOTAS.NOTA%TYPE;
 
 BEGIN 
 
    SELECT MAX(NOTA)
    INTO  N_MAX
    FROM ASIGNATURAS ASIG, NOTAS N
    WHERE NOM_ASIG = ASIG.NOMBRE AND N.COD = ASIG.COD;
    
    SELECT MIN(NOTA)
    INTO  N_MIN
    FROM ASIGNATURAS ASIG, NOTAS N
    WHERE NOM_ASIG = ASIG.NOMBRE AND N.COD = ASIG.COD;
 
    FOR CUR IN (
        SELECT ALU.APENOM, N.NOTA
        FROM ASIGNATURAS ASIG, NOTAS N, ALUMNOS ALU 
        WHERE NOM_ASIG = ASIG.NOMBRE AND N.COD = ASIG.COD AND N.DNI = ALU.DNI AND N_MIN = N.NOTA)
    
    LOOP
        dbms_output.put_line('Nota mínima' || ': ' || CUR.NOTA || ' (' || CUR.APENOM || ')');
    
    END LOOP;
    
    
     
    
    FOR CUR IN(
        SELECT ALU.APENOM, N.NOTA
        FROM ASIGNATURAS ASIG, NOTAS N, ALUMNOS ALU 
        WHERE NOM_ASIG = ASIG.NOMBRE AND N.COD = ASIG.COD AND N.DNI = ALU.DNI AND N_MAX = N.NOTA)
    
    LOOP
        dbms_output.put_line('Nota máxima' || ': ' || NOTA || ' (' || NOMBRE_ALU || ')');
    
    END LOOP;
    
 END;
 
 
PROCEDURE visualizarTodas (NOM_ASIG IN ASIGNATURAS.NOMBRE%TYPE )
 
 AS 
CONTADOR NUMBER;
DUMMY VARCHAR2(100);
 
 BEGIN 
 

    --Verificamos si hay alumnos
    BEGIN 
        SELECT APENOM
        INTO DUMMY
        FROM ALUMNOS;
        
        EXCEPTION
        WHEN NO_DATA_FOUND THEN
            dbms_output.put_line('ERROR: NO HAY ALUMNOS');
            RETURN;
        WHEN TOO_MANY_ROWS THEN 
            NULL;
        WHEN OTHERS THEN 
            dbms_output.put_line('ERROR');
            RETURN;
    END;
    
    --Verificamos si hay asignaturas
       BEGIN 
        SELECT NOMBRE
        INTO DUMMY
        FROM ASIGNATURAS;
        
        EXCEPTION
        WHEN NO_DATA_FOUND THEN
            dbms_output.put_line('ERROR: NO HAY ASIGNATURAS');
           RETURN;
        WHEN TOO_MANY_ROWS THEN 
            NULL;
        WHEN OTHERS THEN 
            dbms_output.put_line('ERROR');
            RETURN;
    END;
    
   
    
      SELECT COUNT(1)
      INTO CONTADOR
      FROM ASIGNATURAS
      WHERE NOM_ASIG = NOMBRE;
      
      IF CONTADOR > 0 THEN 
        visualizarAlu(NOM_ASIG);
        visualizarNotas(NOM_ASIG);
        visualizarAltaBaja(NOM_ASIG);
       ELSE 
        dbms_output.put_line('ERROR: NO EXISTE ESA ASIGNATURA');
       END IF;
 END;
END COLEGIO;


DECLARE
   
BEGIN
   COLEGIO.visualizarTodas('FOL');
END;
