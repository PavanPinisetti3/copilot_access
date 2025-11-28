create or replace procedure wksp_ebs2cloud_migration.xxcicd_cal_bonus (
    p_employee_id  in number,
    p_bonus_pct    in number,
    p_bonus_amount out number
) as
    v_salary number;
begin
    select
        salary
    into v_salary
    from
        xxcicd_emp
    where
        id = p_employee_id;

    p_bonus_amount := v_salary * ( p_bonus_pct / 100 );
    dbms_output.put_line('Bonus calculated: ' || p_bonus_amount);
end xxcicd_cal_bonus;
/


-- sqlcl_snapshot {"hash":"5c74c61c3c988f0cfe3da0ac6be898c4f2a128d5","type":"PROCEDURE","name":"XXCICD_CAL_BONUS","schemaName":"WKSP_EBS2CLOUD_MIGRATION","sxml":""}