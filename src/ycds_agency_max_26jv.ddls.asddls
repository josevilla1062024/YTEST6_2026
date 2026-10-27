@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Agencias'
@Metadata.ignorePropagatedAnnotations: true
define view entity YCDS_AGENCY_MAX_26JV
  as select from /dmo/agency
{
  key agency_id as AgencyId,
      name      as Name
}
