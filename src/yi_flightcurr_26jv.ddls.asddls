@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'CDS Test'
@Metadata.ignorePropagatedAnnotations: true
define view entity YI_FlightCurr_26JV
  as select from YI_Flight_26JV
{
  key CarrierId,
  key ConnectionId,
  key FlightDate,
      CurrencyCode,
      _Currency.CurrencyISOCode,
      _Currency as _FlightCurrency
}
