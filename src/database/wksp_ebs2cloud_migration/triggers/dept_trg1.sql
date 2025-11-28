create or replace editionable trigger wksp_ebs2cloud_migration.dept_trg1 before
    insert on wksp_ebs2cloud_migration.dept
    for each row
begin
    if :new.deptno is null then
        select
            dept_seq.nextval
        into :new.deptno
        from
            sys.dual;

    end if;
end;
/

alter trigger wksp_ebs2cloud_migration.dept_trg1 enable;


-- sqlcl_snapshot {"hash":"21c5a45337530a6195d17b5addb0f87525249fdd","type":"TRIGGER","name":"DEPT_TRG1","schemaName":"WKSP_EBS2CLOUD_MIGRATION","sxml":""}