CREATE OR REPLACE PROCEDURE hr_{{env_name}}.{{raw}}.employee_create()
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS 'DECLARE
    v_table_exists integer;
    v_sql VARCHAR;
    v_result  VARCHAR DEFAULT '''';
    
BEGIN

    CREATE TABLE hr_{{env_name}}.{{raw}}.employee
      (EMPNO       CHAR(6)         NOT NULL,
       FIRSTNME    VARCHAR(12)     NOT NULL,
       MIDINIT     CHAR(1)         NOT NULL,
       LASTNAME    VARCHAR(15)     NOT NULL,
       WORKDEPT    CHAR(3)                 ,
       PHONENO     CHAR(4)                 ,
       HIREDATE    DATE                    ,
       JOB         CHAR(8)                 ,
       EDLEVEL     SMALLINT        NOT NULL,
       SEX         CHAR(1)                 ,
       BIRTHDATE   DATE                    ,
       SALARY      DECIMAL(9,2)            ,
       BONUS       DECIMAL(9,2)            ,
       COMM        DECIMAL(9,2)         
       PRIMARY KEY (EMPNO))
        
    SELECT * FROM hr_{{env_name}}.{{raw}}.employee;
--  v_result :=''Employee table staging data loaded'' || SQLROWCOUNT;
    IF (SQLFOUND = true) THEN
        RETURN ''Updated Employee staging data with '' || SQLROWCOUNT || '' rows.'';
  -- SQLNOTFOUND returns ''true'' if the last DML statement
  -- (the UPDATE statement) affected zero rows.
    ELSEIF (SQLNOTFOUND = true) THEN
        RETURN ''No rows updated.'';
    ELSE
        RETURN ''SQLFOUND and SQLNOTFOUND are not true.'';
    END IF; 

END';
