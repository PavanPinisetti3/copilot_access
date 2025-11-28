create or replace package body wksp_ebs2cloud_migration.xxcicd_utils_pkg as
    -- Package body
    function get_system_date return date is
    begin
        return sysdate;
    end;

    procedure log_message (
        p_message in varchar2
    ) is
    begin
        dbms_output.put_line('['
                             || to_char(sysdate, 'YYYY-MM-DD HH24:MI:SS')
                             || '] '
                             || p_message);
    end;

    function calculate_tax (
        p_amount in number
    ) return number is
    begin
        return p_amount * 0.18; -- 18% tax
    end;

end xxcicd_utils_pkg;
/


-- sqlcl_snapshot {"hash":"26fc023d0becd4a1d513c7b125a202de0075f803","type":"PACKAGE_BODY","name":"XXCICD_UTILS_PKG","schemaName":"WKSP_EBS2CLOUD_MIGRATION","sxml":""}