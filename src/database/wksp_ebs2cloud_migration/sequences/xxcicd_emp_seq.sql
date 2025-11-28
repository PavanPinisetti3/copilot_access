create sequence wksp_ebs2cloud_migration.xxcicd_emp_seq minvalue 1 maxvalue 999999 increment by 1 /* start with n */ cache 20 noorder
nocycle nokeep noscale global;


-- sqlcl_snapshot {"hash":"b8c91866d83f0d370ff0552772de2753980ba14a","type":"SEQUENCE","name":"XXCICD_EMP_SEQ","schemaName":"WKSP_EBS2CLOUD_MIGRATION","sxml":"\n  <SEQUENCE xmlns=\"http://xmlns.oracle.com/ku\" version=\"1.0\">\n   <SCHEMA>WKSP_EBS2CLOUD_MIGRATION</SCHEMA>\n   <NAME>XXCICD_EMP_SEQ</NAME>\n   \n   <INCREMENT>1</INCREMENT>\n   <MINVALUE>1</MINVALUE>\n   <MAXVALUE>999999</MAXVALUE>\n   <CACHE>20</CACHE>\n   <SCALE>NOSCALE</SCALE>\n</SEQUENCE>"}