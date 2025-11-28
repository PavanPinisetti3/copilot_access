create sequence wksp_ebs2cloud_migration.csv_files_seq minvalue 1 maxvalue 9999999999999999999999999999 increment by 1 /* start with n */
cache 20 noorder nocycle nokeep noscale global;


-- sqlcl_snapshot {"hash":"30a76c625167ee2bcec9ed25e79e3f2786f7bade","type":"SEQUENCE","name":"CSV_FILES_SEQ","schemaName":"WKSP_EBS2CLOUD_MIGRATION","sxml":"\n  <SEQUENCE xmlns=\"http://xmlns.oracle.com/ku\" version=\"1.0\">\n   <SCHEMA>WKSP_EBS2CLOUD_MIGRATION</SCHEMA>\n   <NAME>CSV_FILES_SEQ</NAME>\n   \n   <INCREMENT>1</INCREMENT>\n   <MINVALUE>1</MINVALUE>\n   <MAXVALUE>9999999999999999999999999999</MAXVALUE>\n   <CACHE>20</CACHE>\n   <SCALE>NOSCALE</SCALE>\n</SEQUENCE>"}