create or replace function wksp_ebs2cloud_migration.xxcicd_get_employee_count return number is
    v_count number;
begin
    select
        count(*)
    into v_count
    from
        xxcicd_emp;

    return v_count;
exception
    when others then
        return 0;
end;
/


-- sqlcl_snapshot {"hash":"2dcaa4f9bd407cfafca44fbad8d890b6b5b9cfe7","type":"FUNCTION","name":"XXCICD_GET_EMPLOYEE_COUNT","schemaName":"WKSP_EBS2CLOUD_MIGRATION","sxml":""}