# What you MUST handle

## The framework calls you — answer carefully

| Request part | Source                                  |
|--------------|-----------------------------------------|
| `$filter`    | `io_request->get_filter( )`             |
| `$orderby`   | `io_request->get_sort_elements( )`      |
| `$top`       | `io_request->get_paging( )`             |
| `$skip`      | `io_request->get_paging( )`             |
| `$select`    | `io_request->get_requested_elements( )` |
