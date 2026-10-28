@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'CDS Child Interface Projection'
@Metadata.ignorePropagatedAnnotations: true
define view entity YCDS_CHILD_PROJ_26JV 
as projection on YCDS_CUST_BOOK_26JV
{
 key TravelId,
  key BookingId,
  key CustomerId,
  /* Associations */    
  _Customer
}
