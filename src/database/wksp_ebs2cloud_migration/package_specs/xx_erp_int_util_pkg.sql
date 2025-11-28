create or replace package wksp_ebs2cloud_migration.xx_erp_int_util_pkg as
    function generate_alias_name (
        p_table_name in varchar2
    ) return varchar;

    function generate_csv_file return clob;

    function zip_csv_file (
        p_clob in clob
    ) return blob;

    function blob_to_base64 (
        p_blob in blob
    ) return clob;

    function clob_to_base64 (
        p_clob in clob
    ) return clob;

    function decode_base64_blob (
        p_clob clob
    ) return blob;

    procedure migrate_to_cloud (
        p_url              in varchar2,
        p_operation_name   in varchar2,
        p_doc_content      in clob  --Encoded Base 64 goes here
        ,
        p_doc_content_type in varchar2,
        p_file_name        in varchar2,
        p_document_account in varchar2,
        p_job_name         in varchar2,
        p_param_list       in varchar2,
        p_callback_url     in varchar2,
        p_notify_code      in varchar2,
        p_job_options      in varchar2
    );

end xx_erp_int_util_pkg;
/


-- sqlcl_snapshot {"hash":"62f326fd5e27e8081dcdcd98a74bddd6eac7059c","type":"PACKAGE_SPEC","name":"XX_ERP_INT_UTIL_PKG","schemaName":"WKSP_EBS2CLOUD_MIGRATION","sxml":""}