create or replace procedure wksp_ebs2cloud_migration.xxcicd_get_emp_details_by_empno (
    p_empno in emp.empno%type
) as
    v_deptno        emp.deptno%type;
    l_error_message varchar2(4000);
begin
    select
        d.deptno
    into v_deptno
    from
             emp e
        join dept d on e.deptno = d.deptno
    where
        e.empno = p_empno;

exception
    when too_many_rows then
        l_error_message := 'Error: '
                           || sqlerrm
                           || ', please check the query: 
                         "select 
                             d.deptno
                            into
                             v_deptno
                            from emp e, dept d
                            where e.empno ='
                           || p_empno
                           || '"';
        insert into xxcicd_debug_err_messages (
            err_message_id,
            error_message_level,
            err_message_text,
            session_id,
            username,
            jira_number,
            jira_status,
            app_id,
            page_id,
            process_block_name
        ) values ( 1,
                   5,
                   l_error_message,
                   1234567890,
                   'test_user',
                   'JIRA-456',
                   'OPEN',
                   123,
                   10,
                   'fetch_emp_deptno_proc' );

      --Create Jira ticket logic can be added here

    when no_data_found then
        dbms_output.put_line('No employee found with EMPNO = ' || p_empno);
    when others then
        dbms_output.put_line('Unexpected error: ' || sqlerrm);
end xxcicd_get_emp_details_by_empno;
/


-- sqlcl_snapshot {"hash":"6811538fcaeceda20654c2a4ae90c2fbce2dc108","type":"PROCEDURE","name":"XXCICD_GET_EMP_DETAILS_BY_EMPNO","schemaName":"WKSP_EBS2CLOUD_MIGRATION","sxml":""}