create or replace 
procedure WKSP_EBS2CLOUD_MIGRATION.xx1_url_stateasl_url varchar2(300);
l_status_code varchar2(300);
l_res  clob;
l_state varchar2(30);
beginl_url:='https://fa-etaj-dev18-saasfademo1.ds-fa.oraclepdemos.com/ess/rest/scheduler/v1/requests/6775295';
l_res := apex_web_service.make_rest_request(   
          p_url=>l_url,    
          p_http_method => 'GET',    
          p_credential_static_id => 'ERP_INTEGRATIONS');
          dbms_output.put_line(l_res);
          l_status_code:=apex_web_service.g_status_code;
   if l_status_code=200 then 
   select json_value(l_res,'$.state') into l_state from dual;
   dbms_output.put_line(l_state);
   end if;
end xx1_url_state;
/



-- sqlcl_snapshot {"hash":"20ec914395f8464581a57e5b05f870fab88e787a","type":"PROCEDURE","name":"XX1_URL_STATEASL_URL","schemaName":"WKSP_EBS2CLOUD_MIGRATION","sxml":""}