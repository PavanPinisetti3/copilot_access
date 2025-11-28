
--

DECLARE
  l_roles     OWA.VC_ARR;
  l_modules   OWA.VC_ARR;
  l_patterns  OWA.VC_ARR;

BEGIN
  ORDS.ENABLE_SCHEMA(
      p_enabled             => TRUE,
      p_schema              => 'WKSP_EBS2CLOUD_MIGRATION',
      p_url_mapping_type    => 'BASE_PATH',
      p_url_mapping_pattern => 'wksp_ebs2cloud_migration',
      p_auto_rest_auth      => FALSE);
    
  ORDS.DEFINE_MODULE(
      p_module_name    => 'oracle.example.hr',
      p_base_path      => '/hr/',
      p_items_per_page => 25,
      p_status         => 'PUBLISHED',
      p_comments       => NULL);

  ORDS.DEFINE_TEMPLATE(
      p_module_name    => 'oracle.example.hr',
      p_pattern        => 'empsec/:empname',
      p_priority       => 0,
      p_etag_type      => 'HASH',
      p_etag_query     => NULL,
      p_comments       => NULL);

  ORDS.DEFINE_HANDLER(
      p_module_name    => 'oracle.example.hr',
      p_pattern        => 'empsec/:empname',
      p_method         => 'GET',
      p_source_type    => 'json/collection',
      p_items_per_page => 25,
      p_mimes_allowed  => NULL,
      p_comments       => NULL,
      p_source         => 
'select empno, ename, deptno, job from emp 
	where ((select job from emp where ename = :empname) IN (''PRESIDENT'', ''MANAGER'')) 
    OR  
    (deptno = (select deptno from emp where ename = :empname)) 
order by deptno, ename
');

  ORDS.DEFINE_TEMPLATE(
      p_module_name    => 'oracle.example.hr',
      p_pattern        => 'empsecformat/:empname',
      p_priority       => 0,
      p_etag_type      => 'HASH',
      p_etag_query     => NULL,
      p_comments       => NULL);

  ORDS.DEFINE_HANDLER(
      p_module_name    => 'oracle.example.hr',
      p_pattern        => 'empsecformat/:empname',
      p_method         => 'GET',
      p_source_type    => 'plsql/block',
      p_items_per_page => 25,
      p_mimes_allowed  => NULL,
      p_comments       => NULL,
      p_source         => 
'DECLARE
  prevdeptno     number;
  total_rows     number;
  deptloc        varchar2(20);
  deptname       varchar2(20);
  
  CURSOR         getemps is select * from emp 
                             start with ename = :empname
                           connect by prior empno = mgr
                             order siblings by deptno, ename;
BEGIN
  sys.htp.htmlopen;
  sys.htp.headopen;
  sys.htp.title(''Hierarchical Department Report for Employee ''||apex_escape.html(:empname));
  sys.htp.headclose;
  sys.htp.bodyopen;
 
  for l_employee in getemps 
  loop
      if l_employee.deptno != prevdeptno or prevdeptno is null then
          select dname, loc 
            into deptname, deptloc 
            from dept 
           where deptno = l_employee.deptno;
           
          if prevdeptno is not null then
              sys.htp.print(''</ul>'');
          end if;

          sys.htp.print(''Department '' || apex_escape.html(deptname) || '' located in '' || apex_escape.html(deptloc) || ''<p/>'');' || '
          sys.htp.print(''<ul>'');
      end if;

      sys.htp.print(''<li>'' || apex_escape.html(l_employee.ename) || '', ''  || apex_escape.html(l_employee.empno) || '', '' || 
                        apex_escape.html(l_employee.job) || '', '' || apex_escape.html(l_employee.sal) || ''</li>'');

      prevdeptno := l_employee.deptno;
      total_rows := getemps%ROWCOUNT;
      
  end loop;

  if total_rows > 0 then
      sys.htp.print(''</ul>'');
  end if;

  sys.htp.bodyclose;
  sys.htp.htmlclose;
END;');

  ORDS.DEFINE_TEMPLATE(
      p_module_name    => 'oracle.example.hr',
      p_pattern        => 'employees/',
      p_priority       => 0,
      p_etag_type      => 'HASH',
      p_etag_query     => NULL,
      p_comments       => NULL);

  ORDS.DEFINE_HANDLER(
      p_module_name    => 'oracle.example.hr',
      p_pattern        => 'employees/',
      p_method         => 'GET',
      p_source_type    => 'json/collection',
      p_items_per_page => 25,
      p_mimes_allowed  => NULL,
      p_comments       => NULL,
      p_source         => 
'select empno "$uri", rn, empno, ename, job, hiredate, mgr, sal, comm, deptno
  from (
       select emp.*
            , row_number() over (order by empno) rn
         from emp
       ) tmp');

  ORDS.DEFINE_TEMPLATE(
      p_module_name    => 'oracle.example.hr',
      p_pattern        => 'version/',
      p_priority       => 0,
      p_etag_type      => 'HASH',
      p_etag_query     => NULL,
      p_comments       => NULL);

  ORDS.DEFINE_HANDLER(
      p_module_name    => 'oracle.example.hr',
      p_pattern        => 'version/',
      p_method         => 'GET',
      p_source_type    => 'plsql/block',
      p_items_per_page => 25,
      p_mimes_allowed  => NULL,
      p_comments       => NULL,
      p_source         => 
'begin 
 sys.htp.p(''{"version": "23.1"}'');
end;');

  ORDS.DEFINE_TEMPLATE(
      p_module_name    => 'oracle.example.hr',
      p_pattern        => 'employees/:id',
      p_priority       => 0,
      p_etag_type      => 'HASH',
      p_etag_query     => NULL,
      p_comments       => NULL);

  ORDS.DEFINE_HANDLER(
      p_module_name    => 'oracle.example.hr',
      p_pattern        => 'employees/:id',
      p_method         => 'GET',
      p_source_type    => 'json/item',
      p_items_per_page => 25,
      p_mimes_allowed  => NULL,
      p_comments       => NULL,
      p_source         => 
'select * from emp
where empno = :id');

  ORDS.DEFINE_HANDLER(
      p_module_name    => 'oracle.example.hr',
      p_pattern        => 'employees/:id',
      p_method         => 'PUT',
      p_source_type    => 'plsql/block',
      p_items_per_page => 25,
      p_mimes_allowed  => NULL,
      p_comments       => NULL,
      p_source         => 
'begin
    update emp set ename = :ename, job = :job, hiredate = :hiredate, mgr = :mgr, sal = :sal, comm = :comm, deptno = :deptno
    where empno = :id;
    :status := 200;
    :location := :id;
exception
    when others then
        :status := 400;
        sys.htp.p( sys.htf.escape_sc(sqlerrm) );
end;');

  ORDS.DEFINE_PARAMETER(
      p_module_name        => 'oracle.example.hr',
      p_pattern            => 'employees/:id',
      p_method             => 'PUT',
      p_name               => 'X-APEX-FORWARD',
      p_bind_variable_name => 'location',
      p_source_type        => 'HEADER',
      p_param_type         => 'STRING',
      p_access_method      => 'OUT',
      p_comments           => NULL);

  ORDS.DEFINE_PARAMETER(
      p_module_name        => 'oracle.example.hr',
      p_pattern            => 'employees/:id',
      p_method             => 'PUT',
      p_name               => 'ID',
      p_bind_variable_name => 'id',
      p_source_type        => 'HEADER',
      p_param_type         => 'STRING',
      p_access_method      => 'IN',
      p_comments           => NULL);

  ORDS.DEFINE_PARAMETER(
      p_module_name        => 'oracle.example.hr',
      p_pattern            => 'employees/:id',
      p_method             => 'PUT',
      p_name               => 'X-APEX-STATUS-CODE',
      p_bind_variable_name => 'status',
      p_source_type        => 'HEADER',
      p_param_type         => 'INT',
      p_access_method      => 'OUT',
      p_comments           => NULL);

  ORDS.DEFINE_TEMPLATE(
      p_module_name    => 'oracle.example.hr',
      p_pattern        => 'empinfo/',
      p_priority       => 0,
      p_etag_type      => 'HASH',
      p_etag_query     => NULL,
      p_comments       => NULL);

  ORDS.DEFINE_HANDLER(
      p_module_name    => 'oracle.example.hr',
      p_pattern        => 'empinfo/',
      p_method         => 'GET',
      p_source_type    => 'json/collection',
      p_items_per_page => 25,
      p_mimes_allowed  => NULL,
      p_comments       => NULL,
      p_source         => 
'select * from emp');

  ORDS.DEFINE_TEMPLATE(
      p_module_name    => 'oracle.example.hr',
      p_pattern        => 'emp_post_example/',
      p_priority       => 0,
      p_etag_type      => 'HASH',
      p_etag_query     => NULL,
      p_comments       => NULL);

  ORDS.DEFINE_HANDLER(
      p_module_name    => 'oracle.example.hr',
      p_pattern        => 'emp_post_example/',
      p_method         => 'POST',
      p_source_type    => 'plsql/block',
      p_mimes_allowed  => NULL,
      p_comments       => NULL,
      p_source         => 
'DECLARE
 new_id integer;
 current_date date;
BEGIN
    select sysdate into current_date from dual;
    insert into emp 
     (empno, ename, job, mgr, hiredate, sal, comm, deptno)
    VALUES
     (null, :ename, :ejob, :mgr, current_date, :sal, :comm, :deptno)
    returning empno into new_id;
    :status_code := 201;
    :forward_location := ''../employees/''||new_id;
exception
  WHEN VALUE_ERROR
        THEN
            :errmsg := ''SALARY must be a number.'';
            :status_code := 400;
 when others then 
	:status_code := 400;
	:errmsg := sqlerrm;
end;');

  ORDS.DEFINE_PARAMETER(
      p_module_name        => 'oracle.example.hr',
      p_pattern            => 'emp_post_example/',
      p_method             => 'POST',
      p_name               => 'ErrorMessage',
      p_bind_variable_name => 'errmsg',
      p_source_type        => 'RESPONSE',
      p_param_type         => 'STRING',
      p_access_method      => 'OUT',
      p_comments           => NULL);

  ORDS.DEFINE_PARAMETER(
      p_module_name        => 'oracle.example.hr',
      p_pattern            => 'emp_post_example/',
      p_method             => 'POST',
      p_name               => 'EmpName',
      p_bind_variable_name => 'ename',
      p_source_type        => 'HEADER',
      p_param_type         => 'STRING',
      p_access_method      => 'IN',
      p_comments           => NULL);

  ORDS.DEFINE_PARAMETER(
      p_module_name        => 'oracle.example.hr',
      p_pattern            => 'emp_post_example/',
      p_method             => 'POST',
      p_name               => 'EmpJob',
      p_bind_variable_name => 'ejob',
      p_source_type        => 'HEADER',
      p_param_type         => 'STRING',
      p_access_method      => 'IN',
      p_comments           => NULL);

  ORDS.DEFINE_PARAMETER(
      p_module_name        => 'oracle.example.hr',
      p_pattern            => 'emp_post_example/',
      p_method             => 'POST',
      p_name               => 'EmpMgr',
      p_bind_variable_name => 'mgr',
      p_source_type        => 'HEADER',
      p_param_type         => 'INT',
      p_access_method      => 'IN',
      p_comments           => NULL);

  ORDS.DEFINE_PARAMETER(
      p_module_name        => 'oracle.example.hr',
      p_pattern            => 'emp_post_example/',
      p_method             => 'POST',
      p_name               => 'EmpSal',
      p_bind_variable_name => 'sal',
      p_source_type        => 'HEADER',
      p_param_type         => 'INT',
      p_access_method      => 'IN',
      p_comments           => NULL);

  ORDS.DEFINE_PARAMETER(
      p_module_name        => 'oracle.example.hr',
      p_pattern            => 'emp_post_example/',
      p_method             => 'POST',
      p_name               => 'EmpComm',
      p_bind_variable_name => 'comm',
      p_source_type        => 'HEADER',
      p_param_type         => 'INT',
      p_access_method      => 'IN',
      p_comments           => NULL);

  ORDS.DEFINE_PARAMETER(
      p_module_name        => 'oracle.example.hr',
      p_pattern            => 'emp_post_example/',
      p_method             => 'POST',
      p_name               => 'EmpDept',
      p_bind_variable_name => 'deptno',
      p_source_type        => 'HEADER',
      p_param_type         => 'INT',
      p_access_method      => 'IN',
      p_comments           => NULL);

  ORDS.DEFINE_MODULE(
      p_module_name    => 'ERPIntegration',
      p_base_path      => '/create/',
      p_items_per_page => 25,
      p_status         => 'PUBLISHED',
      p_comments       => NULL);

  ORDS.DEFINE_TEMPLATE(
      p_module_name    => 'ERPIntegration',
      p_pattern        => 'deptno/',
      p_priority       => 0,
      p_etag_type      => 'HASH',
      p_etag_query     => NULL,
      p_comments       => NULL);

  ORDS.DEFINE_HANDLER(
      p_module_name    => 'ERPIntegration',
      p_pattern        => 'deptno/',
      p_method         => 'POST',
      p_source_type    => 'plsql/block',
      p_mimes_allowed  => NULL,
      p_comments       => NULL,
      p_source         => 
'begin
INSERT INTO DEPT VALUES (:deptno,:dname,:loc);
COMMIT;
end;

');

  ORDS.DEFINE_MODULE(
      p_module_name    => 'UPDATE',
      p_base_path      => '/update/',
      p_items_per_page => 25,
      p_status         => 'PUBLISHED',
      p_comments       => NULL);

  ORDS.DEFINE_TEMPLATE(
      p_module_name    => 'UPDATE',
      p_pattern        => ':deptno/',
      p_priority       => 0,
      p_etag_type      => 'HASH',
      p_etag_query     => NULL,
      p_comments       => NULL);

  ORDS.DEFINE_HANDLER(
      p_module_name    => 'UPDATE',
      p_pattern        => ':deptno/',
      p_method         => 'PUT',
      p_source_type    => 'plsql/block',
      p_mimes_allowed  => NULL,
      p_comments       => NULL,
      p_source         => 
'BEGIN
UPDATE DEPT SET DNAME = :dname WHERE DEPTNO = :deptno;
COMMIT;
END;');

  ORDS.DEFINE_MODULE(
      p_module_name    => 'CallBack',
      p_base_path      => '/Fbdi/',
      p_items_per_page => 25,
      p_status         => 'PUBLISHED',
      p_comments       => NULL);

  ORDS.DEFINE_TEMPLATE(
      p_module_name    => 'CallBack',
      p_pattern        => 'Url',
      p_priority       => 0,
      p_etag_type      => 'NONE',
      p_etag_query     => NULL,
      p_comments       => NULL);

  ORDS.DEFINE_HANDLER(
      p_module_name    => 'CallBack',
      p_pattern        => 'Url',
      p_method         => 'POST',
      p_source_type    => 'plsql/block',
      p_mimes_allowed  => NULL,
      p_comments       => NULL,
      p_source         => 
'  begin
    insert into temp(col01,response) values(''call back'',:BODY_TEXT);
    COMMIT;
    insert into fbdi_logs(payload) values (:body_text);
exception when others then
HTP.print(''Error: '' || SQLERRM);
end;');

  ORDS.DEFINE_PARAMETER(
      p_module_name        => 'CallBack',
      p_pattern            => 'Url',
      p_method             => 'POST',
      p_name               => 'body_text',
      p_bind_variable_name => 'body_text',
      p_source_type        => 'HEADER',
      p_param_type         => 'STRING',
      p_access_method      => 'IN',
      p_comments           => NULL);

  ORDS.DEFINE_HANDLER(
      p_module_name    => 'CallBack',
      p_pattern        => 'Url',
      p_method         => 'PUT',
      p_source_type    => 'plsql/block',
      p_mimes_allowed  => NULL,
      p_comments       => NULL,
      p_source         => 
'begin
insert into fbdi_logs(payload) values (:body_text);
exception when others then
HTP.print(''Error: '' || SQLERRM);
end;');

  ORDS.DEFINE_MODULE(
      p_module_name    => 'call',
      p_base_path      => '/call/',
      p_items_per_page => 25,
      p_status         => 'PUBLISHED',
      p_comments       => NULL);

  ORDS.DEFINE_TEMPLATE(
      p_module_name    => 'call',
      p_pattern        => 'data/',
      p_priority       => 0,
      p_etag_type      => 'NONE',
      p_etag_query     => NULL,
      p_comments       => NULL);

  ORDS.DEFINE_HANDLER(
      p_module_name    => 'call',
      p_pattern        => 'data/',
      p_method         => 'GET',
      p_source_type    => 'plsql/block',
      p_mimes_allowed  => NULL,
      p_comments       => NULL,
      p_source         => 
'select * from emp');

  ORDS.DEFINE_MODULE(
      p_module_name    => 'setdata',
      p_base_path      => '/get/',
      p_items_per_page => 25,
      p_status         => 'PUBLISHED',
      p_comments       => NULL);

  ORDS.DEFINE_TEMPLATE(
      p_module_name    => 'setdata',
      p_pattern        => 'detail',
      p_priority       => 0,
      p_etag_type      => 'NONE',
      p_etag_query     => NULL,
      p_comments       => NULL);

  ORDS.DEFINE_HANDLER(
      p_module_name    => 'setdata',
      p_pattern        => 'detail',
      p_method         => 'GET',
      p_source_type    => 'json/collection',
      p_mimes_allowed  => NULL,
      p_comments       => NULL,
      p_source         => 
'select * from emp');

  ORDS.DEFINE_MODULE(
      p_module_name    => 'demo1',
      p_base_path      => '/data/',
      p_items_per_page => 25,
      p_status         => 'PUBLISHED',
      p_comments       => NULL);

  ORDS.DEFINE_TEMPLATE(
      p_module_name    => 'demo1',
      p_pattern        => 'ver',
      p_priority       => 0,
      p_etag_type      => 'NONE',
      p_etag_query     => NULL,
      p_comments       => NULL);

  ORDS.DEFINE_HANDLER(
      p_module_name    => 'demo1',
      p_pattern        => 'ver',
      p_method         => 'POST',
      p_source_type    => 'plsql/block',
      p_mimes_allowed  => NULL,
      p_comments       => NULL,
      p_source         => 
'begin

insert into temp(col01) values(''at post demo1'');
commit;
end;');

  ORDS.DEFINE_HANDLER(
      p_module_name    => 'demo1',
      p_pattern        => 'ver',
      p_method         => 'GET',
      p_source_type    => 'json/collection',
      p_mimes_allowed  => NULL,
      p_comments       => NULL,
      p_source         => 
'select * from emp');

  ORDS.DEFINE_MODULE(
      p_module_name    => 'callbackdemo',
      p_base_path      => '/callbackemp/',
      p_items_per_page => 25,
      p_status         => 'PUBLISHED',
      p_comments       => NULL);

  ORDS.DEFINE_TEMPLATE(
      p_module_name    => 'callbackdemo',
      p_pattern        => 'empdata',
      p_priority       => 0,
      p_etag_type      => 'HASH',
      p_etag_query     => NULL,
      p_comments       => NULL);

  ORDS.DEFINE_HANDLER(
      p_module_name    => 'callbackdemo',
      p_pattern        => 'empdata',
      p_method         => 'POST',
      p_source_type    => 'plsql/block',
      p_mimes_allowed  => NULL,
      p_comments       => NULL,
      p_source         => 
'declare
    l_cnt   number;
begin


select count(*) into l_cnt from emp;

insert into temp1 values(l_cnt || '',  l_cnt from callback demo'');
commit;
htp.print(l_cnt||''- l-count'');

end;    ');

  ORDS.DEFINE_PARAMETER(
      p_module_name        => 'callbackdemo',
      p_pattern            => 'empdata',
      p_method             => 'POST',
      p_name               => 'l_cnt',
      p_bind_variable_name => 'l_cnt',
      p_source_type        => 'RESPONSE',
      p_param_type         => 'STRING',
      p_access_method      => 'OUT',
      p_comments           => NULL);

    
  ORDS.CREATE_ROLE(p_role_name => 'oracle.dbtools.role.autorest.WKSP_EBS2CLOUD_MIGRATION');
    
  l_roles(1) := 'oracle.dbtools.autorest.any.schema';
  l_roles(2) := 'oracle.dbtools.role.autorest.WKSP_EBS2CLOUD_MIGRATION';

  ORDS.DEFINE_PRIVILEGE(
      p_privilege_name => 'oracle.dbtools.autorest.privilege.WKSP_EBS2CLOUD_MIGRATION',
      p_roles          => l_roles,
      p_patterns       => l_patterns,
      p_modules        => l_modules,
      p_label          => NULL,
      p_description    => NULL,
      p_comments       => NULL); 

  l_roles.DELETE;
  l_modules.DELETE;
  l_patterns.DELETE;
    
  l_roles(1) := 'SODA Developer';
  l_patterns(1) := '/soda/*';

  ORDS.DEFINE_PRIVILEGE(
      p_privilege_name => 'oracle.soda.privilege.developer',
      p_roles          => l_roles,
      p_patterns       => l_patterns,
      p_modules        => l_modules,
      p_label          => NULL,
      p_description    => NULL,
      p_comments       => NULL); 

  l_roles.DELETE;
  l_modules.DELETE;
  l_patterns.DELETE;
    
          
COMMIT;

END;


-- sqlcl_snapshot {"hash":"d8672503070ef7da5859249cdf07347d186f771e","type":"ORDS_SCHEMA","name":"ords","schemaName":"WKSP_EBS2CLOUD_MIGRATION","sxml":""}