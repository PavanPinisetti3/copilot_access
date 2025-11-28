create or replace editionable trigger wksp_ebs2cloud_migration.xxcicd_emp_seq_trg before
    insert on wksp_ebs2cloud_migration.xxcicd_emp
    for each row
begin
    if :new.id is null then
        :new.id := xxcicd_emp_seq.nextval;
    end if;
end;
/

alter trigger wksp_ebs2cloud_migration.xxcicd_emp_seq_trg enable;


-- sqlcl_snapshot {"hash":"e35232f57250b4897957096b15d6fa0872243472","type":"TRIGGER","name":"XXCICD_EMP_SEQ_TRG","schemaName":"WKSP_EBS2CLOUD_MIGRATION","sxml":""}