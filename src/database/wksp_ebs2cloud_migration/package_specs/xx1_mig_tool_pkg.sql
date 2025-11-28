create or replace package wksp_ebs2cloud_migration.xx1_mig_tool_pkg as
    x_state varchar2(30);
    procedure xx1_post_url;

    procedure xx1_url_state;

end xx1_mig_tool_pkg;
/


-- sqlcl_snapshot {"hash":"48420de871046b3adabbb6f94dee5e837c1eb43c","type":"PACKAGE_SPEC","name":"XX1_MIG_TOOL_PKG","schemaName":"WKSP_EBS2CLOUD_MIGRATION","sxml":""}