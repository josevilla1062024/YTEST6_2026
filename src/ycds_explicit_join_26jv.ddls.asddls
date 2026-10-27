@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'CDS Explicit Join'
@Metadata.ignorePropagatedAnnotations: true
define view entity YCDS_EXPLICIT_JOIN_26JV
  as select from /dmo/customer as Customer
  association [0..*] to /dmo/booking as _Booking on Customer.customer_id = _Booking.customer_id
{
  key Customer.customer_id         as CustomerId,
      Customer.first_name          as FirstName,
      Customer.last_name           as LastName,
      _Booking[inner].booking_date as BookingDate
}
