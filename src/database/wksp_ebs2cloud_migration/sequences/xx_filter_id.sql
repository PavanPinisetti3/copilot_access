create sequence wksp_ebs2cloud_migration.xx_filter_id minvalue 1 maxvalue 9999999999999999999999999999 increment by 1 /* start with n */
cache 20 noorder nocycle nokeep noscale global;


-- sqlcl_snapshot {"hash":"83167dd3a9b06f97e99aaa299bb5da8ee03f7b3f","type":"SEQUENCE","name":"XX_FILTER_ID","schemaName":"WKSP_EBS2CLOUD_MIGRATION","sxml":"\n  <SEQUENCE xmlns=\"http://xmlns.oracle.com/ku\" version=\"1.0\">\n   <SCHEMA>WKSP_EBS2CLOUD_MIGRATION</SCHEMA>\n   <NAME>XX_FILTER_ID</NAME>\n   \n   <INCREMENT>1</INCREMENT>\n   <MINVALUE>1</MINVALUE>\n   <MAXVALUE>9999999999999999999999999999</MAXVALUE>\n   <CACHE>20</CACHE>\n   <SCALE>NOSCALE</SCALE>\n</SEQUENCE>"}