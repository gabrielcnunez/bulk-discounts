require 'rails_helper'

RSpec.describe 'the merchant invoices show page' do
  before :each do
    @merchant1 = Merchant.create!(name: "Billy's Baby Book Barn")
    @merchant2 = Merchant.create!(name: "Candy's Child Compendium Collection")
    @item1 = @merchant1.items.create!(name: "Learn to Count, Dummy!", description: "Educational Children's Book", unit_price: 2400)
    @item2 = @merchant1.items.create!(name: "Go to Sleep Please, Mommy Just Wants to Watch Leno", description: "Baby Book", unit_price: 1500)
    @item3 = @merchant2.items.create!(name: "There ARE More Than Seven Animals But This is a Good Start", description: "Educational Children's Book", unit_price: 2100)
    @mary = Customer.create!(first_name: "Mary", last_name: "Mommy")
    @daniel = Customer.create!(first_name: "Daniel", last_name: "Daddy")
    @annie = Customer.create!(first_name: "Annie", last_name: "Auntie")
    @invoice1 = @mary.invoices.create!(status: 2)
    @invoice2 = @daniel.invoices.create!(status: 2)
    @invoice3 = @annie.invoices.create!(status: 2)
    @invoiceitem1 = InvoiceItem.create!(item: @item1, invoice: @invoice1, quantity: 1, unit_price: @item1.unit_price, status: 0 )
    @invoiceitem2 = InvoiceItem.create!(item: @item2, invoice: @invoice1, quantity: 2, unit_price: @item2.unit_price, status: 0 )
    @invoiceitem3 = InvoiceItem.create!(item: @item1, invoice: @invoice2, quantity: 1, unit_price: @item1.unit_price, status: 0 )
    @invoiceitem4 = InvoiceItem.create!(item: @item3, invoice: @invoice3, quantity: 1, unit_price: @item3.unit_price, status: 0 )
    @invoiceitem5 = InvoiceItem.create!(item: @item3, invoice: @invoice1, quantity: 1, unit_price: @item1.unit_price, status: 0 )

  end

  it 'displays the id/status/date/customer name related to the invoice' do
    visit "/merchants/#{@merchant1.id}/invoices/#{@invoice1.id}"

    expect(page).to have_content("Invoice ##{@invoice1.id}")
    expect(page).to have_content("Status: In Progress")
    expect(page).to have_content("Created on: #{@invoice1.created_at.strftime('%A, %B%e, %Y')}")
    expect(page).to have_content("Customer: #{@mary.first_name} #{@mary.last_name}")
  end

  it 'display name/quantity/price/status for all invoice items' do
    visit "/merchants/#{@merchant1.id}/invoices/#{@invoice1.id}"
    
    expect(page).to have_content(@item1.name)
    expect(page).to have_content(@item2.name)
    expect(page).to_not have_content(@item3.name)
    expect(page).to have_content(@invoiceitem1.quantity)
    expect(page).to have_content(@invoiceitem2.quantity)
    expect(page).to have_content(@item1.unit_price)
    expect(page).to have_content(@item2.unit_price)
    expect(page).to have_content(@invoiceitem1.status)
    expect(page).to have_content(@invoiceitem2.status)
  end

  it 'display the total revenue for items sold on this invoice' do
    visit "/merchants/#{@merchant1.id}/invoices/#{@invoice1.id}"

    expect(page).to have_content("Total Revenue: $54.00")
  end

end