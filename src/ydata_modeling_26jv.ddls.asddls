@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'CDS Data Modeling'
@Metadata.ignorePropagatedAnnotations: true
define view entity YDATA_MODELING_26JV
  as select from /dmo/customer
{

  key customer_id                      as CustomerId,
      first_name                       as FirstName,
      last_name                        as LastName,
      case
        when country_code = 'US' then 'United States'
        when country_code = 'DE' then 'Germany'
        else 'Other Country'
      end                              as COUNTRY,
      cast( customer_id as abap.int8 ) as CUSTOMER_ID_INT,
      $session.client                  as CLIENT_SESSION,
      $session.system_date             as SYSTEM_DATE
}
