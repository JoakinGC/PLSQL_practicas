/* -- 18) La aplicación pedirá un código de equipo y lo borrará. Antes deberá borrar
todos los ciclistas que haya en ese equipo (y todas las referencias "encadenadas" desde otras tablas). Nombre función "BorrarEquipo",
debe devolver un valor boolean a true si se borra el equipo y false en caso contrario.*/

/*CREATE OR REPLACE FUNCTION borrarEquipo
    (nomEq VARCHAR2) 
    RETURN boolean
IS
cursor saa is
        select nomeq from ciclista where nomeq = nomEq;
        
    comprobacion boolean := true;
BEGIN
      -- Eliminar los registros de la tabla LLEVAR que hacen referencia a los ciclistas del equipo
  DELETE FROM llevar WHERE dorsal IN (SELECT dorsal FROM ciclista WHERE nomeq = nomEq);

  -- Eliminar los registros de la tabla PUERTO que hacen referencia a los ciclistas del equipo
  DELETE FROM puerto WHERE dorsal IN (SELECT dorsal FROM ciclista WHERE nomeq = nomEq);

  -- Eliminar los registros de la tabla ETAPA que hacen referencia a los ciclistas del equipo
  DELETE FROM etapa WHERE dorsal IN (SELECT dorsal FROM ciclista WHERE nomeq = nomEq);

  -- Eliminar los ciclistas del equipo
  DELETE FROM ciclista WHERE nomeq = nomEq;

  -- Eliminar el equipo
  DELETE FROM equipo WHERE nomeq = nomEq;
    for ciclista in saa loop
        if ciclista.nomeq = nomEq then
            comprobacion := false;
        end if;
    end loop;
    return comprobacion;
END borrarEquipo;
/


select * from equipo;

DECLARE
    nomEquipo VARCHAR2(100) := '&nomEquipo';
    comprobar BOOLEAN := true;
BEGIN
    comprobar := borrarEquipo(nomEquipo);
    IF comprobar THEN
        DBMS_OUTPUT.PUT_LINE('Funcionó');
    ELSE 
        DBMS_OUTPUT.PUT_LINE('NO Funcionó');
    END IF;
END;
/

Comprobar las contrants que depende para borrar un valor o dato
SELECT constraint_name, table_name
FROM user_constraints
WHERE r_constraint_name IN (
    SELECT constraint_name
    FROM user_constraints
    WHERE table_name = 'CICLISTA'
);*/






      

  
   
   
/* -- 19) Crea 2 variables, una para introducir el nombre y otra con su nombre nuevo. Se buscará el ciclista con el 
    nombre antiguo y se le actualizará con el nuevo. En caso que la aplicación detecte que no hay ningún ciclista con 
    ese nombre o hay varios, dará error. Nombre funcion "ActualizarNombreCiclista", debe devolver un valor boolean a true si se 
    actualiza el nombre del ciclista y false en caso contrario.*/


/*create or replace function CambiarNombreCiclista
(nomCiclista Varchar2,nomNuevo varchar2)
return boolean
is
 comprobacion boolean := false;
 cursor ciclistas is 
    select nombre,dorsal from ciclista;
begin
    for ciclista in ciclistas loop
    
    if ciclista.nombre = nomCiclista then
        update ciclista set nombre = nomNuevo where nombre = nomCiclista;
        DBMS_OUTPUT.PUT_LINE('ACTULIZADO');
        comprobacion := true;
     end if;   
    end loop;
    return comprobacion;
end CambiarNombreCiclista;*/
CREATE OR REPLACE FUNCTION CambiarNombreCiclista
(nomCiclista IN VARCHAR2, nomNuevo IN VARCHAR2)
RETURN BOOLEAN
ISs
  comprobacion BOOLEAN := FALSE;
  CURSOR ciclistas IS
    SELECT nombre, dorsal
    FROM ciclista;
BEGIN
  FOR ciclista IN ciclistas
  LOOP
    IF ciclista.nombre = nomCiclista THEN
      UPDATE ciclista SET nombre = nomNuevo WHERE dorsal = ciclista.dorsal AND nombre = nomCiclista;
      DBMS_OUTPUT.PUT_LINE('ACTUALIZADO');
      comprobacion := TRUE;
    END IF;
  END LOOP;

  RETURN comprobacion;
END;
/




-- Bruno Lealli
SET SERVEROUTPUT ON;
DECLARE
  nomViejo VARCHAR2(100) := '&nomViejo';
  nomNuevo VARCHAR2(100) := '&nomNuevo';
  comprobar BOOLEAN := TRUE;
BEGIN
  comprobar := CambiarNombreCiclista(nomViejo, nomNuevo);
  IF comprobar THEN
    DBMS_OUTPUT.PUT_LINE('Funcionó');
  ELSE 
    DBMS_OUTPUT.PUT_LINE('NO Funcionó');
  END IF;
END;



/
select * from ciclista;
