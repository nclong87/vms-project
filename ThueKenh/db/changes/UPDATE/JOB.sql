BEGIN
    SYS.DBMS_SCHEDULER.CREATE_JOB (
            job_name => '"THUEKENH"."VMS6 ThueKenh"',
            job_type => 'PLSQL_BLOCK',
            job_action => 'BEGIN PROC_SCHEDULE; END;',
            number_of_arguments => 0,
            start_date => TO_TIMESTAMP('03-MAR-13 07.30.00.685000 AM', 'DD-MON-RR HH.MI.SS.FF AM'),
            repeat_interval => 'FREQ=DAILY',
            end_date => NULL,
            job_class => 'DEFAULT_JOB_CLASS',
            enabled => true,
            auto_drop => false,
            comments => NULL,
            credential_name => NULL,
            destination_name => NULL);
END;