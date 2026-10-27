@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'CDS Parameters in CDS'
@Metadata.ignorePropagatedAnnotations: true
define view entity YPARAM_CDS_26JV
  with parameters
    FLIGHT_DATE_PARAM : abap.dats
  as select from /dmo/booking
{
  key travel_id   as TravelId,
  key booking_id  as BookingId,
      customer_id as CustomerId,
      flight_date as FlightDate
}
where flight_date = $parameters.FLIGHT_DATE_PARAM
