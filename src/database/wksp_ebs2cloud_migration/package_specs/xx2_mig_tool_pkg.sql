create or replace package wksp_ebs2cloud_migration.xx2_mig_tool_pkg as
    x_state varchar2(30);
    procedure xx2_post_url;

    procedure xx2_url_state;

    procedure xx2_get_status;

end xx2_mig_tool_pkg;
/


-- sqlcl_snapshot {"hash":"5d9e6ea113d470d7cad0e029b96a8cb07939ed7a","type":"PACKAGE_SPEC","name":"XX2_MIG_TOOL_PKG","schemaName":"WKSP_EBS2CLOUD_MIGRATION","sxml":""}