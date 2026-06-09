FUNCTION yfm_get_weekday_name_26jv.
*"----------------------------------------------------------------------
*"*"Local Interface:
*"  IMPORTING
*"     VALUE(DATE) TYPE  D DEFAULT '00000000'
*"     VALUE(LANGUAGE) LIKE  SY-LANGU
*"     VALUE(WEEKDAY_NUMBER) TYPE  C DEFAULT ' '
*"  EXPORTING
*"     VALUE(LANGU_BACK) LIKE  SY-LANGU
*"     VALUE(LONGTEXT) TYPE  TEXT20
*"     VALUE(SHORTTEXT) TYPE  TEXT20
*"----------------------------------------------------------------------
  CASE language.
    WHEN 'E'.
      langu_back = sy-langu.
      longtext = 'Monday'.
      shorttext = 'MO'.

    WHEN OTHERS.
      langu_back = sy-langu.
      longtext = 'Monday'.
      shorttext = 'MO'.

  ENDCASE.


ENDFUNCTION.
