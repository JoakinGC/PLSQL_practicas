DECLARE
    v_nombre ciclista.nombre%TYPE;
BEGIN
    SELECT
        c.nombre
    INTO v_nombre
    FROM
        ciclista c
    WHERE
        c.nombre LIKE 'x%';

    dbms_output.put_line('Nombre del ciclista: ' || v_nombre);
EXCEPTION
    WHEN no_data_found THEN
        dbms_output.put_line('No hay resultados');
    WHEN OTHERS THEN
        dbms_output.put_line('Ocurrio el error '
                             || sqlcode
                             || ' mensaje '
                             || sqlerrm);
END;