create or replace type wksp_ebs2cloud_migration.xxcicd_address_type as object (
        street   varchar2(100),
        city     varchar2(50),
        state    varchar2(50),
        zip_code varchar2(10),
        country  varchar2(50)
)
/


-- sqlcl_snapshot {"hash":"981cbf488303c2358e38b76e141756464467d7e2","type":"TYPE_SPEC","name":"XXCICD_ADDRESS_TYPE","schemaName":"WKSP_EBS2CLOUD_MIGRATION","sxml":""}