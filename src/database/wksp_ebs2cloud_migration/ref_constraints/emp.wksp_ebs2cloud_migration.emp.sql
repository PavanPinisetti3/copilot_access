alter table wksp_ebs2cloud_migration.emp
    add
        foreign key ( mgr )
            references wksp_ebs2cloud_migration.emp ( empno )
        enable;


-- sqlcl_snapshot {"hash":"4dce981492ed902edb8a0749d36c961291657ca3","type":"REF_CONSTRAINT","name":"EMP.WKSP_EBS2CLOUD_MIGRATION.EMP","schemaName":"WKSP_EBS2CLOUD_MIGRATION","sxml":""}