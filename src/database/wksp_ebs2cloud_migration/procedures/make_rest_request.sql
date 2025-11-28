create or replace procedure wksp_ebs2cloud_migration.make_rest_request (
    p_url              in varchar2,
    p_http_method      in varchar2,
    p_body             in clob,
    p_user_name        in varchar2,
    p_password         in varchar2,
    p_transfer_timeout in varchar2,
    x_response         out clob,
    x_return_status    out varchar2,
    x_return_message   out varchar2
) is
    lc_status_code number;
    lc_response    clob;
begin

    -- Set required headers
    apex_web_service.g_request_headers.delete;
    apex_web_service.g_request_headers(1).name := 'Content-Type';
    apex_web_service.g_request_headers(1).value := 'application/vnd.oracle.adf.resourceitem+json';  

    -- Make the REST request
    lc_response := apex_web_service.make_rest_request(
        p_url              => p_url,
        p_http_method      => p_http_method,
        p_body             => p_body,
        p_username         => p_user_name,
        p_password         => p_password,
        p_transfer_timeout => to_number(p_transfer_timeout)
    );

    lc_status_code := apex_web_service.g_status_code;
    if lc_status_code = 200
    or lc_status_code = 201 then
        x_response := lc_response;
        x_return_status := 'SUCCESS';  -- Or replace with constant like G_STS_CODE
        x_return_message := null;
    else
        x_response := null;
        x_return_status := 'ERROR';    -- Or replace with constant like G_ERR_CODE
        x_return_message := 'REST call failed with status code ' || lc_status_code;
    end if;

exception
    when others then
        x_response := null;
        x_return_status := 'ERROR';
        x_return_message := 'Exception occurred: ' || sqlerrm;
end make_rest_request;
/


-- sqlcl_snapshot {"hash":"efe828bbe8682c068c0e7c29a26d35227237fbf2","type":"PROCEDURE","name":"MAKE_REST_REQUEST","schemaName":"WKSP_EBS2CLOUD_MIGRATION","sxml":""}