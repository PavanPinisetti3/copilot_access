create index wksp_ebs2cloud_migration.xxcicd_emp_idx on
    wksp_ebs2cloud_migration.xxcicd_emp (
        id
    );


-- sqlcl_snapshot {"hash":"513945024b169294448baa943277aaa18070fc88","type":"INDEX","name":"XXCICD_EMP_IDX","schemaName":"WKSP_EBS2CLOUD_MIGRATION","sxml":"\n  <INDEX xmlns=\"http://xmlns.oracle.com/ku\" version=\"1.0\">\n   <SCHEMA>WKSP_EBS2CLOUD_MIGRATION</SCHEMA>\n   <NAME>XXCICD_EMP_IDX</NAME>\n   <TABLE_INDEX>\n      <ON_TABLE>\n         <SCHEMA>WKSP_EBS2CLOUD_MIGRATION</SCHEMA>\n         <NAME>XXCICD_EMP</NAME>\n      </ON_TABLE>\n      <COL_LIST>\n         <COL_LIST_ITEM>\n            <NAME>ID</NAME>\n         </COL_LIST_ITEM>\n      </COL_LIST>\n   </TABLE_INDEX>\n</INDEX>"}