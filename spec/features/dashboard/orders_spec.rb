require 'rails_helper'

RSpec.describe 'When I visit the merchant dashboard page' do
  describe 'and click link to view my orders' do
    it 'shows me the correct information' do
      @u10 = User.create(name: "Evelina Nissle",street_address: "2839 Green Circle",city: "Huntington",state: "West Virginia",zip_code: "25701",email_address: "enissle9@taobao.com",password:"ZroVeH", enabled: true, role:1)
      @u7 = User.create(name: "Darnell Topliss",street_address: "02 Monument Street",city: "Lincoln",state: "Nebraska",zip_code: "68515",email_address: "dtopliss6@unicef.org",password:"usJn1CuUB", enabled: true, role:1)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@u7)

      @i19 = @u7.items.create(item_name: "Armorik Double Maturation",image_url: "http://s3.amazonaws.com/mscwordpresscontent/wa/wp-content/uploads/2018/11/Armorik-Double.png",current_price: 60.0,inventory: 33, description:"French Single malt that takes a slightly different route than it's Irish and Scottish cousins and uses new charred oak barrels instead of the more common ex-bourbon barrels.",enabled: true)
      @i23 = @u7.items.create(item_name: "Belle Meade Cask Strength Reserve",image_url: "http://s3.amazonaws.com/mscwordpresscontent/wa/wp-content/uploads/2018/11/Belle-Meade-Cask-Strength.png",current_price: 65.0,inventory: 36, description:"Tennessee- A blend of single barrel bourbons making each batch slightly different. Aged for 7-11 years. Flavors of vanilla, caramel, spice, and stone fruits. Try it neat or on the rocks.",enabled: false)
      @i22 = @u10.items.create(item_name: "1792 Bottled in Bond",image_url: "http://s3.amazonaws.com/mscwordpresscontent/wa/wp-content/uploads/2018/11/1792-Bottled-in-Bond.png",current_price: 36.0,inventory: 29, description:"Kentucky- This bourbon has notes of charred oak and fresh mint. Subtle caramel apple tones are delicately balanced with the lingering essence of coffee and black pepper. Enjoy neat.
      ",enabled: true)

      @u34 = User.create(name: "Jazmin Frederick",street_address: "59 Victoria Lane",city: "Atlanta",state: "Georgia",zip_code: "30318",email_address: "jfrederickx@t-online.de",password:"FZbJe0", enabled: true, role:0)
      @o39 = @u34.orders.create(status: 2)
      @oi171 = OrderItem.create(order_id: @o39.id,item_id: @i19.id, quantity: 7,fulfilled: false,order_price: 53.0,created_at: "2018-04-07 22:05:50",updated_at: "2018-04-17 08:47:14")
      @oi168 = OrderItem.create(order_id: @o39.id,item_id: @i23.id, quantity: 6,fulfilled: false,order_price: 61.0,created_at: "2018-04-05 13:49:11",updated_at: "2018-04-15 18:26:50")
      @oi170 = OrderItem.create(order_id: @o39.id,item_id: @i22.id, quantity: 4,fulfilled: false,order_price: 60.0,created_at: "2018-04-04 00:55:36",updated_at: "2018-04-15 17:09:27")

      visit dashboard_order_path(@o39)

      expect(page).to have_content(@u34.street_address)
      expect(page).to have_content(@u34.city)
      expect(page).to have_content(@u34.state)
      expect(page).to have_content(@u34.zip_code)
      expect(page).to have_content(@u34.name)

      expect(page).to have_link(@i19.item_name)
      expect(page).to have_content(@i19.order_price(@o39))
      expect(page).to have_content(@i19.order_quantity(@o39))

      expect(page).to have_link(@i23.item_name)
      expect(page).to have_content(@i23.order_price(@o39))
      expect(page).to have_content(@i23.order_quantity(@o39))

      expect(page).to_not have_link(@i22.item_name)
      expect(page).to_not have_content(@i22.order_price(@o39))
      expect(page).to_not have_content(@i22.order_quantity(@o39))

    end
  end
end
