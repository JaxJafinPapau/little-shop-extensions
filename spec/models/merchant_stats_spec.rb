require 'rails_helper'

RSpec.describe 'when we visit a merchant show page' do
  before :each do
    @u16 = User.create(name: "Madelon Hicken",street_address: "3830 Becker Trail",city: "Saint Louis",state: "Missouri",zip_code: "63116",email_address: "mhickenf@unesco.org",password:"q9qDA9PA", enabled: true, role:0)
    @u17 = User.create(name: "Leanor Dencs",street_address: "1 Cody Lane",city: "Fresno",state: "Nevada",zip_code: "89502",email_address: "ldencsg@mozilla.com",password:"KPI7nrZoA", enabled: true, role:0)
    @u18 = User.create(name: "Aleta Gemnett",street_address: "7 Norway Maple Avenue",city: "Fresno",state: "California",zip_code: "93722",email_address: "agemnetth@bloglines.com",password:"mFvAX7nP", enabled: true, role:0)
    @u19 = User.create(name: "Vere Armin",street_address: "8954 Northridge Circle",city: "Minneapolis",state: "Minnesota",zip_code: "55407",email_address: "varmini@a8.net",password:"sBAIMwr", enabled: true, role:0)
    @u20 = User.create(name: "Shawn Goosnell",street_address: "06366 Veith Avenue",city: "Harrisburg",state: "Pennsylvania",zip_code: "17104",email_address: "sgoosnellj@hubpages.com",password:"BiGRBWYs", enabled: true, role:0)
    @u21 = User.create(name: "Abby Stedell",street_address: "0383 Shasta Circle",city: "Miami",state: "California",zip_code: "33127",email_address: "astedellk@yelp.com",password:"zVstAHzK", enabled: true, role:0)

    @umerch = User.create(name: "Ondrea Chadburn",street_address: "6149 Pine View Alley",city: "Wichita Falls",state: "Texas",zip_code: "76301",email_address: "ochadburn0@washingtonpost.com",password:"EKLr4gmM44", enabled: true, role:1)

    @i8 = @umerch.items.create(item_name: "Four Roses Single Barrel",image_url: "https://www.totalwine.com/media/sys_master/twmmedia/h2d/h6e/11152774365214.png",current_price: 43.0,inventory: 30, description:"Dried spice, pear, cocoa, vanilla & maple syrup. Hints of ripe plum & cherries, robust, full body, mellow. Smooth & delicately long.",enabled: true)
    @i15 = @umerch.items.create(item_name: "Jack Daniels Single Barrel Heritage Barrel",image_url: "http://s3.amazonaws.com/mscwordpresscontent/wa/wp-content/uploads/2018/11/Jack-Daniels-Heritage.png",current_price: 65.0,inventory: 33, description:"Tennessee- A delicious and complex whiskey. Barreled in heavy-toast barrels and bottled at 100 proof. Notes of baking spices, vanilla, and toasted oak. Long, lingering finish.",enabled: true)
    @i24 = @umerch.items.create(item_name: "Little Book Chapter 2 'Noe Simple Task'",image_url: "http://s3.amazonaws.com/mscwordpresscontent/wa/wp-content/uploads/2018/11/Little-Book-Noe-Simple.png",current_price: 100.0,inventory: 40, description:"Blend of whiskeys from Jim Beam and Canadian distilleries owned by Beam Suntory",enabled: true)

    @o1 = @u16.orders.create(status: 2)
    @o2 = @u16.orders.create(status: 2)
    @o3 = @u17.orders.create(status: 2)
    @o4 = @u17.orders.create(status: 2)
    @o5 = @u17.orders.create(status: 2)
    @o6 = @u18.orders.create(status: 2)
    @o7 = @u19.orders.create(status: 2)
    @o8 = @u20.orders.create(status: 2)
    @o9 = @u21.orders.create(status: 2)

    @oi1 = OrderItem.create(order_id: @o1.id,item_id: @i8.id, quantity: 4,fulfilled: true,order_price: 10.0,created_at: "2018-04-05 11:50:20",updated_at: "2018-04-13 13:08:43")
    @oi2 = OrderItem.create(order_id: @o2.id,item_id: @i15.id, quantity: 6,fulfilled: true,order_price: 10.0,created_at: "2018-04-05 11:50:20",updated_at: "2018-04-13 13:08:43")
    @oi3 = OrderItem.create(order_id: @o3.id,item_id: @i24.id, quantity: 8,fulfilled: true,order_price: 10.0,created_at: "2018-04-05 11:50:20",updated_at: "2018-04-13 13:08:43")
    @oi4 = OrderItem.create(order_id: @o4.id,item_id: @i8.id, quantity: 10,fulfilled: true,order_price: 10.0,created_at: "2018-04-05 11:50:20",updated_at: "2018-04-13 13:08:43")
    @oi5 = OrderItem.create(order_id: @o5.id,item_id: @i15.id, quantity: 12,fulfilled: true,order_price: 10.0,created_at: "2018-04-05 11:50:20",updated_at: "2018-04-13 13:08:43")
    @oi6 = OrderItem.create(order_id: @o6.id,item_id: @i24.id, quantity: 14,fulfilled: true,order_price: 10.0,created_at: "2018-04-05 11:50:20",updated_at: "2018-04-13 13:08:43")
    @oi7 = OrderItem.create(order_id: @o7.id,item_id: @i8.id, quantity: 16,fulfilled: true,order_price: 10.0,created_at: "2018-04-05 11:50:20",updated_at: "2018-04-13 13:08:43")
    @oi8 = OrderItem.create(order_id: @o8.id,item_id: @i15.id, quantity: 18,fulfilled: true,order_price: 10.0,created_at: "2018-04-05 11:50:20",updated_at: "2018-04-13 13:08:43")
    @oi9 = OrderItem.create(order_id: @o9.id,item_id: @i24.id, quantity: 20,fulfilled: true,order_price: 10.0,created_at: "2018-04-05 11:50:20",updated_at: "2018-04-13 13:08:43")
  end

  describe 'self.top_three_states' do
    it 'lists top 3 states by quantity sold' do
      expect(User.top_three_states.first.state).to eq("California")
      expect(User.top_three_states.first.sum).to eq(34)
      expect(User.top_three_states.second.state).to eq("Nevada")
      expect(User.top_three_states.second.sum).to eq(30)
      expect(User.top_three_states.third.state).to eq("Pennsylvania")
      expect(User.top_three_states.third.sum).to eq(18)
    end
  end

  describe 'self.top_three_city_states' do
    it 'lists top 3 city, states by quantity sold' do
      expect(User.top_three_city_states.first.citystate).to eq("Fresno, Nevada")
      expect(User.top_three_city_states.first.sum).to eq(30)
      expect(User.top_three_city_states.second.citystate).to eq("Miami, California")
      expect(User.top_three_city_states.second.sum).to eq(20)
      expect(User.top_three_city_states.third.citystate).to eq("Harrisburg, Pennsylvania")
      expect(User.top_three_city_states.third.sum).to eq(18)
    end
  end



  describe "self.three_fastest" do
    xit "lists top 3 merchants by speed of fulfillment" do
      expect(User.three_fastest.first.name).to eq("")
      expect(User.three_fastest.first.TIME).to eq()
      expect(User.three_fastest.second.name).to eq("")
      expect(User.three_fastest.second.TIME).to eq()
      expect(User.three_fastest.third.name).to eq("")
      expect(User.three_fastest.third.TIME).to eq()
    end
  end

  describe "self.three_slowest" do
    xit "lists bottom 3 merchants by speed of fulfillment or lack thereof" do
      expect(User.three_slowest.first.name).to eq("")
      expect(User.three_slowest.first.TIME).to eq()
      expect(User.three_slowest.second.name).to eq("")
      expect(User.three_slowest.second.TIME).to eq()
      expect(User.three_slowest.third.name).to eq("")
      expect(User.three_slowest.third.TIME).to eq()
    end
  end

  describe "self.top_three_states_overall" do
    it "lists top 3 states overall by order count" do
      expect(User.top_three_states_overall.first.state).to eq("")
      expect(User.top_three_states_overall.first.sum).to eq()
      expect(User.top_three_states_overall.second.state).to eq("")
      expect(User.top_three_states_overall.second.sum).to eq()
      expect(User.top_three_states_overall.third.state).to eq("")
      expect(User.top_three_states_overall.third.sum).to eq()
    end
  end

  describe "self.top_three_city_states_overall" do
    xit "lists top 3 city,states overall by order count" do
      expect(User.top_three_city_states_overall.first.citystate).to eq("")
      expect(User.top_three_city_states_overall.first.sum).to eq()
      expect(User.top_three_city_states_overall.second.citystate).to eq("")
      expect(User.top_three_city_states_overall.second.sum).to eq()
      expect(User.top_three_city_states_overall.third.citystate).to eq("")
      expect(User.top_three_city_states_overall.third.sum).to eq()
    end
  end

  describe "self.three_biggest_orders" do
    xit "lists top 3 biggest orders" do
      expect(User.three_biggest_orders.first.order_id).to eq("")
      expect(User.three_biggest_orders.first.count).to eq()
      expect(User.three_biggest_orders.second.order_id).to eq("")
      expect(User.three_biggest_orders.second.count).to eq()
      expect(User.three_biggest_orders.third.order_id).to eq("")
      expect(User.three_biggest_orders.third.count).to eq()
    end
  end
end
