@Metadata.allowExtensions: true
@Metadata.ignorePropagatedAnnotations: true
@EndUserText: {
  label: '###GENERATED Core Data Service Entity'
}
@ObjectModel: {
  sapObjectNodeType.name: 'ZYCUSTOMERS2_26JV'
}
@AccessControl.authorizationCheck: #NOT_REQUIRED
define root view entity YC_CUSTOMERS2_26JV
  provider contract transactional_query
  as projection on YR_CUSTOMERS2_26JV
  association [1..1] to YR_CUSTOMERS2_26JV as _BaseEntity on $projection.CustomerUUID = _BaseEntity.CustomerUUID and $projection.FlightDate = _BaseEntity.FlightDate and $projection.CustomerID = _BaseEntity.CustomerID
{
  key CustomerUUID,
  key FlightDate,
  key CustomerID,
  Description,
  @Semantics: {
    amount.currencyCode: 'CurrencyCode'
  }
  Price,
  @Consumption: {
    valueHelpDefinition: [ {
      entity.element: 'Currency', 
      entity.name: 'I_CurrencyStdVH', 
      useForValidation: true
    } ]
  }
  CurrencyCode,
  OverallStatus,
  @Semantics: {
    user.createdBy: true
  }
  LocalCreatedBy,
  @Semantics: {
    systemDateTime.createdAt: true
  }
  LocalCreatedAt,
  @Semantics: {
    user.localInstanceLastChangedBy: true
  }
  LocalLastChangedBy,
  @Semantics: {
    systemDateTime.localInstanceLastChangedAt: true
  }
  LocalLastChangedAt,
  @Semantics: {
    systemDateTime.lastChangedAt: true
  }
  LastChangedAt,
  _BaseEntity
}
