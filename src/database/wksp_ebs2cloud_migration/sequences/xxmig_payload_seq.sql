create sequence wksp_ebs2cloud_migration.xxmig_payload_seq minvalue 1 maxvalue 9999999999999999999999999999 increment by 1 /* start with n */
cache 20 noorder nocycle nokeep noscale global;


-- sqlcl_snapshot {"hash":"fa5c457f9907f1c2271d905b113d44f8ec534011","type":"SEQUENCE","name":"XXMIG_PAYLOAD_SEQ","schemaName":"WKSP_EBS2CLOUD_MIGRATION","sxml":"\n  <SEQUENCE xmlns=\"http://xmlns.oracle.com/ku\" version=\"1.0\">\n   <SCHEMA>WKSP_EBS2CLOUD_MIGRATION</SCHEMA>\n   <NAME>XXMIG_PAYLOAD_SEQ</NAME>\n   \n   <INCREMENT>1</INCREMENT>\n   <MINVALUE>1</MINVALUE>\n   <MAXVALUE>9999999999999999999999999999</MAXVALUE>\n   <CACHE>20</CACHE>\n   <SCALE>NOSCALE</SCALE>\n</SEQUENCE>"}