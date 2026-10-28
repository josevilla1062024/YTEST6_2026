@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'CDS Root Entity'
@Metadata.ignorePropagatedAnnotations: true
/*+[hideWarning] { "IDS" : [ "CARDINALITY_CHECK" ]  } */
define root view entity YCDS_CUSTOMER_ROOT_26JV
  as select from /dmo/customer
  composition [1..1] of YCDS_CUST_BOOK_26JV as _Booking
  association [1..*] to /dmo/airport        as _Airport on _Airport.city = $projection.City
{
  key customer_id as CustomerId,
      first_name  as FirstName,
      last_name   as LastName,
      city        as City,
      _Booking, // Mandatory
      _Airport  // Optional
}
