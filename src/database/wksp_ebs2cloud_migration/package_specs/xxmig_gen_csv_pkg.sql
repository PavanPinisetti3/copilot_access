create or replace package wksp_ebs2cloud_migration.xxmig_gen_csv_pkg as
    procedure xx_create_supplier (
        p_temp_name in varchar2
    );

end xxmig_gen_csv_pkg;
/


-- sqlcl_snapshot {"hash":"087c4d37205542656cbee03d6f65970cd3dcccab","type":"PACKAGE_SPEC","name":"XXMIG_GEN_CSV_PKG","schemaName":"WKSP_EBS2CLOUD_MIGRATION","sxml":""}