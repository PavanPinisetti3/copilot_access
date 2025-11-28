create or replace procedure wksp_ebs2cloud_migration.xx1_url_state as

    l_url          varchar2(300);
    l_status_code  varchar2(3);  -- Status codes are typically 3 digits
    l_res          clob;
    l_state        varchar2(30);
    l_request_body clob;  -- CLOB variable for request body
begin
    -- URL for the REST API request
    l_url := 'https://fa-etaj-dev18-saasfademo1.ds-fa.oraclepdemos.com/fscmRestApi/resources/latest/erpintegrations';

    -- Prepare the request body as a CLOB
    l_request_body := to_clob('{
        "Supplier": "Tall Manufacturing",
        "TaxOrganizationType": "Corporation",
        "SupplierType": "Services",
        "BusinessRelationship": "Prospective",
        "DUNSNumber": "221134567",
        "OneTimeSupplierFlag": false,
        "TaxpayerCountry": "United States",
        "TaxpayerId": "98-03376354"
    }');  -- Example JSON payload

    -- Make the REST API call with POST method
    l_res := apex_web_service.make_rest_request(
        p_url                  => l_url,
        p_http_method          => 'POST',
        p_request_body         => l_request_body,  -- Include the CLOB request body
        p_credential_static_id => 'ERP_INTEGRATIONS',  -- Ensure this ID is valid
        p_request_headers      => apex_util.string_to_table('Content-Type=application/json')  -- Set the content type
    );

    -- Output the response
    dbms_output.put_line('Response: ' || l_res);

    -- Get the status code from the last web service call
    l_status_code := apex_web_service.g_status_code;

    -- Check if the response status code is 200 (OK)
    if l_status_code = '200' then  -- Compare with string '200'
        -- Extract the 'state' value from the JSON response
        select
            json_value(l_res, '$.state')
        into l_state
        from
            dual;

        -- Output the state
        dbms_output.put_line('State: ' || l_state);
    else
        -- Handle error case
        dbms_output.put_line('Error: ' || l_status_code);
    end if;

exception
    when others then
        -- Handle exceptions and print the error message
        dbms_output.put_line('Exception occurred: ' || sqlerrm);
end xx1_url_state;
/


-- sqlcl_snapshot {"hash":"948ae6ca432ba8e70a060530d4cf4c9ec323e658","type":"PROCEDURE","name":"XX1_URL_STATE","schemaName":"WKSP_EBS2CLOUD_MIGRATION","sxml":""}