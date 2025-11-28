create or replace function wksp_ebs2cloud_migration.xxcicd_calculate_bonus (
    p_salary      in number,
    p_performance in number
) return number is
begin
    return p_salary * ( p_performance / 100 );
end;
/


-- sqlcl_snapshot {"hash":"38f2a12e568cfab237bc73ac1cdf205e5a1c04df","type":"FUNCTION","name":"XXCICD_CALCULATE_BONUS","schemaName":"WKSP_EBS2CLOUD_MIGRATION","sxml":""}