@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'CDS Path Expression'
@Metadata.ignorePropagatedAnnotations: true
define view entity YCDS_PATH_EXPRESS_26JV
  as select from /dmo/booking as Booking
  association [0..*] to /dmo/flight as _Flight on Booking.connection_id = _Flight.connection_id
{
  key Booking.booking_id                                  as BookingId,
  key Booking.travel_id                                   as TravelId,
      _Flight[ 1: connection_id = '0001' ].seats_occupied as SeatsOccupied
}
