### RalesEngine

RalesEngine uses Rails and ActiveRecord to serve up JSON from SalesEngine data.

To run RalesEngine:

`git clone https://github.com/meyerhoferc/rales_engine.git`
`rake db:setup`

### Endpoints Available
#### Record Endpoints
Record endpoints provide JSON for records stored in database tables as direct queries against a single resource.
For each of the following resources: `[merchants, customers, items, invoices, invoice_items, transactions]`

`get /api/v1/resource(s)` returns JSON for all records for the resource

`get /api/v1/resource/:id` returns JSON for a resource

`get /api/v1/resource/find?parameter` returns JSON for a resource meeting parameter

`get /api/v1/resource/find_all?parameter` returns JSON for all resources meeting parameter

#### Relationship Endpoints
Relationship endpoints provide JSON for queries accessing data between resources.

#### Merchants
`get /api/v1/merchants/:id/items` returns a collection of items associated with that merchant

`get /api/v1/merchants/:id/invoices` returns a collection of invoices associated with that merchant from their known orders

#### Invoices
`get /api/v1/invoices/:id/transactions` returns a collection of associated transactions for an invoice

`get /api/v1/invoices/:id/invoice_items` returns a collection of associated invoice items for an invoice

`get /api/v1/invoices/:id/items` returns a collection of associated items

`get /api/v1/invoices/:id/customer` returns the associated customer

`get /api/v1/invoices/:id/merchant` returns the associated merchant

#### Invoice Items
`get /api/v1/invoice_items/:id/invoice` returns the associated invoice

`get /api/v1/invoice_items/:id/item` returns the associated item

#### Items
`get /api/v1/items/:id/invoice_items` returns a collection of associated invoice items

`get /api/v1/items/:id/merchant` returns the associated merchant

#### Transactions
`get /api/v1/transactions/:id/invoice` returns the associated invoice

#### Customers
get `/api/v1/customers/:id/invoices` returns a collection of associated invoices

`get /api/v1/customers/:id/transactions` returns a collection of associated transactions

#### Business Intelligence Endpoints
Business intelligence endpoints provide JSON for analytics on multiple resources.

#### All Merchants
`get /api/v1/merchants/most_revenue?quantity=x` returns the top `x` merchants ranked by total revenue

`get /api/v1/merchants/most_items?quantity=x` returns the top `x` merchants ranked by total number of items sold

`get /api/v1/merchants/revenue?date=x` returns the total revenue for date `x` across all merchants

#### Single Merchant
`get /api/v1/merchants/:id/revenue` returns the total revenue for that merchant across all transactions

`get /api/v1/merchants/:id/revenue?date=x` returns the total revenue for that merchant for a specific invoice date `x`

`get /api/v1/merchants/:id/favorite_customer`returns the customer who has conducted the most total number of successful transactions

`get /api/v1/merchants/:id/customers_with_pending_invoices` returns a collection of customers which have pending (unpaid) invoices. A pending invoice has no transactions with a result of `success`

#### Items
`get /api/v1/items/most_revenue?quantity=x` returns the top `x` items ranked by total revenue generated

`get /api/v1/items/most_items?quantity=x` returns the top `x` item instances ranked by total number sold

`get /api/v1/items/:id/best_day` returns the date with the most sales for the given item using that invoice date. If there are multiple days with equal number of sales, return the most recent day

To run the test suite:
`rake db:test:prepare`
`rspec`
