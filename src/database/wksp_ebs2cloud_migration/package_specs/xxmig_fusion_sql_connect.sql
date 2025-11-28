create or replace package wksp_ebs2cloud_migration.xxmig_fusion_sql_connect as
    function get_bi_report_query (
        p_entity_name     in varchar2,
        p_sub_entity_name in varchar2
    ) return clob;

    function bi_sqlconnect_envelope (
        p_base64_query in clob
    ) return clob;

    procedure get_bi_sqlconnect_csv (
        p_entity_name     in varchar2,
        p_sub_entity_name in varchar2,
        p_url             in varchar2,
        p_user_name       in varchar2,
        p_password        in varchar2
    );

end;
/


-- sqlcl_snapshot {"hash":"a408e49a6ac3aedac68681419786294ee9159bf1","type":"PACKAGE_SPEC","name":"XXMIG_FUSION_SQL_CONNECT","schemaName":"WKSP_EBS2CLOUD_MIGRATION","sxml":""}