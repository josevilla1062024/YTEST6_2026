@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'CDS Virtual Data Model'
@Metadata.ignorePropagatedAnnotations: true
@Analytics.dataCategory: #CUBE
define view entity YCDS_AN_DATA_FLIGHT_26JV
  as select from /dmo/booking
  association [0..*] to YCDS_VDM_FLIGHT_26JV as _Flight on _Flight.CarrierId = $projection.CarrierId
{
  key travel_id     as TravelId,
  key booking_id    as BookingId,
      booking_date  as BookingDate,
      customer_id   as CustomerId,
      carrier_id    as CarrierId,
      connection_id as ConnectionId,
      flight_date   as FlightDate,
      @Semantics.amount.currencyCode : 'CurrencyCode'
      flight_price  as FlightPrice,
      currency_code as CurrencyCode,

      @DefaultAggregation: #SUM
      @Semantics.amount.currencyCode: 'CurrencyCode'
      _Flight
}
