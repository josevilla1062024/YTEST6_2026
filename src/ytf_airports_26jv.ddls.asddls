@EndUserText.label: 'Table Function - Table Function Airport'
@ClientHandling.type: #CLIENT_DEPENDENT
@ClientHandling.algorithm: #SESSION_VARIABLE
define table function YTF_AIRPORTS_26JV
  with parameters
//    @Environment.systemField: #CLIENT
//    pClient : abap.clnt,
    pCity   : /dmo/city
returns
{
  key client     : abap.clnt;
  key airport_id : /dmo/airport_id;
      name       : /dmo/airport_name;
      city       : /dmo/city;
      country    : land1;

}
implemented by method
  YCL_AMDP_AIRPORT_26JV=>get_airport;