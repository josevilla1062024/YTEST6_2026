@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Employee (Consumption)'
@ObjectModel.usageType:{
 serviceQuality: #D,
 sizeCategory:   #M,
 dataClass:      #MASTER
                    }
@Metadata.ignorePropagatedAnnotations: true
define view entity YCDS_C_EMPLOYEE
  as select from YCDS_R_Employee_26JV
{
  key EmployeeId,
      FirstName,
      LastName,
      BirthDate,
      EntryDate,
      DepartmentId,
       @Semantics.amount.currencyCode: 'CurrencyCode'
      AnnualSalary,
      CurrencyCode,
      CreatedBy,
      CreatedAt,
      LocalLastChangedBy,
      LocalLastChangedAt,
      LastChangedAt
}
