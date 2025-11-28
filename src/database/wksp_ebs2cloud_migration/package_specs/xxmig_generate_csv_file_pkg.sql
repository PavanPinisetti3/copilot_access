create or replace package wksp_ebs2cloud_migration.xxmig_generate_csv_file_pkg as

--+==============================================================================+
--|                        Winfo Consulting, UK.                                 |
--+==============================================================================+
--|Description      :This package uses the rest api's and payload to create      |
--|                  the AP,AR,SLA,GL,CMFS modules data for the which is present |
--|                  in the EBS                                                  |
--|                                                                              |
--+==============================================================================+

    g_new constant varchar2(1) := 'N';
    g_doc_content_type constant varchar2(10) := 'zip';
    g_error_status constant varchar2(1) := 'E';
    g_success_status constant varchar2(1) := 'S';
    g_operation_name varchar2(30) := 'importBulkData';
    procedure xxmig_supplier_template (
        p_temp_name     in varchar2,
        x_error_status  out varchar2,
        x_error_message out varchar2
    );

    procedure xxmig_ap_invoice (
        p_temp_name in varchar2
    );

end xxmig_generate_csv_file_pkg;
/


-- sqlcl_snapshot {"hash":"6277fad0aefb0a0647e11ee9a4024968a5d1a552","type":"PACKAGE_SPEC","name":"XXMIG_GENERATE_CSV_FILE_PKG","schemaName":"WKSP_EBS2CLOUD_MIGRATION","sxml":""}