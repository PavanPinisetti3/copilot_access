create global temporary table wksp_ebs2cloud_migration.tmp_objects (
    object_name varchar2(200 byte)
) on commit preserve rows;


-- sqlcl_snapshot {"hash":"a8306fdf9eceb53f25141b8b3783db45cf622cda","type":"TABLE","name":"TMP_OBJECTS","schemaName":"WKSP_EBS2CLOUD_MIGRATION","sxml":"\n  <TABLE xmlns=\"http://xmlns.oracle.com/ku\" version=\"1.0\">\n   <GLOBAL_TEMPORARY></GLOBAL_TEMPORARY>\n   <SCHEMA>WKSP_EBS2CLOUD_MIGRATION</SCHEMA>\n   <NAME>TMP_OBJECTS</NAME>\n   <RELATIONAL_TABLE>\n      <COL_LIST>\n         <COL_LIST_ITEM>\n            <NAME>OBJECT_NAME</NAME>\n            <DATATYPE>VARCHAR2</DATATYPE>\n            <LENGTH>200</LENGTH>\n            <COLLATE_NAME>USING_NLS_COMP</COLLATE_NAME>\n         </COL_LIST_ITEM>\n      </COL_LIST>\n      <DEFAULT_COLLATION>USING_NLS_COMP</DEFAULT_COLLATION>\n      <ON_COMMIT>PRESERVE</ON_COMMIT>\n   </RELATIONAL_TABLE>\n</TABLE>"}