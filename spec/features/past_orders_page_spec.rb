require "rails_helper"

RSpec.describe "Ordering page", type: :feature do
  context "when order is made" do
    let(:user) { create :regular_user }
    let(:order) { create :order }
    let(:address) { build :address }

    it "should sign user in" do
      signin_helper(user.email, user.password)
      order.update_attributes(user: user, address: address)
      click_link "Past Orders"
      expect(page). to have_content "Details"
    end
  end

  context "when no order is made" do
    let(:user) { create :regular_user }

    it "should sign user in" do
      signin_helper(user.email, user.password)

      visit past_orders_path
      expect(page). to have_content "You currently have no Orders"
    end
  end

  describe "#order_page" do
    context "when no orders" do
      let(:user) { create :regular_user }
      it "inform user of having no orders" do
        signin_helper(user.email, user.password)
        visit past_orders_path
        expect(page).to have_content "You currently have no Orders"
      end
    end

    context "when there is at least an order" do
      let(:user) { create :regular_user }
      let(:order) { create :order }
      let(:address) { build :address }
      it "inform user of having no orders" do
        signin_helper(user.email, user.password)
        order.update_attributes(user: user, address: address)
        visit past_orders_path
        expect(page).to have_content "Order Number"
      end
    end
  end
end