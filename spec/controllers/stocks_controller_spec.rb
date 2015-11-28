require 'rails_helper'

RSpec.describe StocksController, type: :controller do
  let(:user) { FactoryGirl.create(:user) }
  before do
    FactoryGirl.create(:stock_goog, user_id: user.id)
    sign_in user
    get :index
  end

  it 'check result' do
    expect(assigns(:graph_data)).to eq('')
  end
end
