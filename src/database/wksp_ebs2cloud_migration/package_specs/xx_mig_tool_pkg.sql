create or replace package wksp_ebs2cloud_migration.xx_mig_tool_pkg as
    x_state varchar2(30);
    procedure xx_post_url;

    procedure xx_url_state;

end xx_mig_tool_pkg;
/


-- sqlcl_snapshot {"hash":"9bff87834d7f497d12d791a5e1a13a0890a1590c","type":"PACKAGE_SPEC","name":"XX_MIG_TOOL_PKG","schemaName":"WKSP_EBS2CLOUD_MIGRATION","sxml":""}