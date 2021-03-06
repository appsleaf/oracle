-- export Procedures list

SET SERVEROUTPUT ON SIZE 1000000
SET ECHO OFF VERIFY OFF FEEDBACK OFF TRIMSPOOL ON PAGES 0 LINES 512
SET TERMOUT OFF

-- save procedure list path
DEFINE V_LIST_DIR=

-- save procedure path
DEFINE V_SAVE_DIR=

-- shell path
DEFINE V_SHELL_DIR=

-- print procedures title
SPOOL &V_LIST_DIR/procedureList.sql

DECLARE
    CURSOR CUR_PROCEDURE_CODE
    IS
    SELECT DISTINCT OBJECT_NAME
         , USER
         , OBJECT_TYPE
      FROM USER_PROCEDURES
     ORDER
        BY OBJECT_TYPE, OBJECT_NAME;
BEGIN

    FOR C_ROW IN CUR_PROCEDURE_CODE
    LOOP
        DBMS_OUTPUT.PUT_LINE('SPOOL &V_SAVE_DIR/'|| C_ROW.OBJECT_TYPE || '/' || USER || '.' || C_ROW.OBJECT_NAME || '.sql');
        DBMS_OUTPUT.PUT_LINE('@&V_SHELL_DIR/print_procedure ' || C_ROW.OBJECT_NAME );
        DBMS_OUTPUT.PUT_LINE('SPOOL OFF');
    END LOOP;

END;
/

SPOOL OFF

@&V_LIST_DIR/procedureList
