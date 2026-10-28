@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'CDS Association - Parent Child'
@Metadata.ignorePropagatedAnnotations: true
define view entity YCDS_CUST_BOOK_26JV
  as select from /dmo/booking
  association to parent YCDS_CUSTOMER_ROOT_26JV as _Customer on _Customer.CustomerId = $projection.CustomerId
{
  key /dmo/booking.travel_id   as TravelId,
  key /dmo/booking.booking_id  as BookingId,
  key /dmo/booking.customer_id as CustomerId,
      _Customer //mandatory
}
