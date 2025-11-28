create or replace package body wksp_ebs2cloud_migration.xx_erp_int_util_pkg as

    function generate_alias_name (
        p_table_name in varchar2
    ) return varchar is
        l_alias_name varchar2(120);
    begin
        l_alias_name := substr(p_table_name, 1, 2);
        for i in 1..length(p_table_name) loop
            if ( substr(p_table_name, i, 1) = '_' ) then
                l_alias_name := l_alias_name
                                || substr(p_table_name, i + 1, 1);
            end if;
        end loop;

        return l_alias_name;
    end;

    function generate_csv_file return clob is

        l_csv_file_content clob;
        cursor fbdi_csv_file is
        (
            select
                'sample'
                || null
                || ','
                || 'Text' dummy
            from
                dual
        );

    begin
        for i in fbdi_csv_file loop
            l_csv_file_content := l_csv_file_content || to_clob(i.dummy);
        end loop;

        return l_csv_file_content;
    end;

    function zip_csv_file (
        p_clob in clob
    ) return blob is
        l_zipped_file blob;
        l_file_name   varchar2(240) := 'PozSuppliersInt.csv';
    begin
        apex_zip.add_file(
            p_zipped_blob => l_zipped_file,
            p_file_name   => l_file_name,
            p_content     => apex_util.clob_to_blob(
                p_clob    => p_clob,
                p_charset => 'AL32UTF8'
            )
        );

        apex_zip.finish(p_zipped_blob => l_zipped_file);
        return l_zipped_file;
    end;

    function blob_to_base64 (
        p_blob in blob
    ) return clob is
        l_base64_content clob;
    begin
        dbms_lob.createtemporary(l_base64_content, true);
        l_base64_content := apex_web_service.blob2clobbase64(p_blob);
        dbms_lob.freetemporary(l_base64_content);
        insert into temp ( response ) values ( l_base64_content );

    end;

    function clob_to_base64 (
        p_clob in clob
    ) return clob as

        l_chunk_size integer := 57;
        l_offset     integer := 1;
        l_tmp        clob;
        l_result     clob;
        l_chunk      raw(100);
        l_chunk_b64  varchar2(200);
    begin
        dbms_lob.createtemporary(l_tmp, false);
        while l_offset < dbms_lob.getlength(p_clob) loop
            l_chunk := utl_raw.cast_to_raw(dbms_lob.substr(p_clob, l_chunk_size, l_offset));

            l_chunk_b64 := utl_raw.cast_to_varchar2(utl_encode.base64_encode(l_chunk));
            dbms_lob.writeappend(l_tmp,
                                 length(l_chunk_b64),
                                 l_chunk_b64);
            l_offset := l_offset + l_chunk_size;
        end loop;

        l_result := l_tmp;
        dbms_lob.freetemporary(l_tmp);
        return l_result;
    end clob_to_base64;

    function decode_base64_blob (
        p_clob clob
    ) return blob is

        l_blob   blob;
        l_raw    raw(32767);
        l_amt    number := 7700;
        l_offset number := 1;
        l_temp   varchar2(32767);
    begin
        begin
            dbms_lob.createtemporary(l_blob, false, dbms_lob.call);
            loop
                dbms_lob.read(p_clob, l_amt, l_offset, l_temp);
                l_offset := l_offset + l_amt;
                l_raw := utl_encode.base64_decode(utl_raw.cast_to_raw(l_temp));
                dbms_lob.append(l_blob,
                                to_blob(l_raw));
            end loop;

        exception
            when no_data_found then
                null;
        end;

        return l_blob;
    end;

    procedure migrate_to_cloud (
        p_url              in varchar2,
        p_operation_name   in varchar2,
        p_doc_content      in clob,-- Encoded Base 64 goes here
        p_doc_content_type in varchar2,
        p_file_name        in varchar2,
        p_document_account in varchar2,
        p_job_name         in varchar2,
        p_param_list       in varchar2,
        p_callback_url     in varchar2,
        p_notify_code      in varchar2,
        p_job_options      in varchar2
    ) is
        l_resp        varchar2(2400);
        l_status_code number;
        l_req_id      number;
        l_payload     clob;
    begin
        select
            json_object(
                'OperationName' value p_operation_name,
                'DocumentContent' value p_doc_content,
                'ContentType' value p_doc_content_type,
                'FileName' value p_file_name,
                'DocumentAccount' value p_document_account,
                        'JobName' value p_job_name,
                'ParameterList' value p_param_list,
                'CallbackURL' value p_callback_url,
                'NotificationCode' value p_notify_code,
                'JobOptions' value p_job_options
            )
        into l_payload
        from
            dual;

        --setting the required headers 
        apex_web_service.g_request_headers.delete();
        apex_web_service.g_request_headers(1).name := 'Content-Type';
        apex_web_service.g_request_headers(1).value := 'application/vnd.oracle.adf.resourceitem+json';  
        
        --Makking the Rest Call
        l_resp := apex_web_service.make_rest_request(
            p_url                  => p_url,
            p_http_method          => 'POST',
            p_transfer_timeout     => 60,
            p_body                 => l_payload,
            p_credential_static_id => 'ERP_INTEGRATIONS' --null--needto set up the credentials in web credentials
        );

        insert into temp ( col01 ) values ( 'url' || p_url );
        -- insert into temp (Response) values (l_payload);

        select
            apex_web_service.g_status_code
        into l_status_code
        from
            dual;

        insert into temp ( col01 ) values ( 'Status' || l_status_code );

        if ( l_status_code = 201 ) then
            select
                json_value(l_resp, '$.ReqstId')
            into l_req_id
            from
                dual; 
        -- insert into temp (Response) values (l_resp);
            insert into temp ( col01 ) values ( l_req_id );

        end if;

    end;

end xx_erp_int_util_pkg;
/


-- sqlcl_snapshot {"hash":"3a850a4e2eac73c33797b6b879882620c90db252","type":"PACKAGE_BODY","name":"XX_ERP_INT_UTIL_PKG","schemaName":"WKSP_EBS2CLOUD_MIGRATION","sxml":""}