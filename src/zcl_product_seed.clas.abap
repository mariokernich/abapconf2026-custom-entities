CLASS zcl_product_seed DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_product_seed IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.

    TYPES tt_product TYPE STANDARD TABLE OF zproduct WITH EMPTY KEY.

    out->write( |*** ZPRODUCT Seed Runner ***\n| ).

    "-------------------------------------------------------------
    " Step 1: Clear existing data
    "-------------------------------------------------------------
    DELETE FROM zproduct.
    DATA(lv_deleted) = sy-dbcnt.
    COMMIT WORK.
    out->write( |{ lv_deleted } existing products deleted.\n| ).

    "-------------------------------------------------------------
    " Step 2: Build seed data
    "-------------------------------------------------------------
    DATA(lt_products) = VALUE tt_product(
      ( client    = sy-mandt
        productid = 'P0000001'
        name      = 'Coffee Beans'
        price     = '12.50'
        currency  = 'EUR'
        stock     = 200 )
      ( client    = sy-mandt
        productid = 'P0000002'
        name      = 'Green Tea'
        price     = '8.99'
        currency  = 'EUR'
        stock     = 150 )
      ( client    = sy-mandt
        productid = 'P0000003'
        name      = 'Dark Chocolate'
        price     = '4.75'
        currency  = 'USD'
        stock     = 500 )
      ( client    = sy-mandt
        productid = 'P0000004'
        name      = 'Mineral Water'
        price     = '1.20'
        currency  = 'EUR'
        stock     = 1000 )
      ( client    = sy-mandt
        productid = 'P0000005'
        name      = 'Sparkling Wine'
        price     = '25.00'
        currency  = 'EUR'
        stock     = 50 )
    ).

    "-------------------------------------------------------------
    " Step 3: Insert seed data
    "-------------------------------------------------------------
    INSERT zproduct FROM TABLE @lt_products.

    IF sy-subrc = 0.
      COMMIT WORK.
      out->write( |{ lines( lt_products ) } products inserted successfully.\n| ).
    ELSE.
      ROLLBACK WORK.
      out->write( |Insert failed (sy-subrc = { sy-subrc }).\n| ).
      RETURN.
    ENDIF.

    "-------------------------------------------------------------
    " Step 4: Display current contents
    "-------------------------------------------------------------
    SELECT productid, name, price, currency, stock
      FROM zproduct
      ORDER BY productid
      INTO TABLE @DATA(lt_result).

    out->write( |\nCurrent ZPRODUCT contents ({ lines( lt_result ) } rows):\n| ).
    out->write( lt_result ).

  ENDMETHOD.
ENDCLASS.
