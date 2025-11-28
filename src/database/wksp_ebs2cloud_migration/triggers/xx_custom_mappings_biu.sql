create or replace editionable trigger wksp_ebs2cloud_migration.xx_custom_mappings_biu before
    insert or update on wksp_ebs2cloud_migration.xx_custom_mappings
    for each row
begin
    if inserting then
        :new.creation_date := sysdate;
        :new.created_by := coalesce(
            sys_context('APEX$SESSION', 'APP_USER'),
            user
        );
    end if;

    :new.last_updation_date := sysdate;
    :new.updated_by := coalesce(
        sys_context('APEX$SESSION', 'APP_USER'),
        user
    );
end xx_custom_mappings_biu;
/

alter trigger wksp_ebs2cloud_migration.xx_custom_mappings_biu enable;


-- sqlcl_snapshot {"hash":"82df2d90a9e8637d9214777232fd569be1416cf9","type":"TRIGGER","name":"XX_CUSTOM_MAPPINGS_BIU","schemaName":"WKSP_EBS2CLOUD_MIGRATION","sxml":""}