create or replace package body wksp_ebs2cloud_migration.xx2_mig_tool_pkg as

    procedure xx2_post_url is
        x_url         varchar2(300);
        x_status_code varchar2(300);
        x_res         clob;
        x_body        clob;
    begin
        x_url := 'https://fa-etaj-dev18-saasfademo1.ds-fa.oraclepdemos.com/fscmRestApi/resources/latest/erpintegrations';
        x_body := to_clob('
    {
      "OperationName": "importBulkData",
      "DocumentContent": "UEsDBBQAAAAIAC1hRFkOLw5wXAAAAOsAAAATAAAAUG96U3VwcGxpZXJzSW50LmNzdnMOcnUMcdVJLi0uyc/VAQJn/6AA/yDHEE9/PyAvOMDVzyXeMTTEwz/IM8rVBShkZGRoZmBpZGBmaqoDA55+OgMMnBJLkjPijcxBLjMyMbC0tDQ0NIQ7EOgJXi4AUEsBAhQAFAAAAAgALWFEWQ4vDnBcAAAA6wAAABMAAAAAAAAAAQAgAAAAAAAAAFBvelN1cHBsaWVyc0ludC5jc3ZQSwUGAAAAAAEAAQBBAAAAjQAAAAAA",
      "ContentType": "zip",
      "FileName": "PozSuppliersInt100009.zip",
      "DocumentAccount": "prc$/supplier$/import$",
      "JobName": "/oracle/apps/ess/prc/poz/supplierImport,ImportSuppliers",
      "ParameterList": "NEW,Y,Batch_2709202409991115",
      "CallbackURL": "https://winfo106.winfosolutions.com:4443/winbot/wksp_ebs2cloud_migration/fbdi_callback/url"
    }');
        apex_web_service.g_request_headers.delete();
        apex_web_service.g_request_headers(1).name := 'Content-Type';
        apex_web_service.g_request_headers(1).value := 'application/json';
        x_res := apex_web_service.make_rest_request(
            p_url                  => x_url,
            p_body                 => x_body,
            p_http_method          => 'POST',
            p_credential_static_id => 'ERP_INTEGRATIONS'
        );

        x_status_code := apex_web_service.g_status_code;
        if x_status_code = 201 then
            select
                json_value(x_res, '$.ReqstId')
            into x_state
            from
                dual;

            insert into xx_dem values ( x_state );

            dbms_output.put_line(x_state);
            dbms_output.put_line('sgdbin');
        end if;

    end xx2_post_url;

    procedure xx2_url_state is

        l_url         varchar2(300);
        l_status_code varchar2(300);
        l_res         clob;
        l_state       varchar2(30);
    begin
        l_url := 'https://fa-etaj-dev18-saasfademo1.ds-fa.oraclepdemos.com/ess/rest/scheduler/v1/requests/' || x_state;
        l_res := apex_web_service.make_rest_request(
            p_url                  => l_url,
            p_http_method          => 'GET',
            p_credential_static_id => 'ERP_INTEGRATIONS'
        );

        l_status_code := apex_web_service.g_status_code;
        if l_status_code = 200 then
            select
                json_value(l_res, '$.state')
            into l_state
            from
                dual;

            dbms_output.put_line(x_state);
            dbms_output.put_line(l_state);
        end if;

    end xx2_url_state;

    procedure xx2_get_status is
    begin
        xx2_post_url;
        xx2_url_state;
    end xx2_get_status;

end xx2_mig_tool_pkg;
/


-- sqlcl_snapshot {"hash":"29088c4a4a7799792b6e5c5a5aeeee15f0ac54dd","type":"PACKAGE_BODY","name":"XX2_MIG_TOOL_PKG","schemaName":"WKSP_EBS2CLOUD_MIGRATION","sxml":""}