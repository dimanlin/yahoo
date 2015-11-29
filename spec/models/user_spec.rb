require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { FactoryGirl.create(:user) }

  describe '.portfolio_price' do
    before do
      @stock_goog = FactoryGirl.create(:stock_goog, user_id: user.id)
    end

    it 'check price GOOG on 2015-11-25' do
      expect(user.portfolio_price.select {|a| a.first == "2015-11-25"}.last).to eq(["2015-11-25", 7481.5002])
    end
  end

  describe '.update_password!' do
    context 'success' do
      before do
        user.update_password!('root0000', 'new_password', 'new_password')
      end

      it 'change password' do
        expect(user.valid_password?('new_password')).to be true
      end
    end

    context 'current_password unvalid' do
      before do
        user.update_password!('wrong_current_password', 'new_password', 'new_password')
      end

      it 'wrong current_password' do
        expect(user.errors.messages).to eq({:current_password=>["не верный."]})
      end
    end

    context 'current_password valid but invalid confirm_password' do
      before do
        user.update_password!('root0000', 'new_password', 'vrong_password')
      end

      it 'wrong password_confirmation' do
        expect(user.errors.messages).to eq({:password_confirmation => ["не совпадает со значением поля Новый пароль"]})
      end
    end
  end

  describe '.add_stocks' do
    context 'if user already have that type stock' do
      context 'and new stock valid' do

        before do
          @stock_goog = FactoryGirl.create(:stock_goog, user_id: user.id)
          user.add_stocks({ name: @stock_goog.name, num: 10, user_id: user.id })
        end

        it 'user have get 20 stocks' do
          expect(user.reload.stocks.take.num).to eq(20)
        end
      end

      context 'and new stock invalid' do
        before do
          @stock_goog = FactoryGirl.create(:stock_goog, user_id: user.id)
          user.add_stocks({ name: @stock_goog.name, num: 10 })
        end

        it 'user have get 10 stocks' do
          expect(user.reload.stocks.take.num).to eq(10)
        end
      end
    end

    context "if user dos't have that type of stock" do
      before do
        user.add_stocks({ name: "GOOG", num: 10, user_id: user.id })
      end

      it 'user have only one type of stock' do
        expect(user.stocks.count).to eq(1)
      end

      it 'check attributes for stock' do
        expect(user.stocks.take.name).to eq('GOOG')
        expect(user.stocks.take.num).to eq(10)
      end
    end
  end
end
