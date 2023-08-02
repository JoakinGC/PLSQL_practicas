DECLARE
    V_NOMBRE ciclista.nombre%TYPE;                     
BEGIN
    SELECT c.NOMBRE into v_nombre from ciclista c where c.nombre LIKE 'x%';
    
    DBMS_OUTPUT.PUT_LINE('Nombre del ciclista: ' || V_NOMBRE);
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('No hay resultados');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Ocurrio el error ' || SQLCODE  || ' mensaje ' || SQLERRM);
END;

-- 17

DECLARE
  v_dorsal NUMBER;
  v_nombre VARCHAR2(50);
  v_edad NUMBER;
  v_nomeq VARCHAR(20);
  v_num_equipos NUMBER;
BEGIN
  v_dorsal := &dorsal;
  v_nombre := '&nombre';
  v_edad := &edad;
  v_nomeq := '&nomeq';

  BEGIN
    SELECT COUNT(*) INTO v_num_equipos
        FROM equipo
            WHERE nomeq = v_nomeq;
    IF v_num_equipos = 0 THEN
      DBMS_OUTPUT.PUT_LINE('El equipo ingresado no existe.');
      RETURN;
    ELSIF v_num_equipos > 1 THEN
      RAISE_APPLICATION_ERROR(-20001, 'Hay varios equipos con el mismo nombre.');
      RETURN;
    END IF;
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      DBMS_OUTPUT.PUT_LINE('El equipo ingresado no existe.');
      RETURN;
  END;
  
  INSERT INTO ciclista (dorsal, nombre, edad, nomeq)
  VALUES (v_dorsal, v_nombre, v_edad, v_nomeq);
  
  DBMS_OUTPUT.PUT_LINE('Ciclista insertado correctamente.');
END;

create procedure 