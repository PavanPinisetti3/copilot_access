create or replace force editionable view wksp_ebs2cloud_migration.xxcicd_emp_view (
    id,
    name,
    age,
    salary
) as
    select
        id,
        name,
        age,
        salary
    from
        xxcicd_emp;


-- sqlcl_snapshot {"hash":"e1b0b69a0facb134b349d02d87f35c4103319f9a","type":"VIEW","name":"XXCICD_EMP_VIEW","schemaName":"WKSP_EBS2CLOUD_MIGRATION","sxml":""}