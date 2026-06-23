@EndUserText.label: 'Demo Product Custom Entity'
@ObjectModel.query.implementedBy: 'ABAP:ZCL_DEMO_PRODUCT_QUERY'

@UI.headerInfo: { typeName:       'Product',
                  typeNamePlural: 'Products',
                  title:          { type: #STANDARD, value: 'Name' },
                  description:    { type: #STANDARD, value: 'ProductId' } }

define root custom entity ZCE_DemoProduct
{
      @UI.facet: [ { id:            'IdentificationFacet',
                     type:          #IDENTIFICATION_REFERENCE,
                     label:         'Product Details',
                     position:      10 },
                   { id:            'ReviewsFacet',
                     type:          #LINEITEM_REFERENCE,
                     label:         'Reviews',
                     position:      20,
                     targetElement: '_Reviews' } ]

      @UI.lineItem:      [ { position: 10, importance: #HIGH, label: 'Product ID' } ]
      @UI.identification:[ { position: 10, label: 'Product ID' } ]
      @UI.selectionField:[ { position: 10 } ]
  key ProductId : abap.char(10);

      @UI.lineItem:      [ { position: 20, importance: #HIGH, label: 'Name' } ]
      @UI.identification:[ { position: 20, label: 'Name' } ]
      @UI.selectionField:[ { position: 20 } ]
      Name      : abap.char(40);

      @UI.lineItem:      [ { position: 30, importance: #MEDIUM, label: 'Price' } ]
      @UI.identification:[ { position: 30, label: 'Price' } ]
      @Semantics.amount.currencyCode: 'Currency'
      Price     : abap.dec(15,2);

      @UI.lineItem:      [ { position: 40, importance: #LOW, label: 'Currency' } ]
      @UI.identification:[ { position: 40, label: 'Currency' } ]
      @Semantics.currencyCode: true
      Currency  : abap.cuky;

      _Reviews  : association [0..*]
                      to ZCE_DemoReview
          on $projection.ProductId
           = _Reviews.ProductId;
}
