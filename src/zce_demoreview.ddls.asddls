@EndUserText.label: 'Demo Review Custom Entity'
@ObjectModel.query.implementedBy: 'ABAP:ZCL_DEMO_REVIEW_QUERY'

@UI.headerInfo: { typeName:       'Review',
                  typeNamePlural: 'Reviews',
                  title:          { type: #STANDARD, value: 'ReviewId' },
                  description:    { type: #STANDARD, value: 'ProductId' } }

define root custom entity ZCE_DemoReview
{
      @UI.facet: [ { id:       'IdentificationFacet',
                     type:     #IDENTIFICATION_REFERENCE,
                     label:    'Review Details',
                     position: 10 } ]

      @UI.lineItem:       [ { position: 10, importance: #HIGH, label: 'Product ID' } ]
      @UI.identification: [ { position: 10, label: 'Product ID' } ]
      @UI.selectionField: [ { position: 10 } ]
  key ProductId : abap.char(10);

      @UI.lineItem:       [ { position: 20, importance: #HIGH, label: 'Review ID' } ]
      @UI.identification: [ { position: 20, label: 'Review ID' } ]
      @UI.selectionField: [ { position: 20 } ]
  key ReviewId  : abap.numc(6);

      @UI.lineItem:       [ { position: 30, importance: #MEDIUM, label: 'Rating' } ]
      @UI.identification: [ { position: 30, label: 'Rating' } ]
      @UI.selectionField: [ { position: 30 } ]
      @UI.dataPoint: { title:           'Rating',
                       targetValue:     5,
                       visualization:   #RATING }
      Rating    : abap.int1;

      @UI.lineItem:       [ { position: 40, importance: #LOW, label: 'Review Text' } ]
      @UI.identification: [ { position: 40, label: 'Review Text' } ]
      @UI.multiLineText:  true
      Text      : abap.char(200);

      _Product  : association [1..1] to ZCE_DemoProduct
                    on $projection.ProductId = _Product.ProductId;
}
