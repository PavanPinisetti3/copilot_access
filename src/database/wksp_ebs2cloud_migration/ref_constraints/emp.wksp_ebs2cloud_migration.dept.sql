alter table wksp_ebs2cloud_migration.emp
    add
        foreign key ( deptno )
            references wksp_ebs2cloud_migration.dept ( deptno )
        enable;


-- sqlcl_snapshot {"hash":"c7ff040b2043c7cd94804fde58ba4dc9630bc40f","type":"REF_CONSTRAINT","name":"EMP.WKSP_EBS2CLOUD_MIGRATION.DEPT","schemaName":"WKSP_EBS2CLOUD_MIGRATION","sxml":""}