create or replace package body wksp_ebs2cloud_migration.xxmig_generate_csv_file_pkg as

--+==============================================================================+
--|                        Winfo Consulting, UK.                                 |
--+==============================================================================+
--|Description      :This package uses the rest api's and payload to create      |
--|                  the AP,AR,SLA,GL,CMFS modules data for the which is present |
--|                  in the EBS                                                  |
--|                                                                              |
--+==============================================================================+
 
 

  -- +========================================================================================+
  -- | Name :              xxmig_supplier_template                                            |
  -- |                                                                                        |
  -- | Description :       This procedure will the suppliers related all data                 |
  -- |                     in the fusion using the rest api                                   |
  -- |                                                                                        |
  -- +========================================================================================+ 
    procedure xxmig_supplier_template (
        p_temp_name     in varchar2,
        x_error_status  out varchar2,
        x_error_message out varchar2
    ) as

        lc_clob     clob;
        lb_zippped  blob;
        lc_base64   clob;
        lb_base64   blob;
        ln_clob     clob;
        lb_zip_file blob;
        ln_count    number;
        custom_exception exception;
        cursor lcu_supplier_payload (
            p_temp_name varchar2
        ) is
        select
            xp.url,
            xp.file_name,
            xp.document_account,
            xp.job_name
        from
            xxmig_payloads xp
        where
            xp.sub_entity = p_temp_name;

        lr_count    lcu_supplier_payload%rowtype;

  -- +========================================================================================+
  -- | Name :              xxmig_supplier                                            |
  -- |                                                                                        |
  -- | Description :       This procedure will create the suppliers in the fusion using       |
  -- |                      the rest api                                                      |
  -- |                                                                                        |
  -- +========================================================================================+ 

        procedure xxmig_supplier (
            p_temp_name in varchar2
        ) as
        begin
            open lcu_supplier_payload(p_temp_name);
            fetch lcu_supplier_payload into lr_count;
            close lcu_supplier_payload;
            for i in (
                select
                    'CREATE'
                    || ','
                    || 'J1 Supp dup1733'
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || 'Corporation'
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || 'SPEND_AUTHORIZED'
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || 'US'
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || 'Y'
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || 'Batch_01052025'
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || 'END' as csv_row
                from
                    xxmig_suppliers_stg
                where
                    rownum <= 3
            ) loop
                lc_clob := lc_clob
                           || to_clob(i.csv_row)
                           || chr(10);
            end loop;

           -- INSERT INTO temp (Response) VALUES (lc_clob);
            lb_zippped := xx_erp_int_util_pkg.zip_csv_file(lc_clob);
           -- lc_base64  := XX_ERP_INT_UTIL_PKG.blob_to_base64 (lb_zippped);
            lc_base64 := apex_web_service.blob2clobbase64(lb_zippped);
            insert into temp ( response ) values ( lc_base64 );

            xx_erp_int_util_pkg.migrate_to_cloud(
                p_url              => lr_count.url,
                p_operation_name   => g_operation_name,
                p_doc_content      => lc_base64,
                p_doc_content_type => g_doc_content_type,
                p_file_name        => lr_count.file_name,
                p_document_account => lr_count.document_account,
                p_job_name         => lr_count.job_name,
                p_param_list       => 'NEW,Y,Batch_01052025',
                p_callback_url     => '#null',
                p_notify_code      => null,
                p_job_options      => null
            );      

        

    	-- log_enter(p_routine_name         =>      'HI' 
        --             ,p_name01           =>      'SELECT clause' 
        --             ,p_value01          =>      lc_clob 
        --             ,p_name02           =>      'stagging table'
        --             ,p_value02          =>      'xxmig_suppliers_stg'
        --           );

        end xxmig_supplier;
   
  -- +========================================================================================+
  -- | Name :              xxmig_supplier_address                                             |
  -- |                                                                                        |
  -- | Description :       This procedure will create the suppliers address in the fusion     |
  -- |                      using the rest api.                                               |
  -- |                                                                                        |
  -- +========================================================================================+    

        procedure xxmig_supplier_address (
            p_temp_name in varchar2
        ) as
        begin
            open lcu_supplier_payload(p_temp_name);
            fetch lcu_supplier_payload into lr_count;
            close lcu_supplier_payload;
            for i in (
                select
                    'CREATE'
                    || ','
                    || 'J1 Supp dup12'
                    || ','
                    || party_site_name
                    || ',,'
                    || country
                    || ','
                    || ',,,,,,,,,,,,,,,,,,,,,,,,,,,,,'
                    || 'Y'
                    || ',,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,'
                    || 'Batch_SA1122'
                    || 'END' as csv_row
                from
                    xxmig_sup_address_stg
                where
                    rownum <= 1
            ) loop
                lc_clob := lc_clob
                           || to_clob(i.csv_row)
                           || chr(10);
            end loop;

            -- INSERT INTO temp (Response) VALUES (lc_clob);
            lb_zippped := xx_erp_int_util_pkg.zip_csv_file(lc_clob);
            -- lc_base64  := XX_ERP_INT_UTIL_PKG.blob_to_base64 (lb_zippped);
            lc_base64 := apex_web_service.blob2clobbase64(lb_zippped);
            insert into temp ( response ) values ( lc_base64 );

            xx_erp_int_util_pkg.migrate_to_cloud(
                p_url              => lr_count.url,
                p_operation_name   => g_operation_name,
                p_doc_content      => lc_base64,
                p_doc_content_type => g_doc_content_type,
                p_file_name        => lr_count.file_name,
                p_document_account => lr_count.document_account,
                p_job_name         => lr_count.job_name,
                p_param_list       => 'NEW,Y,Batch_SA1122',
                p_callback_url     => '#null',
                p_notify_code      => null,
                p_job_options      => null
            ); 
					
					
					
	    --    log_enter(p_routine_name      =>   'xxmig_supplier_address' 
        --              ,p_name01           =>   'SELECT clause' 
        --              ,p_value01          =>    lc_clob 
        --              ,p_name02           =>   'stagging table'
        --              ,p_value02          =>   'xxmig_suppliers_stg'
        --            ); 				

        end xxmig_supplier_address;

  
    -- +========================================================================================+
  -- | Name :              xxmig_supplier_site                                                |
  -- |                                                                                        |
  -- | Description :       This procedure will create the suppliers site in the fusion        |
  -- |                      using the rest api.                                               |
  -- |                                                                                        |
  -- +========================================================================================+ 

        procedure xxmig_supplier_site (
            p_temp_name in varchar2
        ) as
      ---lb_zip_file BLOB;
      --lc_clob CLOB;
      --ln_clob CLOB;
      --lc_blob BLOB;
      --lb_base64 BLOB;
        begin
            open lcu_supplier_payload(p_temp_name);
            fetch lcu_supplier_payload into lr_count;
            close lcu_supplier_payload;
            for i in (
                select
                    'CREATE'
                    || ','
                    || 'Lee Supplies'
                    || ','
                    || 'US1 Business Unit'
                    || ','
                    || 'Lee US1'
                    || ','
                    || ' MAIN-PURCH1738'
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || 'N'
                    || ','
                    || 'Y'
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || 'Batch_17212037'
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || 'END' as csv_row
                from
                    xxmig_supplier_site_stg
            )
    -- WHERE rownum<=1) 
             loop
                lc_clob := lc_clob
                           || to_clob(i.csv_row)
                           || chr(10);
            end loop;
  
    --   FOR i IN (
    --       SELECT
    --           CHR(10)||CHR(13) AS csv_row
    --       FROM xxmig_supplier_site_stg
    --       WHERE rownum<=1
    --   ) 
    --   LOOP
    --       ln_clob := ln_clob || TO_CLOB(i.csv_row);
    --   END LOOP;
  
    --   DELETE FROM XXCUSTOM_TEMP;
  
    --   INSERT INTO XXCUSTOM_TEMP(col1,col3) VALUES('PozSupplierSitesInt.csv',lc_clob);
    --   INSERT INTO XXCUSTOM_TEMP(col1,col3) VALUES('PozSupThirdPartyInt.csv',ln_clob);
  
    --   -- SELECT FILE_CONTENT
    --   -- INTO lb_zip_file 
    --   -- FROM apex_application_static_files 
    --   -- WHERE APPLICATION_FILE_ID = 19900754685909037;
  
    --   FOR l_file IN ( SELECT col1 as file_name, col3 FROM XXCUSTOM_TEMP )
  
    --   LOOP
  
    --       apex_zip.add_file (
  
    --           p_zipped_blob => lb_zip_file,
    --           p_file_name   => l_file.file_name,
    --           p_content     => apex_util.clob_to_blob(p_clob => l_file.col3,p_charset => 'AL32UTF8'));
  
    --   END LOOP;
   
    --   apex_zip.finish (
    --       p_zipped_blob => lb_zip_file );
  
    --       INSERT INTO XXCUSTOM_TEMP (col4) VALUES (lb_zip_file);
  
  
    --       -- lb_zippped := XX_ERP_INT_UTIL_PKG.zip_csv_file (lc_clob);
    --       lc_base64 := APEX_WEB_SERVICE.BLOB2CLOBBASE64(lb_zip_file);
    --       lb_base64 := APEX_WEB_SERVICE.CLOBBASE642BLOB ( p_clob =>  lc_base64);
    --       INSERT INTO temp (response) VALUES (lc_base64);
    --   INSERT INTO temp (Response) VALUES (lc_clob);

            lb_zippped := xx_erp_int_util_pkg.zip_csv_file(lc_clob);
            -- lc_base64  := XX_ERP_INT_UTIL_PKG.blob_to_base64 (lb_zippped);
            lc_base64 := apex_web_service.blob2clobbase64(lb_zippped);
            insert into temp ( response ) values ( lc_base64 );

            insert into temp ( col01 ) values ( lc_clob );

            xx_erp_int_util_pkg.migrate_to_cloud(
                p_url              => lr_count.url,
                p_operation_name   => g_operation_name,
                p_doc_content      => lc_base64,
                p_doc_content_type => g_doc_content_type,
                p_file_name        => 'PozSupplierSitesInt17212025.zip'--lr_count.file_name
                ,
                p_document_account => lr_count.document_account,
                p_job_name         => lr_count.job_name,
                p_param_list       => 'NEW,Y,Batch_17212037',
                p_callback_url     => '#null',
                p_notify_code      => null,
                p_job_options      => null
            );

        end xxmig_supplier_site;

  -- +========================================================================================+
  -- | Name :              xxmig_supplier_site_assign                                         |
  -- |                                                                                        |
  -- | Description :       This procedure will create the suppliers site assignmemt in the    |
  -- |                      fusion using the rest api.                                        |
  -- |                                                                                        |
  -- +========================================================================================+ 
        procedure xxmig_supplier_site_assign (
            p_temp_name in varchar2
        ) as
        begin
            open lcu_supplier_payload(p_temp_name);
            fetch lcu_supplier_payload into lr_count;
            close lcu_supplier_payload;
            for i in (
                select
                    'CREATE'
                    || ','
                    || 'J1 Supp dup'
                    || ','
                    || vendor_site_code
                    || ','
                    || procurement_business_unit_name
                    || ','
                    || business_unit_name
                    || ','
                    || bill_to_bu_name
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || allow_awt_flag
                    || ',,,,,,,'
                    || 'Batch_HI031276'
                    || ','
                    || 'END' as csv_row
                from
                    xxmig_sup_site_assign_stg
                where
                    rownum <= 1
            ) loop
                lc_clob := lc_clob
                           || to_clob(i.csv_row)
                           || chr(10);
            end loop;

           -- INSERT INTO temp (Response) VALUES (lc_clob);
            lb_zippped := xx_erp_int_util_pkg.zip_csv_file(lc_clob);
           -- lc_base64  := XX_ERP_INT_UTIL_PKG.blob_to_base64 (lb_zippped);
            lc_base64 := apex_web_service.blob2clobbase64(lb_zippped);
            insert into temp ( response ) values ( lc_base64 );

            xx_erp_int_util_pkg.migrate_to_cloud(
                p_url              => lr_count.url,
                p_operation_name   => g_operation_name,
                p_doc_content      => lc_base64,
                p_doc_content_type => g_doc_content_type,
                p_file_name        => lr_count.file_name,
                p_document_account => lr_count.document_account,
                p_job_name         => lr_count.job_name,
                p_param_list       => 'NEW,Y,Batch_HI031276',
                p_callback_url     => '#null',
                p_notify_code      => null,
                p_job_options      => null
            );

        end xxmig_supplier_site_assign;
  -- +========================================================================================+
  -- | Name :              xxmig_supplier_contact                                             |
  -- |                                                                                        |
  -- | Description :       This procedure will create the suppliers contacts in the           |
  -- |                      fusion using the rest api.                                        |
  -- |                                                                                        |
  -- +========================================================================================+ 
        procedure xxmig_supplier_contact (
            p_temp_name in varchar2
        ) as
    --lb_zip_file BLOB;
    --lc_clob CLOB;
    --ln_clob CLOB;
    --lc_blob BLOB;
        begin
            open lcu_supplier_payload(p_temp_name);
            fetch lcu_supplier_payload into lr_count;
            close lcu_supplier_payload;
            for i in (
                select
                    'CREATE'
                    || ','
                    || 'J1 supp dup12'
                    || ','
                    || null
                    || ','
                    || first_name
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || last_name
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || 'Y'
                    || ','
                    || email_address
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || 'Batch_SL50228'
                    || ','
                    || 'CREATE_ACCOUNT_WITH_DEFAULT_SUPPLIER_PORTAL_ROLES'
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || 'END' as csv_row
                from
                    xxmig_sup_contacts_stg
                where
                    rownum <= 1
            ) loop
                lc_clob := lc_clob
                           || to_clob(i.csv_row)
                           || chr(10);
            end loop;

            for i in (
                select
                    chr(10)
                    || chr(13) as csv_row
                from
                    xxmig_sup_contacts_stg
                where
                    rownum <= 1
            ) loop
                ln_clob := ln_clob || to_clob(i.csv_row);
            end loop;

            delete from xxcustom_temp;

            insert into xxcustom_temp (
                col1,
                col3
            ) values ( 'PozSupContactsInt.csv',
                       lc_clob );

            insert into xxcustom_temp (
                col1,
                col3
            ) values ( 'PozSupContactAddressesInt.csv',
                       ln_clob );

            for l_file in (
                select
                    col1 as file_name,
                    col3
                from
                    xxcustom_temp
            ) loop
                apex_zip.add_file(
                    p_zipped_blob => lb_zip_file,
                    p_file_name   => l_file.file_name,
                    p_content     => apex_util.clob_to_blob(
                        p_clob    => l_file.col3,
                        p_charset => 'AL32UTF8'
                    )
                );
            end loop;

            apex_zip.finish(p_zipped_blob => lb_zip_file);
            insert into xxcustom_temp ( col4 ) values ( lb_zip_file );

            lc_base64 := apex_web_service.blob2clobbase64(lb_zip_file);
            insert into temp ( response ) values ( lc_base64 );

            xx_erp_int_util_pkg.migrate_to_cloud(
                p_url              => lr_count.url,
                p_operation_name   => g_operation_name,
                p_doc_content      => lc_base64,
                p_doc_content_type => g_doc_content_type,
                p_file_name        => lr_count.file_name,
                p_document_account => lr_count.document_account,
                p_job_name         => lr_count.job_name,
                p_param_list       => 'NEW,Y,Batch_SL50228',
                p_callback_url     => '#null',
                p_notify_code      => null,
                p_job_options      => null
            );

        end xxmig_supplier_contact;

    begin
        select
            count(*)
        into ln_count
        from
            xxmig_suppliers_stg;

        if ln_count <= 0 then
            raise custom_exception;
        else
            if upper(p_temp_name) = upper('Suppliers') then
                xxmig_supplier(p_temp_name);
            elsif upper(p_temp_name) = upper('supplier address') then
                xxmig_supplier_address(p_temp_name);
            elsif upper(p_temp_name) = upper('supplier site') then
                xxmig_supplier_site(p_temp_name);
            elsif upper(p_temp_name) = upper('SUPPLIERS SITE ASSIGNMENTS') then
                xxmig_supplier_site_assign(p_temp_name);
            elsif upper(p_temp_name) = upper('suppliers contacts') then
                xxmig_supplier_contact(p_temp_name);
            end if;
        end if;

    exception
        when custom_exception then
            x_error_message := x_error_message || 'no supplier data is found in the table xxmig_suppliers_stg';
            x_error_status := g_error_status;
    end xxmig_supplier_template;

    procedure xxmig_ap_invoice (
        p_temp_name in varchar2
    ) as
        lb_zip_file blob;
        lc_clob     clob;
        ln_clob     clob;
        lc_blob     blob;
        lb_base64   blob;
        lc_base64   clob;
    -- G_OPERATION_NAME varchar2(30):=
    begin
        for i in (
            select
                14186570
                || ','
                || 'Vision Operations'
                || ','
                || 'External'
                || ','
                || 'AP_Demo_Std_Bad_Data_1418'
                || ','
                || 14403.9
                || ','
                || '2025/02/12'
                || ','
                || 'TP1 Supp dup'
                || ',,'
                || 'Trading_Partner_TP1'
                || ','
                || 'USD'
                || ','
                || 'USD'
                || ','
                || 'Standard Invoice with bad data in Invoice Date - Incorrect date format'
                || ','
                || 'AP_Cloud_Demo9'
                || ','
                || 'STANDARD'
                || ',,,,,,'
                || 'Immediate'
                || ','
                || '2025/04/01'
                || ',,,'
                || '2025/04/01'
                || ','
                || 'CHECK'
                || ','
                || 'Standard'
                || ','
                || '#NULL'
                || ',,,,,,,,,,'
                || '01-000-2210-0000-000'
                || ','
                || '#NULL'
                || ',,,,,'
                || '#NULL'
                || ','
                || '#NULL'
                || ',,,,'
                || 21
                || ','
                || '#NULL'
                || ',,,'
                || '#NULL'
                || ','
                || '#NULL'
                || ',,,,'
                || '#NULL'
                || ',,,,,,,,,,,,,,,'
                || 'N'
                || ','
                || 'N'
                || ',,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,'
                || 'END' as csv_row
            from
                dual
        ) loop
            lc_clob := lc_clob
                       || to_clob(i.csv_row)
                       || chr(10)
                       || chr(13);
        end loop;

        for i in (
            select
                14186570
                || ','
                || 1
                || ','
                || 'ITEM'
                || ','
                || 1472.25
                || ',,,,,,,,,,,,,,,,,'
                || 'N'
                || ','
                || '01-420-7110-0000-000'
                || ','
                || '#NULL'
                || ','
                || '2025/02/12'
                || ',,,,,'
                || '#NULL'
                || ',,,,,,,,,,,,,,,,,'
                || '#NULL'
                || ',,,'
                || 'N'
                || ','
                || 1
                || ',,,'
                || 'N'
                || ',,,,,,,'
                || 'N'
                || ',,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,'
                || 'END' as csv_row
            from
                dual
        ) loop
            ln_clob := ln_clob
                       || to_clob(i.csv_row)
                       || chr(10)
                       || chr(13);
        end loop;

        delete from xxcustom_temp;

        insert into xxcustom_temp (
            col1,
            col3
        ) values ( 'ApInvoicesInterface.csv',
                   lc_clob );

        insert into xxcustom_temp (
            col1,
            col3
        ) values ( 'ApInvoiceLinesInterface.csv',
                   ln_clob );

        for l_file in (
            select
                col1 as file_name,
                col3
            from
                xxcustom_temp
        ) loop
            apex_zip.add_file(
                p_zipped_blob => lb_zip_file,
                p_file_name   => l_file.file_name,
                p_content     => apex_util.clob_to_blob(
                    p_clob    => l_file.col3,
                    p_charset => 'AL32UTF8'
                )
            );
        end loop;

        apex_zip.finish(p_zipped_blob => lb_zip_file);
        insert into xxcustom_temp ( col4 ) values ( lb_zip_file );


        -- lb_zippped := XX_ERP_INT_UTIL_PKG.zip_csv_file (lc_clob);
        lc_base64 := apex_web_service.blob2clobbase64(lb_zip_file);
        lb_base64 := apex_web_service.clobbase642blob(p_clob => lc_base64);
        insert into temp ( response ) values ( lc_base64 );

        xx_erp_int_util_pkg.migrate_to_cloud(
            p_url              => 'https://fa-etaj-dev18-saasfademo1.ds-fa.oraclepdemos.com/fscmRestApi/resources/latest/erpintegrations'
            ,
            p_operation_name   => 'importBulkData',
            p_doc_content      => lc_base64,
            p_doc_content_type => g_doc_content_type,
            p_file_name        => 'PozsupplierSites.zip',
            p_document_account => 'fin$/payables$/import$',
            p_job_name         => '/oracle/apps/ess/financials/payables/invoices/transactions,APXIIMPT',
            p_param_list       => 'Vision Operations BU1,Vision Operations Primary Led,OLA One Time Payment,#NULL,#NULL,#NULL,#NULL,#NULL,N,N,1'
            ,
            p_callback_url     => '#null',
            p_notify_code      => null,
            p_job_options      => null
        );

    end xxmig_ap_invoice;

end xxmig_generate_csv_file_pkg;
/


-- sqlcl_snapshot {"hash":"bbc7bf433a6149714dbf5cbebc42eb199945e518","type":"PACKAGE_BODY","name":"XXMIG_GENERATE_CSV_FILE_PKG","schemaName":"WKSP_EBS2CLOUD_MIGRATION","sxml":""}