@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Agencias'
@Metadata.ignorePropagatedAnnotations: true
define view entity YCDS_AGENCY_MAX_26JV
  as select from /dmo/agency
  association [1] to I_Country as _country on $projection.CountryCode = _country.Country
{
  key agency_id     as AgencyId,
      @Semantics.text: true
      name          as Name,
      street        as Street,
      postal_code   as PostalCode,
      city          as City,
      country_code  as CountryCode,
      phone_number  as PhoneNumber,
      email_address as EmailAddress,
      web_address   as WebAddress,
      _country
}
