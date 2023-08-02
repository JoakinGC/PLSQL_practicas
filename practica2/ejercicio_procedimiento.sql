delete from ciclista;

create procedure insertarCiclistas
is
begin 
    INSERT INTO ciclista VALUES (3, 'Alex Zulle', 20, 'Navigare');

INSERT INTO ciclista VALUES (4, 'Alessio Di Basco', 30, 'TVM');

INSERT INTO ciclista VALUES (5, 'Armand', 17, 'Amore Vita');

INSERT INTO ciclista VALUES (8, 'Jean Van Poppel', 24, 'Bresciali-Refin');

INSERT INTO ciclista VALUES (9, 'Maximo Podel', 17, 'Telecom');

INSERT INTO ciclista VALUES (10, 'Mario Cipollini', 31, 'Carrera');

INSERT INTO ciclista VALUES (11, 'Eddy Seigneur', 20, 'Amore Vita');

INSERT INTO ciclista VALUES (12, 'Alessio Di Basco', 34, 'Bresciali-Refin');

INSERT INTO ciclista VALUES (13, 'Gianni Bugno', 24, 'Gatorade');

INSERT INTO ciclista VALUES (15, 'Jes�s Montoya', 25, 'Amore Vita');

INSERT INTO ciclista VALUES (16, 'Dimitri Konishev', 27, 'Amore Vita');

INSERT INTO ciclista VALUES (17, 'Bruno Lealli', 30, 'Amore Vita');

INSERT INTO ciclista VALUES (20, 'Alfonso Guti�rrez', 27, 'Navigare');

INSERT INTO ciclista VALUES (22, 'Giorgio Furlan', 22, 'Kelme');

INSERT INTO ciclista VALUES (26, 'Mikel Zarrabeitia', 30, 'Carrera');

INSERT INTO ciclista VALUES (27, 'Laurent Jalabert', 22, 'Banesto');

INSERT INTO ciclista VALUES (30, 'Melchor Mauri', 26, 'Mapei-Clas');

INSERT INTO ciclista VALUES (31, 'Per Pedersen', 33, 'Banesto');

INSERT INTO ciclista VALUES (32, 'Tony Rominger', 31, 'Kelme');

INSERT INTO ciclista VALUES (33, 'Stefenao della Sveitia', 26, 'Amore Vita');

INSERT INTO ciclista VALUES (34, 'Clauido Chiapucci', 23, 'Amore Vita');

INSERT INTO ciclista VALUES (35, 'Gian Mateo Faluca', 34, 'TVM');

exception
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Ocurrio el error ' || SQLCODE  || ' mensaje ' || SQLERRM);
END;



-- 18)La aplicaci�n pedir� un c�digo de equipo y lo borrar�. Antes deber� borrar todos los ciclistas que haya en ese equipo 
-- (y todas las tablas donde haya claves ajenas).Nombre funci�n "Ciclista.BorrarEquipo".

CREATE OR REPLACE PROCEDURE eliminarEquipo (nomEquipo IN VARCHAR2) IS
BEGIN
    DELETE FROM ciclista WHERE nomeq = nomEquipo;
    DELETE FROM equipo WHERE nomeq = nomEquipo;
    DBMS_OUTPUT.PUT_LINE('Equipo eliminado correctamente.');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Ocurri� un error: ' || SQLCODE || ' - ' || SQLERRM);
END;
/

DECLARE
    nomEquipo VARCHAR2(100) := '&nomEquipo';
BEGIN
    DBMS_OUTPUT.PUT_LINE(nomEquipo);
    eliminarEquipo(nomEquipo);
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Ocurri� un error: ' || SQLCODE || ' - ' || SQLERRM);
END;
/


