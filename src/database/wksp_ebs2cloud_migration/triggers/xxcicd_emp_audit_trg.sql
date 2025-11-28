create or replace editionable trigger wksp_ebs2cloud_migration.xxcicd_emp_audit_trg before
    insert or update or delete on wksp_ebs2cloud_migration.xxcicd_emp
    for each row
begin
    if inserting then
        dbms_output.put_line('New employee inserted: ' || :new.id);
    elsif updating then
        dbms_output.put_line('Employee updated: ' || :new.id);
    elsif deleting then
        dbms_output.put_line('Employee deleted: ' || :old.id);
    end if;
end;
/

alter trigger wksp_ebs2cloud_migration.xxcicd_emp_audit_trg enable;


-- sqlcl_snapshot {"hash":"834c968a850cc47796eb25cded66466875bb2d10","type":"TRIGGER","name":"XXCICD_EMP_AUDIT_TRG","schemaName":"WKSP_EBS2CLOUD_MIGRATION","sxml":""}