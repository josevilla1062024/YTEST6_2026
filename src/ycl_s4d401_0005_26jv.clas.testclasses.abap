*"* use this source file for your ABAP unit test classes
class ltcl_test definition final for testing
  duration short
  risk level harmless.

  private section.
    methods:
      first_test for testing raising cx_static_check.
endclass.


class ltcl_test implementation.

  method first_test.
    cl_abap_unit_assert=>fail( 'Implement your first test here' ).
  endmethod.

endclass.
