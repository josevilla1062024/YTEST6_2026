@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Department (Entity)'
@Metadata.ignorePropagatedAnnotations: true
define view entity YCDS_R_DEPARTMENT_26JV
  as select from ytb_depment_26jv
  association [0..*] to YCDS_R_Employee_26JV as _Employee
  on $projection.Id = _Employee.DepartmentId
  association [0..1] to YCDS_R_Employee_26JV as _Head
  on $projection.HeadId = _Head.EmployeeId
  association [1..1] to YCDS_R_Employee_26JV as _Assistant
  on $projection.AssistantId = _Assistant.EmployeeId 
{
  key id                    as Id,
      description           as Description,
      head_id               as HeadId,
      assistant_id          as AssistantId,
      created_by            as CreatedBy,
      created_at            as CreatedAt,
      local_last_changed_by as LocalLastChangedBy,
      local_last_changed_at as LocalLastChangedAt,
      last_changed_at       as LastChangedAt,
      _Employee,
      _Head,
      _Assistant
}
