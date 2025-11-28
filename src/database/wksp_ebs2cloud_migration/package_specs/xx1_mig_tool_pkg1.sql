create or replace package wksp_ebs2cloud_migration.xx1_mig_tool_pkg1 as
    x_state varchar2(30);
    procedure xx1_post_url;

    procedure xx1_url_state;

end xx1_mig_tool_pkg;
/


-- sqlcl_snapshot {"hash":"f1f27d6cc8ed41856172c3e520dad14836fbe2e4","type":"PACKAGE_SPEC","name":"XX1_MIG_TOOL_PKG1","schemaName":"WKSP_EBS2CLOUD_MIGRATION","sxml":""}