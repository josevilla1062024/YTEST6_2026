@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Employee (Query)'
@Metadata.ignorePropagatedAnnotations: true
define view entity YCDS_C_EMPLOYEEQUERY_26JV
  as select from YCDS_R_Employee_26JV
{
  key EmployeeId,
      FirstName,
      LastName,
      DepartmentId,

      _Department.Description             as DepartmentDescription,

      //      _Department._Assistant.LastName          as AssistantName,


      concat_with_space( _Department._Assistant.FirstName,
                         _Department._Assistant.LastName,
                         1 )              as AssistantName,


      division( dats_days_between( EntryDate,
                 $session.system_date ),
                 365,
                 1 )                      as CompanyAffiliation,


      @EndUserText.label: 'Employee Role'
      case EmployeeId
                when _Department.HeadId      then 'H'
                when _Department.AssistantId then 'A'
      //                when _Department._Assistant.EmployeeId then 'A'
                else ' '
                end                       as EmployeeRole,

      //currency_conversion( amount             => amount,
      //                       source_currency    => source_currency ,
      //                       target_currency    => target_currency,
      //                       exchange_rate_date => exchange_rate_date
      //                     )

//            @EndUserText.label: 'Monthly Salary'
//            @Semantics.amount.currencyCode: 'CurrencyCode'
//            cast( AnnualSalary as abap.fltp ) / 12.0 as MonthlySalary,
//
//            CurrencyCode,
      cast( 'USD' as /dmo/currency_code ) as CurrencyCodeUSD,

      @EndUserText.label: 'Annual Salary'
      @Semantics.amount.currencyCode: 'CurrencyCodeUSD'
      currency_conversion( amount             => AnnualSalary,
                           source_currency    => CurrencyCode ,
                           target_currency    => $projection.CurrencyCodeUSD,
                           exchange_rate_date => $session.system_date
                         )                as AnnualSalaryConverted,


      @EndUserText.label: 'Monthly Salary'
      @Semantics.amount.currencyCode: 'CurrencyCodeUSD'
      cast( $projection.AnnualSalaryConverted as abap.fltp )
      / 12.0                              as MonthlySalaryConverted,


      /* Associations */
      _Department

}
where CurrencyCode = 'USD'
