@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'CDS - CDS with SF for Flight Discount'
@Metadata.ignorePropagatedAnnotations: true
define view entity YCDS_REAL_PRICE_26JV
  as select from YCDS_FLIGHT_DISCOUNT_26JV
{
  key CarrierId,
  key ConnectionId,
  key FlightDate,
      @Semantics.amount.currencyCode: 'CurrencyCode'
      Price,
      CurrencyCode,
      PlaneTypeId,
      SeatsMax,
      SeatsOccupied,
      @Semantics.amount.currencyCode: 'CurrencyCode'
      YSF_DIN_CALC_DISCOUNT_26JV( p1 => cast( Price          as abap.dec(16,2) ),
                                  p2 => cast( FlightDiscount as abap.dec(16,2) ) ) as RealPrice
}
