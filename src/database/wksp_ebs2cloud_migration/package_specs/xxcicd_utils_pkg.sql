create or replace package wksp_ebs2cloud_migration.xxcicd_utils_pkg as
    -- Package specification
    function get_system_date return date;

    procedure log_message (
        p_message in varchar2
    );

    function calculate_tax (
        p_amount in number
    ) return number;

end xxcicd_utils_pkg;
/


-- sqlcl_snapshot {"hash":"605bf3420dbab9bfeedad3df64ce09b6396d09a0","type":"PACKAGE_SPEC","name":"XXCICD_UTILS_PKG","schemaName":"WKSP_EBS2CLOUD_MIGRATION","sxml":""}