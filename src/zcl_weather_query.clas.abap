CLASS zcl_weather_query DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_rap_query_provider.
  PROTECTED SECTION.
  PRIVATE SECTION.
    TYPES:
      BEGIN OF ty_weather,
        city        TYPE string,
        temperature TYPE int1,
      END OF ty_weather,
      tt_weather TYPE STANDARD TABLE OF ty_weather WITH EMPTY KEY.

    CONSTANTS:
      c_geo_url      TYPE string VALUE `https://geocoding-api.open-meteo.com/v1/search`,
      c_forecast_url TYPE string VALUE `https://api.open-meteo.com/v1/forecast`.

    METHODS:
      get_temperature_for_city
        IMPORTING iv_city               TYPE string
        RETURNING VALUE(rv_temperature) TYPE int1
        RAISING   cx_web_http_client_error
                  cx_http_dest_provider_error,

      http_get
        IMPORTING iv_url         TYPE string
        RETURNING VALUE(rv_body) TYPE string
        RAISING   cx_web_http_client_error
                  cx_http_dest_provider_error.

ENDCLASS.



CLASS zcl_weather_query IMPLEMENTATION.
  METHOD if_rap_query_provider~select.
    DATA lt_result TYPE tt_weather.

    "-------------------------------------------------------------
    " 1) Read filters / paging from the request
    "-------------------------------------------------------------
    DATA(lt_filter_cond) = io_request->get_filter( )->get_as_ranges( ).
    DATA(lv_top)         = io_request->get_paging( )->get_page_size( ).
    DATA(lv_skip)        = io_request->get_paging( )->get_offset( ).
    DATA(lv_search)      = io_request->get_search_expression( ).

    "-------------------------------------------------------------
    " 2) Determine list of cities
    "-------------------------------------------------------------
    DATA lt_cities TYPE STANDARD TABLE OF string WITH EMPTY KEY.

    READ TABLE lt_filter_cond
      WITH KEY name = 'CITY'
      ASSIGNING FIELD-SYMBOL(<ls_city_filter>).

    IF lv_search IS NOT INITIAL.
        APPEND lv_search TO lt_cities.
    ELSE.
      lt_cities = VALUE #(
        ( `Berlin` )
        ( `London` )
        ( `New York` )
        ( `Tokyo` )
        ( `Sydney` )
        ( `Cairo` )
        ( `Reykjavik` )
        ( `Madrid` ) ).
    ENDIF.

    "-------------------------------------------------------------
    " 3) Fetch live temperature for each city
    "-------------------------------------------------------------
    LOOP AT lt_cities INTO DATA(lv_city).
      TRY.
          APPEND VALUE #(
            city        = lv_city
            temperature = get_temperature_for_city( lv_city )
          ) TO lt_result.
        CATCH cx_root INTO DATA(lx).
          " On error, still return the city with temperature 0
          APPEND VALUE #( city = lv_city temperature = 0 ) TO lt_result.
      ENDTRY.
    ENDLOOP.

    "-------------------------------------------------------------
    " 4) Paging
    "-------------------------------------------------------------
    DATA(lv_total) = lines( lt_result ).

    IF lv_skip > 0.
      DELETE lt_result FROM 1 TO lv_skip.
    ENDIF.

    IF lv_top > 0 AND lines( lt_result ) > lv_top.
      DELETE lt_result FROM lv_top + 1 TO lines( lt_result ).
    ENDIF.

    "-------------------------------------------------------------
    " 5) Send response
    "-------------------------------------------------------------
    io_response->set_total_number_of_records( CONV #( lv_total ) ).
    io_response->set_data( lt_result ).
  ENDMETHOD.

  METHOD get_temperature_for_city.

    "-------------------------------------------------------------
    " Step 1: Geocode city -> latitude/longitude
    " https://geocoding-api.open-meteo.com/v1/search?name=Berlin&count=1
    "-------------------------------------------------------------
    DATA(lv_geo_url) = |{ c_geo_url }?name={ cl_web_http_utility=>escape_url( iv_city ) }&count=1&language=en&format=json|.
    DATA(lv_geo_json) = http_get( lv_geo_url ).

    DATA: lv_latitude  TYPE string,
          lv_longitude TYPE string.

    TYPES:
      BEGIN OF ty_geo_result,
        latitude  TYPE f,
        longitude TYPE f,
      END OF ty_geo_result,
      BEGIN OF ty_geo_response,
        results TYPE STANDARD TABLE OF ty_geo_result WITH EMPTY KEY,
      END OF ty_geo_response.

    DATA ls_geo TYPE ty_geo_response.

    /ui2/cl_json=>deserialize(
      EXPORTING json = lv_geo_json
                pretty_name = /ui2/cl_json=>pretty_mode-low_case
      CHANGING  data = ls_geo ).

    IF ls_geo-results IS INITIAL.
      rv_temperature = 0.
      RETURN.
    ENDIF.

    DATA(ls_first) = ls_geo-results[ 1 ].
    lv_latitude   = |{ ls_first-latitude }|.
    lv_longitude  = |{ ls_first-longitude }|.

    "-------------------------------------------------------------
    " Step 2: Get current temperature for coordinates
    " https://api.open-meteo.com/v1/forecast?latitude=..&longitude=..&current=temperature_2m
    "-------------------------------------------------------------
    DATA(lv_fc_url) =
      |{ c_forecast_url }?latitude={ lv_latitude }&longitude={ lv_longitude }&current=temperature_2m|.
    DATA(lv_fc_json) = http_get( lv_fc_url ).

    TYPES:
      BEGIN OF ty_current,
        temperature_2m TYPE f,
      END OF ty_current,
      BEGIN OF ty_forecast,
        current TYPE ty_current,
      END OF ty_forecast.

    DATA ls_fc TYPE ty_forecast.

    /ui2/cl_json=>deserialize(
      EXPORTING json = lv_fc_json
                pretty_name = /ui2/cl_json=>pretty_mode-low_case
      CHANGING  data = ls_fc ).

    " Round and cap into int1 range (0..127 from Open-Meteo's realistic values)
    DATA(lv_temp_f) = ls_fc-current-temperature_2m.
    IF lv_temp_f < 0.
      rv_temperature = 0.
    ELSEIF lv_temp_f > 127.
      rv_temperature = 127.
    ELSE.
     rv_temperature = lv_temp_f.
    ENDIF.

  ENDMETHOD.


  METHOD http_get.

    "-------------------------------------------------------------
    " Create HTTP client directly by URL.
    " In ABAP Cloud (BTP) you must additionally maintain a
    " Communication Arrangement / SSL trust for the host:
    "    - api.open-meteo.com
    "    - geocoding-api.open-meteo.com
    "-------------------------------------------------------------
    DATA(lo_dest)   = cl_http_destination_provider=>create_by_url( iv_url ).
    DATA(lo_client) = cl_web_http_client_manager=>create_by_http_destination( lo_dest ).

    DATA(lo_request) = lo_client->get_http_request( ).
    lo_request->set_header_field( i_name = 'Accept' i_value = 'application/json' ).

    DATA(lo_response) = lo_client->execute( if_web_http_client=>get ).

    rv_body = lo_response->get_text( ).

    lo_client->close( ).

  ENDMETHOD.
ENDCLASS.
