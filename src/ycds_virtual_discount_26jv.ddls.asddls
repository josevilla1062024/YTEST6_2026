@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'CDS with virtualization on Flight Discount'
@Metadata.ignorePropagatedAnnotations: true
define root view entity YCDS_VIRTUAL_DISCOUNT_26JV
  as select from /dmo/flight
{
  key carrier_id                   as CarrierId,
  key connection_id                as ConnectionId,
  key flight_date                  as FlightDate,

      @Semantics.amount.currencyCode: 'CurrencyCode'
      price                        as price,
      currency_code                as CurrencyCode,
      plane_type_id                as PlaneTypeId,
      seats_max                    as SeatsMax,
      seats_occupied               as SeatsOccupied,

      @Semantics.amount.currencyCode: 'CurrencyCode'
      @EndUserText.label: 'Price with Discount'
      @ObjectModel.virtualElementCalculatedBy: 'ABAP:YCL_VIRTUAL_DISCOUNT_26JV'
      //      @Semantics.amount.currencyCode: 'CurrencyCode'
      cast( 0 as abap.curr(16,2) ) as RealPrice
}
