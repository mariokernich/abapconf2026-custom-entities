@EndUserText.label: 'Weather Custom Entity Sample'
@ObjectModel.query.implementedBy: 'ABAP:ZCL_WEATHER_QUERY'

@UI.headerInfo: { typeName:       'Weather',
                  typeNamePlural: 'Weather Data',
                  title:          { type: #STANDARD, value: 'city' },
                  description:    { type: #STANDARD, value: 'temperature' } }

@Search.searchable: true

define root custom entity ZCE_WEATHER
{
      @UI.facet: [ { id:       'WeatherFacet',
                     type:     #IDENTIFICATION_REFERENCE,
                     label:    'Weather Details',
                     position: 10 } ]

      @UI.lineItem:       [ { position: 10, importance: #HIGH, label: 'City' } ]
      @UI.identification: [ { position: 10, label: 'City' } ]
      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold:   0.8
  key city        : abap.string;

      @UI.lineItem:       [ { position: 20, importance: #HIGH, label: 'Temperature (°C)' } ]
      @UI.identification: [ { position: 20, label: 'Temperature (°C)' } ]
      @EndUserText.quickInfo: 'Current temperature in degrees Celsius'
      temperature : abap.dec(5,2);
}
