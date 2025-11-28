create or replace procedure wksp_ebs2cloud_migration.import_bulk_data as
    l_url          varchar2(300);
    l_status_code  varchar2(3);  -- Status codes are typically 3 digits
    l_res          clob;
    l_request_body clob;  -- CLOB variable for request body
begin
    -- URL for the REST API request
    l_url := 'https://fa-etaj-dev18-saasfademo1.ds-fa.oraclepdemos.com/fscmRestApi/resources/latest/erpintegrations';  -- Replace with the actual API endpoint

    -- Prepare the request body as a CLOB
    l_request_body := to_clob('{
   "OperationName":"importBulkData",
   "DocumentContent":"UEsDBBQAAAAIAAaIRFlLzd4aZQAAAPAAAAATAAAAUG96U3VwcGxpZXJzSW50LmNzdnMOcnUMcdVxSszLVshPU/D009ExMjAyMNHRcc4vKsgvSizJzM/TCS4tKMjJTC1S0NEJCPIPDnB1DvEMc9UBAQUo1lEIDQaxIJAgIFIZWcApsSQ5I97RxBDoESMTI5iwq58LLxcAUEsBAhQAFAAAAAgABohEWUvN3hplAAAA8AAAABMAAAAAAAAAAQAgAAAAAAAAAFBvelN1cHBsaWVyc0ludC5jc3ZQSwUGAAAAAAEAAQBBAAAAlgAAAAAA",
   "ContentType":"zip",
   "FileName":"PozSuppliersInt.zip",
   "DocumentAccount":"prc$/supplier$/import$",
   "JobName":"/oracle/apps/ess/prc/poz/supplierImport,ImportSuppliers",
   "ParameterList":"NEW,Y,Batch_A41020242",
   "CallbackURL": "#NULL"
    }');  -- Example JSON payload

      --setting the required headers 
    apex_web_service.g_request_headers.delete();
    apex_web_service.g_request_headers(1).name := 'Content-Type';
    apex_web_service.g_request_headers(1).value := 'application/json';  
    -- Make the REST API call with POST method

    l_res := apex_web_service.make_rest_request(
        p_url                  => l_url,
        p_http_method          => 'POST',
        p_credential_static_id => 'ERP_INTEGRATIONS',  -- Ensure this ID is valid
        p_body                 => l_request_body
    );

    -- Output the response
    dbms_output.put_line('Response: ' || l_res);

    -- Get the status code from the last web service call
    l_status_code := apex_web_service.g_status_code;

    -- Check if the response status code is 200 (OK) or 201 (Created)
    if l_status_code in ( '200', '201' ) then
        dbms_output.put_line('Bulk import request processed successfully.');
    else
        -- Handle error case
        dbms_output.put_line('Error: '
                             || l_status_code
                             || ' - '
                             || l_res);
    end if;

exception
    when others then
        -- Handle exceptions and print the error message
        dbms_output.put_line('Exception occurred: ' || sqlerrm);
end import_bulk_data;
/


-- sqlcl_snapshot {"hash":"83a2c698c68f19a1365e7290620120240fb58d5f","type":"PROCEDURE","name":"IMPORT_BULK_DATA","schemaName":"WKSP_EBS2CLOUD_MIGRATION","sxml":""}