@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'CDS Publication of Associations'
@Metadata.ignorePropagatedAnnotations: true
define view entity YCDS_PUBLIC_ASSOC_26JV
  as select from /dmo/travel as Travel
  association [1..1] to YCDS_AGENCY_MAX_26JV as _Agency on _Agency.AgencyId = $projection.AgencyId
{
  key travel_id as TravelId,
      agency_id as AgencyId,
      _Agency
}
