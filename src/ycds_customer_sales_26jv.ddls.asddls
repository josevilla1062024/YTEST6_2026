@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'CDS - CDS with enum and cds type on Customer Sales'
@Metadata.ignorePropagatedAnnotations: true
define view entity YCDS_CUSTOMER_SALES_26JV
  as select from /dmo/customer
{
  key customer_id                                 as CustomerId,
      first_name                                  as FirstName,
      last_name                                   as LastName,
      title                                       as Title,
      street                                      as Street,
      postal_code                                 as PostalCode,
      city                                        as City,
      country_code                                as CountryCode,
      phone_number                                as PhoneNumber,
      email_address                               as EmailAddress,
      @EndUserText.label: 'Sale Status'
      YTY_ENUM_ST_ORDER_26JV.#delivered           as StatusSale,
      @EndUserText.label: 'Sale Name'
      cast( first_name as YTY_CDS_ST_ORDER_26JV ) as SaleName
}
