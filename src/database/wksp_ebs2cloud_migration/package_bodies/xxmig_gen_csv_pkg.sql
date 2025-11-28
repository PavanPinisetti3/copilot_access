create or replace package body wksp_ebs2cloud_migration.xxmig_gen_csv_pkg as

/*-----------------------------------------------------------------------------------------------------------------------------------|
  Procedure : xx_create_supplier                                                                                                     |
  usage     : This procedure is used to create supplier, supplier address, supplier site, supplier site assignment, supplier contact |
              using rest api                                                                                                         |
------------------------------------------------------------------------------------------------------------------------------------- */

    procedure xx_create_supplier (
        p_temp_name in varchar2
    ) as

        l_clob    clob;
        l_zippped blob;
        l_base64  clob;

/*------------------------------------------------------------------------------------------------|
| Procedure :      calling the xxmig_supplier which creates a supplier in fusion using the        |
|                   data in the custom  stagging table in apex                                    |
|                                                                                                 |
--------------------------------------------------------------------------------------------------*/

        procedure xxmig_supplier (
            p_temp_name in varchar2
        ) as
            l_clob    clob;
            l_zippped blob;
            l_base64  clob;
        begin
            for i in (
                select
                    'CREATE'
                    || ','
                    || 'J1 sample10'
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
                    || 'Batch_SO12793'
                    || ','
                    || null
                    || ','
                    || null
                    || ','
                    || null
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
                l_clob := l_clob
                          || to_clob(i.csv_row)
                          || chr(10);
            end loop;

            -- insert into temp (Response) values (l_clob);
            l_zippped := xx_erp_int_util_pkg.zip_csv_file(l_clob);
            -- l_base64  := XX_ERP_INT_UTIL_PKG.blob_to_base64 (l_zippped);
            l_base64 := apex_web_service.blob2clobbase64(l_zippped);
            insert into temp ( response ) values ( l_base64 );

            xx_erp_int_util_pkg.migrate_to_cloud(
                p_url              => 'https://fa-etaj-dev18-saasfademo1.ds-fa.oraclepdemos.com/fscmRestApi/resources/latest/erpintegrations'
                ,
                p_operation_name   => 'importBulkData',
                p_doc_content      => l_base64,
                p_doc_content_type => 'zip',
                p_file_name        => 'PozSuppliersInt41123.zip',
                p_document_account => 'prc$/supplier$/import$',
                p_job_name         => '/oracle/apps/ess/prc/poz/supplierImport,ImportSuppliers',
                p_param_list       => 'NEW,Y,Batch_SO12793',
                p_callback_url     => '#null',
                p_notify_code      => null,
                p_job_options      => null
            );

        end xxmig_supplier;

/*------------------------------------------------------------------------------------------------|
| Procedure :      calling the xxmig_supplier_address which creates a supplier address            |
|                   in fusion using the supplier data created by xxmig_supplier procedure         |
|                                                                                                 |
--------------------------------------------------------------------------------------------------*/

        procedure xxmig_supplier_address (
            p_temp_name in varchar2
        ) as
        begin
            for i in (
                select
                    'CREATE'
                    || ','
                    || 'J1 sample10'
                    || ','
                    || 'Winfo-Test2'
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
                l_clob := l_clob
                          || to_clob(i.csv_row)
                          || chr(10);
            end loop;

            -- insert into temp (Response) values (l_clob);
            l_zippped := xx_erp_int_util_pkg.zip_csv_file(l_clob);
            -- l_base64  := XX_ERP_INT_UTIL_PKG.blob_to_base64 (l_zippped);
            l_base64 := apex_web_service.blob2clobbase64(l_zippped);
            insert into temp ( response ) values ( l_base64 );

            xx_erp_int_util_pkg.migrate_to_cloud(
                p_url              => 'https://fa-etaj-dev18-saasfademo1.ds-fa.oraclepdemos.com/fscmRestApi/resources/latest/erpintegrations'
                ,
                p_operation_name   => 'importBulkData',
                p_doc_content      => l_base64,
                p_doc_content_type => 'zip',
                p_file_name        => 'PozSuppliersInt41190.zip',
                p_document_account => 'prc$/supplier$/import$',
                p_job_name         => '/oracle/apps/ess/prc/poz/supplierImport,ImportSupplierAddresses',
                p_param_list       => 'NEW,Y,Batch_SA1122',
                p_callback_url     => '#null',
                p_notify_code      => null,
                p_job_options      => null
            );

        end xxmig_supplier_address;

/*-----------------------------------------------------------------------------------------------------|
| Procedure :      calling xxmig_supplier_site creates a supplier site in fusion using the             |
|                  supplier,supplier address data created by xxmig_supplier and xxmig_supplier_address |
|                                                                                                      |
-------------------------------------------------------------------------------------------------------*/

        procedure xxmig_supplier_site (
            p_temp_name in varchar2
        ) as
            l_zip_file blob;
            l_clob     clob;
            ln_clob    clob;
            lc_blob    blob;
            lc_base64  blob;
        begin
            for i in (
                select
                    'CREATE'
                    || ','
                    || 'J1 sample10'
                    || ','
                    || procurement_business_unit_name
                    || ','
                    || party_site_name
                    || ','
                    || vendor_site_code
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
                    || 'Batch_SSO50228'
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
                where
                    rownum <= 1
            ) loop
                l_clob := l_clob
                          || to_clob(i.csv_row)
                          || chr(10);
            end loop;

            for i in (
                select
                    chr(10)
                    || chr(13) as csv_row
                from
                    xxmig_supplier_site_stg
                where
                    rownum <= 1
            ) loop
                ln_clob := ln_clob || to_clob(i.csv_row);
            end loop;

            delete from xxcustom_temp;

            insert into xxcustom_temp (
                col1,
                col3
            ) values ( 'PozSupplierSitesInt.csv',
                       l_clob );

            insert into xxcustom_temp (
                col1,
                col3
            ) values ( 'PozSupThirdPartyInt.csv',
                       ln_clob );

            for l_file in (
                select
                    col1 as file_name,
                    col3
                from
                    xxcustom_temp
            ) loop
                apex_zip.add_file(
                    p_zipped_blob => l_zip_file,
                    p_file_name   => l_file.file_name,
                    p_content     => apex_util.clob_to_blob(
                        p_clob    => l_file.col3,
                        p_charset => 'AL32UTF8'
                    )
                );
            end loop;

            apex_zip.finish(p_zipped_blob => l_zip_file);
            insert into xxcustom_temp ( col4 ) values ( l_zip_file );

            l_base64 := apex_web_service.blob2clobbase64(l_zip_file);
            lc_base64 := apex_web_service.clobbase642blob(p_clob => l_base64);
            insert into temp ( response ) values ( l_base64 );

            xx_erp_int_util_pkg.migrate_to_cloud(
                p_url              => 'https://fa-etaj-dev18-saasfademo1.ds-fa.oraclepdemos.com/fscmRestApi/resources/latest/erpintegrations'
                ,
                p_operation_name   => 'importBulkData',
                p_doc_content      => l_base64,
                p_doc_content_type => 'zip',
                p_file_name        => 'PozsupplierSites.zip',
                p_document_account => 'prc$/supplier$/import$',
                p_job_name         => '/oracle/apps/ess/prc/poz/supplierImport,ImportSupplierSites',
                p_param_list       => 'NEW,Y,Batch_SSO50228',
                p_callback_url     => '#null',
                p_notify_code      => null,
                p_job_options      => null
            );

        end xxmig_supplier_site;

/*-----------------------------------------------------------------------------------------------------------------------|
| Procedure :      calling xxmig_supplier_site_assign creates a supplier site assignment in fusion using the             |
|                  supplier,supplier address,supplier site data created by xxmig_supplier and xxmig_supplier_address     |
|                                                                                                                        |
------------------------------------------------------------------------------------------------------------------------*/

        procedure xxmig_supplier_site_assign (
            p_temp_name in varchar2
        ) as
        begin
            for i in (
                select
                    'CREATE'
                    || ','
                    || 'J1 sample10'
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
                    || 'Batch_SSI031276'
                    || ','
                    || 'END' as csv_row
                from
                    xxmig_sup_site_assign_stg
                where
                    rownum <= 1
            ) loop
                l_clob := l_clob
                          || to_clob(i.csv_row)
                          || chr(10);
            end loop;

            -- insert into temp (Response) values (l_clob);
            l_zippped := xx_erp_int_util_pkg.zip_csv_file(l_clob);
            -- l_base64  := XX_ERP_INT_UTIL_PKG.blob_to_base64 (l_zippped);
            l_base64 := apex_web_service.blob2clobbase64(l_zippped);
            insert into temp ( response ) values ( l_base64 );

            xx_erp_int_util_pkg.migrate_to_cloud(
                p_url              => 'https://fa-etaj-dev18-saasfademo1.ds-fa.oraclepdemos.com/fscmRestApi/resources/latest/erpintegrations'
                ,
                p_operation_name   => 'importBulkData',
                p_doc_content      => l_base64,
                p_doc_content_type => 'zip',
                p_file_name        => 'PozSuppliersInt41123.zip',
                p_document_account => 'prc$/supplier$/import$',
                p_job_name         => '/oracle/apps/ess/prc/poz/supplierImport,ImportSupplierSiteAssignments',
                p_param_list       => 'NEW,Y,Batch_SSI031276',
                p_callback_url     => '#null',
                p_notify_code      => null,
                p_job_options      => null
            );

        end xxmig_supplier_site_assign;


/*-----------------------------------------------------------------------------------------------------------------------|
| Procedure :      calling xxmig_supplier_contact creates a supplier contact in fusion using the                         |
|                  supplier data created by xxmig_supplier and xxmig_supplier_address                                    |
|                                                                                                                        |
------------------------------------------------------------------------------------------------------------------------*/

        procedure xxmig_supplier_contact (
            p_temp_name in varchar2
        ) as
            l_zip_file blob;
            l_clob     clob;
            ln_clob    clob;
            lc_blob    blob;
        begin
            for i in (
                select
                    'CREATE'
                    || ','
                    || 'J1 supp dup'
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
                l_clob := l_clob
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
                       l_clob );

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
                    p_zipped_blob => l_zip_file,
                    p_file_name   => l_file.file_name,
                    p_content     => apex_util.clob_to_blob(
                        p_clob    => l_file.col3,
                        p_charset => 'AL32UTF8'
                    )
                );
            end loop;

            apex_zip.finish(p_zipped_blob => l_zip_file);
            insert into xxcustom_temp ( col4 ) values ( l_zip_file );

            l_base64 := apex_web_service.blob2clobbase64(l_zip_file);
            insert into temp ( response ) values ( l_base64 );

            xx_erp_int_util_pkg.migrate_to_cloud(
                p_url              => 'https://fa-etaj-dev18-saasfademo1.ds-fa.oraclepdemos.com/fscmRestApi/resources/latest/erpintegrations'
                ,
                p_operation_name   => 'importBulkData',
                p_doc_content      => l_base64,
                p_doc_content_type => 'zip',
                p_file_name        => 'PozsupplierSites.zip',
                p_document_account => 'prc$/supplier$/import$',
                p_job_name         => '/oracle/apps/ess/prc/poz/supplierImport,ImportSupplierContacts',
                p_param_list       => 'NEW,Y,Batch_SL50228',
                p_callback_url     => '#null',
                p_notify_code      => null,
                p_job_options      => null
            );

        end xxmig_supplier_contact;

    begin
/*---------------calling the xxmig_supplier which creates a supplier -------------------------------*/

        xxmig_supplier(p_temp_name);

/*---------------calling the xxmig_supplier_address which creates a supplier address----------------*/

        xxmig_supplier_address(p_temp_name);

/*------------------calling xxmig_supplier_site creates a supplier site -----------------------------*/

        xxmig_supplier_site(p_temp_name);

/*------------------calling xxmig_supplier_site_assign creates a supplier site assignment-------------*/

        xxmig_supplier_site_assign(p_temp_name);

/*------------------calling xxmig_supplier_contact creates a supplier contact--------------------------*/

        xxmig_supplier_contact(p_temp_name);
    end xx_create_supplier;

end xxmig_gen_csv_pkg;
/


-- sqlcl_snapshot {"hash":"d73d64ec8c3e127b696fbffc8f2a6aaf7f81745f","type":"PACKAGE_BODY","name":"XXMIG_GEN_CSV_PKG","schemaName":"WKSP_EBS2CLOUD_MIGRATION","sxml":""}