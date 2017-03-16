### RalesEngine

RalesEngine uses Rails and ActiveRecord to serve up JSON from SalesEngine data.

To run RalesEngine:

git clone https://github.com/meyerhoferc/rales_engine.git
`rake db:setup`

### Endpoints Available
#### Record Endpoints
Record endpoints provide JSON for records stored in database tables as direct queries against a single resource.
For each of the following resources: [merchants, customers, items, invoices, invoice_items, transactions]
get `/api/v1/resource(s)` returns JSON for all records for the resource
get `/api/v1/resource/:id` returns JSON for a resource
get `/api/v1/resource/find?parameter` returns JSON for a resource meeting parameter
get `/api/v1/resource/find_all?parameter` returns JSON for all resources meeting parameter

#### Relationship Endpoints
Relationship endpoints provide JSON for queries accessing data between resources.

#### Business Intelligence Endpoints
Business intelligence endpoints provide JSON for analytics on multiple resources.

To run the test suite:
`rake db:test:prepare`
`rspec`
