require 'csv'
Customer.delete_all
Merchant.delete_all
Item.delete_all
Invoice.delete_all
InvoiceItem.delete_all
Transaction.delete_all
def import_customers
  CSV.foreach('db/data/customers.csv', headers: true, header_converters: :symbol) do |row|
    Customer.create!(first_name: row[:first_name],
                     last_name: row[:last_name],
                     created_at: row[:created_at],
                     updated_at: row[:updated_at],
                     id: row[:id])
  end
  print "Customers loaded\n"
end

def import_merchants
  CSV.foreach('db/data/merchants.csv', headers: true, header_converters: :symbol) do |row|
    Merchant.create!(name: row[:name],
                     created_at: row[:created_at],
                     updated_at: row[:updated_at],
                     id: row[:id])
  end
  print "Merchants loaded\n"
end

def import_items
  CSV.foreach('db/data/items.csv', headers: true, header_converters: :symbol) do |row|
    Item.create!(name: row[:name],
                 description: row[:description],
                 unit_price: row[:unit_price],
                 merchant: Merchant.find(row[:merchant_id]),
                 created_at: row[:created_at],
                 updated_at: row[:updated_at],
                 id: row[:id])
  end
  print "Items loaded\n"
end

def import_invoices
  CSV.foreach('db/data/invoices.csv', headers: true, header_converters: :symbol) do |row|
    Invoice.create!(customer: Customer.find(row[:customer_id]),
                    merchant: Merchant.find(row[:merchant_id]),
                    status: row[:status],
                    created_at: row[:created_at],
                    updated_at: row[:updated_at],
                    id: row[:id])
  end
  print "Invoices loaded\n"
end

def import_invoice_items
  CSV.foreach('db/data/invoice_items.csv', headers: true, header_converters: :symbol) do |row|
    InvoiceItem.create!(item: Item.find(row[:item_id]),
                        invoice: Invoice.find(row[:invoice_id]),
                        quantity: row[:quantity],
                        unit_price: row[:unit_price],
                        created_at: row[:created_at],
                        updated_at: row[:updated_at],
                        id: row[:id])
  end
  print "Invoice-Items loaded\n"
end

def import_transactions
  CSV.foreach('db/data/transactions.csv', headers: true, header_converters: :symbol) do |row|
    Transaction.create!(invoice: Invoice.find(row[:invoice_id]),
                        credit_card_number: row[:credit_card_number],
                        result: row[:result],
                        created_at: row[:created_at],
                        updated_at: row[:updated_at],
                        id: row[:id])
  end
  print "Transactions loaded\n"
end

import_customers
import_merchants
import_items
import_invoices
import_invoice_items
import_transactions
