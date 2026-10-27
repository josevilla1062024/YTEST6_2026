@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'CDS Aggregation'
@Metadata.ignorePropagatedAnnotations: true
define view entity YDATA_AGGREGATION_26JV
  as select from /dmo/booking
{
  currency_code,
  @Semantics.amount.currencyCode: 'currency_code'
  sum( flight_price ) as FlightPrice
}
group by
  currency_code;
