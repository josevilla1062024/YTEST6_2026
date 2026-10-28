@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'CDS Transactional Projection Interface'
@Metadata.ignorePropagatedAnnotations: true
define root view entity YCDS_CUST_PROJ_26JV
  provider contract transactional_interface
  as projection on YCDS_CUSTOMER_ROOT_26JV
{
  key CustomerId,
      FirstName,
      LastName,
      City,
      /* Associations */
      _Airport,
      _Booking
}
