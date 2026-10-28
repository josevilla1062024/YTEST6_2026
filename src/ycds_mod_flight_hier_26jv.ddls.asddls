@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'CDS for Hierarchical model Flight'
@Metadata.ignorePropagatedAnnotations: true
/*+[hideWarning] { "IDS" : [ "KEY_CHECK" ]  } */
define view entity YCDS_MOD_FLIGHT_HIER_26JV
  as select from /dmo/booking
  association [0..1] to YCDS_MOD_FLIGHT_HIER_26JV as _Booking on _Booking.BookingId = $projection.ConnectionID
{
  key booking_id  as BookingId,
      customer_id as CustomerId,
      connection_id as ConnectionID,
      _Booking
}
