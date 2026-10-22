@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'CDS - Interface Entity from root entity for RAP'
@Metadata.ignorePropagatedAnnotations: true
define root view entity YDD_I_CUSTOMER_TRAVEL_26JV
  provider contract transactional_interface
  as projection on YDD_R_CUSTOMER_TRAVEL_26JV
{
  key CustomerUuid,
      CustomerId,
      Description,
      LocalCreatedBy,
      LocalCreatedAt,
      LocalLastChangedBy,
      @Semantics.systemDateTime.localInstanceLastChangedAt: true
      LocalLastChangedAt,
      @Semantics.systemDateTime.lastChangedAt: true
      LastChangedAt,

      /* Associations */
      _Customer
}
