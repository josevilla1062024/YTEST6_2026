@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'CDS Currency Conversion'
@Metadata.ignorePropagatedAnnotations: true
define view entity YSALES_CONVERTED_26JV
  as select from /dmo/booking
{
  currency_code,
  @Semantics.amount.currencyCode: 'currency_code'
  currency_conversion(
  amount => flight_price,
  source_currency => currency_code,
  target_currency => abap.cuky'USD',
  exchange_rate_date => $session.system_date,
  error_handling => 'SET_TO_NULL'
  ) as FLIGHT_PRICE_USD
}
