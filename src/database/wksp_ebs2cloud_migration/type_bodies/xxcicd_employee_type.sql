create or replace type body wksp_ebs2cloud_migration.xxcicd_employee_type as
    member function get_annual_salary return number is
    begin
        return salary * 12;
    end;

end;
/


-- sqlcl_snapshot {"hash":"84aa346a389c65d61225ad47bed346c9d9896e3c","type":"TYPE_BODY","name":"XXCICD_EMPLOYEE_TYPE","schemaName":"WKSP_EBS2CLOUD_MIGRATION","sxml":""}