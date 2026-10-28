@EndUserText.label: 'CDS Custom Entity'
@ObjectModel.query.implementedBy: 'ABAP:YCL_CUSTOM_DETAIL_26JV'
define custom entity YCDS_CUSTOM_DETAIL_26JV
  // with parameters parameter_name : parameter_type
{
  key customer_id   : /dmo/customer_id;
      phone_number  : /dmo/phone_number;
      email_address : /dmo/email_address;
}
