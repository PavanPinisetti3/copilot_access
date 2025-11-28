create or replace package body wksp_ebs2cloud_migration.xxmig_fusion_sql_connect as

    function get_bi_report_query (
        p_entity_name     in varchar2,
        p_sub_entity_name in varchar2
    ) return clob is
        l_report_query clob;
    begin
        select
            report_query
        into l_report_query
        from
            xxmig_fusion_bip_queries
        where
                entity = p_entity_name
            and sub_entity = p_sub_entity_name;

        return l_report_query;
    exception
        when others then
            return l_report_query;
    end get_bi_report_query;

    function bi_sqlconnect_envelope (
        p_base64_query in clob
    ) return clob is
        l_envelope clob;
    begin
        l_envelope := '<?xml version="1.0" encoding="UTF-8"?>  
   <soap:Envelope xmlns:soap="http://www.w3.org/2003/05/soap-envelope" xmlns:pub="http://xmlns.oracle.com/oxp/service/PublicReportService">  
      <soap:Header />  
      <soap:Body>  
         <pub:runReport>  
            <pub:reportRequest>  
               <pub:attributeFormat>csv</pub:attributeFormat>  
               <pub:parameterNameValues>  
                  <!--Zero or more repetitions:-->  
                  <pub:item>  
                     <pub:name>query1</pub:name>  
                     <pub:values>  
                        <pub:item>'
                      || p_base64_query
                      || '</pub:item>  
                     </pub:values>  
                  </pub:item>   
               </pub:parameterNameValues>
                  <pub:reportAbsolutePath>/Custom/Jitendra/PAAS_REPORTS/SqlConnectReportCSV.xdo</pub:reportAbsolutePath>
               <pub:sizeOfDataChunkDownload>-1</pub:sizeOfDataChunkDownload>  
            </pub:reportRequest>  
         </pub:runReport>  
      </soap:Body>  
   </soap:Envelope>';
        return l_envelope;
    end;

    procedure get_bi_sqlconnect_csv (
        p_entity_name     in varchar2,
        p_sub_entity_name in varchar2,
        p_url             in varchar2,
        p_user_name       in varchar2,
        p_password        in varchar2
    ) is

        l_xml          xmltype;
        l_envelope     clob;
        l_query        clob;
        l_base64_query clob;
        l_base64_csv   clob;
        l_data_blob    blob;
        l_url          varchar2(500) := p_url; 
    -- l_report_path varchar2(4000) :='https://fa-etaj-dev18-saasfademo1.ds-fa.oraclepdemos.com:443/xmlpserver/services/ExternalReportWSSService';  

    begin
        l_query := xxmig_fusion_sql_connect.get_bi_report_query(
            p_entity_name     => p_entity_name,
            p_sub_entity_name => p_sub_entity_name
        );
        l_base64_query := xx_erp_int_util_pkg.clob_to_base64(l_query);
        l_envelope := xxmig_fusion_sql_connect.bi_sqlconnect_envelope(l_base64_query);
        apex_web_service.g_request_headers.delete();
        apex_util.set_workspace(p_workspace => 'WKSP_EBS2CLOUD_MIGRATION');
        l_xml := apex_web_service.make_request(
            p_url              => l_url,
            p_version          => '1.2',
            p_envelope         => l_envelope,
            p_transfer_timeout => 500,
            p_username         => p_user_name,
            p_password         => p_password
        );

        if apex_web_service.g_status_code != 200 then
      
    --    l_data_blob := substr(l_xml,instr(l_xml,'env:Text xml:lang="en-US">')+26,Instr(substr(l_xml,instr(l_xml,'env:Text xml:lang="en-US">')+26),'</env:Text>')-1);
    --    insert into clob_data (col001) values (l_xml.getClobVal());
            l_data_blob := apex_util.clob_to_blob(
                p_clob    => l_xml.getclobval(),
                p_charset => 'AL32UTF8'
            );

            insert into xxmig_fusion_bip_run_logs (
                query_id,
                status,
                report_content,
                creation_date,
                created_by,
                last_updated_date,
                last_updated_by
            ) values ( xxmig_fusion_bip_run_logs_seq.nextval,
                       'E--' || apex_web_service.g_status_code,
                       null,
                       sysdate,
                       v('APP_USER'),
                       sysdate,
                       v('APP_USER') );

        else
            l_base64_csv := apex_web_service.parse_xml_clob(
                p_xml   => l_xml,
                p_xpath => '//ns2:runReportReturn/ns2:reportBytes/text()',
                p_ns    => 'xmlns:ns2="http://xmlns.oracle.com/oxp/service/PublicReportService"'
            );

            l_data_blob := xx_erp_int_util_pkg.decode_base64_blob(l_base64_csv);
            insert into xxmig_fusion_bip_run_logs (
                query_id,
                status,
                report_content,
                creation_date,
                created_by,
                last_updated_date,
                last_updated_by
            ) values ( xxmig_fusion_bip_run_logs_seq.nextval,
                       'Success',
                       l_data_blob,
                       sysdate,
                       v('APP_USER'),
                       sysdate,
                       v('APP_USER') );

        end if;

    exception
        when others then
            null;
    end get_bi_sqlconnect_csv;

end xxmig_fusion_sql_connect;
/


-- sqlcl_snapshot {"hash":"06f133c70542989e0a0f7413871ec5c96463e510","type":"PACKAGE_BODY","name":"XXMIG_FUSION_SQL_CONNECT","schemaName":"WKSP_EBS2CLOUD_MIGRATION","sxml":""}