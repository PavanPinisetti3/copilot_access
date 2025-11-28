create or replace procedure wksp_ebs2cloud_migration.xx1_post_url as

    x_url         varchar2(300);
    x_status_code varchar2(300);
    x_res         clob;
    x_body        clob;
    x_state       varchar(30);
begin
    x_url := 'https://fa-etaj-dev18-saasfademo1.ds-fa.oraclepdemos.com/fscmRestApi/resources/latest/erpintegrations';
    x_body := '
{
              "OperationName":"importBulkData",
              "DocumentContent":"UEsDBBQAAAAIAC1hRFkOLw5wXAAAAOsAAAATAAAAUG96U3VwcGxpZXJzSW50LmNzdnMOcnUMcdVJLi0uyc/VAQJn/6AA/yDHEE9/PyAvOMDVzyXeMTTEwz/IM8rVBShkZGRoZmBpZGBmaqoDA55+OgMMnBJLkjPijcxBLjMyMbC0tDQ0NIQ7EOgJXi4AUEsBAhQAFAAAAAgALWFEWQ4vDnBcAAAA6wAAABMAAAAAAAAAAQAgAAAAAAAAAFBvelN1cHBsaWVyc0ludC5jc3ZQSwUGAAAAAAEAAQBBAAAAjQAAAAAA",
              "ContentType":"zip",
              "FileName":"PozSuppliersInt100009.zip",
              "DocumentAccount":"prc$/supplier$/import$",
              "JobName":"/oracle/apps/ess/prc/poz/supplierImport,ImportSuppliers",
              "ParameterList":"NEW,Y,Batch_2709202409991115",
              "CallbackURL": "#NULL"
            }';
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

        dbms_output.put_line(x_state);
    end if;

end xx1_post_url;
/


-- sqlcl_snapshot {"hash":"0e96f2984504ee0f8b9826788eea70f18aab40b1","type":"PROCEDURE","name":"XX1_POST_URL","schemaName":"WKSP_EBS2CLOUD_MIGRATION","sxml":""}