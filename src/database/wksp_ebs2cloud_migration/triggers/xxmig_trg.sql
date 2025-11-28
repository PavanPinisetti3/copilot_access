create or replace editionable trigger wksp_ebs2cloud_migration.xxmig_trg after
    insert or update or delete on wksp_ebs2cloud_migration.user_management
    for each row
declare
-- PRAGMA AUTONOMOUS_TRANSACTION;
    lc_role    varchar2(100);
    v_app_user varchar2(100);
    lc_changes varchar2(4000);
begin
    if inserting then
        insert into xxmig_audit_history (
            users,
            action,
            description,
            dates
        ) values ( sys_context('APEX$SESSION', 'APP_USER'),
                   'Admin',
                   'Created user ('
                   || :new.user_name
                   || ')',
                   sysdate );

    elsif updating then
        lc_changes := '';  -- Initialize changes log

            -- Check each field for changes and log them
        if nvl(:old.first_name,
               ' ') <> :new.first_name then
            lc_changes := lc_changes
                          || ' FIRST_NAME changed from '
                          || :old.first_name
                          || ' to '
                          || :new.first_name
                          || ';';

        end if;

        if nvl(:old.last_name,
               ' ') <> :new.last_name then
            lc_changes := lc_changes
                          || ' LAST_NAME changed from '
                          || :old.last_name
                          || ' to '
                          || :new.last_name
                          || ';';
        end if;

        if nvl(:old.user_name,
               ' ') <> :new.user_name then
            lc_changes := lc_changes
                          || ' USER_NAME changed from '
                          || :old.user_name
                          || ' to '
                          || :new.user_name
                          || ';';
        end if;

        if nvl(:old.password,
               ' ') <> :new.password then
            lc_changes := lc_changes || ' PASSWORD updated;';  -- Masked for security
        end if;

        if nvl(:old.user_role,
               ' ') <> :new.user_role then
            lc_changes := lc_changes
                          || ' USER_ROLE changed from '
                          || :old.user_role
                          || ' to '
                          || :new.user_role
                          || ';';
        end if;

        if nvl(:old.module_access,
               ' ') <> :new.module_access then
            lc_changes := lc_changes
                          || ' MODULE_ACCESS changed from '
                          || :old.module_access
                          || ' to '
                          || :new.module_access
                          || ';';
        end if;

        if nvl(:old.project,
               ' ') <> :new.project then
            lc_changes := lc_changes
                          || ' PROJECT changed from '
                          || :old.project
                          || ' to '
                          || :new.project
                          || ';';
        end if;

        if nvl(:old.environment_type,
               ' ') <> :new.environment_type then
            lc_changes := lc_changes
                          || ' ENVIRONMENT_TYPE changed from '
                          || :old.environment_type
                          || ' to '
                          || :new.environment_type
                          || ';';
        end if;

            -- Insert into audit history if there were changes
        if lc_changes is not null then
            insert into xxmig_audit_history (
                users,
                action,
                description,
                dates
            ) values ( sys_context('APEX$SESSION', 'APP_USER'),
                       'Admin',
                       'Updated user ('
                       || :new.user_name
                       || '): '
                       || lc_changes,
                       sysdate );

        end if;

    elsif deleting then
        insert into xxmig_audit_history (
            users,
            action,
            description,
            dates
        ) values ( sys_context('APEX$SESSION', 'APP_USER'),
                   'Admin',
                   'Deleted user ('
                   || :old.user_name
                   || ')',
                   sysdate );

    end if;
    -- ELSE
    --     -- Raise an exception if the user is not an Admin Consultant
    --     RAISE_APPLICATION_ERROR(-20001, 'You do not have permission to modify this data.');
    -- END IF;
end xxmig_trg;
/

alter trigger wksp_ebs2cloud_migration.xxmig_trg enable;


-- sqlcl_snapshot {"hash":"03565e90d9b4b9adecc2eefc625f9004b44ec7c3","type":"TRIGGER","name":"XXMIG_TRG","schemaName":"WKSP_EBS2CLOUD_MIGRATION","sxml":""}