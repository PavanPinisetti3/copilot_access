create or replace editionable trigger wksp_ebs2cloud_migration.emp_trg1 before
    insert on wksp_ebs2cloud_migration.emp
    for each row
begin
    if :new.empno is null then
        select
            emp_seq.nextval
        into :new.empno
        from
            sys.dual;

    end if;
end;
/

alter trigger wksp_ebs2cloud_migration.emp_trg1 enable;


-- sqlcl_snapshot {"hash":"985119a22e9173ab911a37948dde7bcbfc98699e","type":"TRIGGER","name":"EMP_TRG1","schemaName":"WKSP_EBS2CLOUD_MIGRATION","sxml":""}