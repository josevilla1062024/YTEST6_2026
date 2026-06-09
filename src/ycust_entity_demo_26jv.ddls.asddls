@EndUserText.label: 'CDS Custom Entity Demo'
@ObjectModel.query.implementedBy: 'ABAP:YCL_CUST_ENTITY_DEMO_26JV'
define custom entity YCUST_ENTITY_DEMO_26JV
  // with parameters parameter_name : parameter_type
{
      // Element list, Element annotations
      @UI.selectionField: [{position: 10}]
      @UI.lineItem: [{position: 10}]
  key UserName  : text12;
      @UI.lineItem: [{position: 20}]
      FirstName : ad_namefir;
      @UI.lineItem: [{position: 30}]
      LastName  : ad_namelas;
      FullName  : text80;

}
