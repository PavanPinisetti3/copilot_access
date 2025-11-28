create or replace 
package WKSP_EBS2CLOUD_MIGRATION.xx_mig_pkg body
procedure xx_status(xx_load) as
status varchar2(50);
begin
select EXECUTABLE_STATUS into status
from ess_request_history
where xx_load=request_id;
dbms_output.put_line(status);
end xx_status;
end xx_mig_pkg;
/



-- sqlcl_snapshot {"hash":"1c0b63a68996b5ae7a408eebd80fb9f9519e32dc","type":"PACKAGE_SPEC","name":"XX_MIG_PKG","schemaName":"WKSP_EBS2CLOUD_MIGRATION","sxml":""}