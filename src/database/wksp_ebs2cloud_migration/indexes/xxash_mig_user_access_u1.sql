create unique index wksp_ebs2cloud_migration.xxash_mig_user_access_u1 on
    wksp_ebs2cloud_migration.xxash_mig_user_access (
        user_id,
        env_name,
        module_name,
        role_name
    );


-- sqlcl_snapshot {"hash":"2f161cf3194dbc49e8b9bbb46c8f6c84d18ccf38","type":"INDEX","name":"XXASH_MIG_USER_ACCESS_U1","schemaName":"WKSP_EBS2CLOUD_MIGRATION","sxml":"\n  <INDEX xmlns=\"http://xmlns.oracle.com/ku\" version=\"1.0\">\n   <UNIQUE></UNIQUE>\n   <SCHEMA>WKSP_EBS2CLOUD_MIGRATION</SCHEMA>\n   <NAME>XXASH_MIG_USER_ACCESS_U1</NAME>\n   <TABLE_INDEX>\n      <ON_TABLE>\n         <SCHEMA>WKSP_EBS2CLOUD_MIGRATION</SCHEMA>\n         <NAME>XXASH_MIG_USER_ACCESS</NAME>\n      </ON_TABLE>\n      <COL_LIST>\n         <COL_LIST_ITEM>\n            <NAME>USER_ID</NAME>\n         </COL_LIST_ITEM>\n         <COL_LIST_ITEM>\n            <NAME>ENV_NAME</NAME>\n         </COL_LIST_ITEM>\n         <COL_LIST_ITEM>\n            <NAME>MODULE_NAME</NAME>\n         </COL_LIST_ITEM>\n         <COL_LIST_ITEM>\n            <NAME>ROLE_NAME</NAME>\n         </COL_LIST_ITEM>\n      </COL_LIST>\n   </TABLE_INDEX>\n</INDEX>"}