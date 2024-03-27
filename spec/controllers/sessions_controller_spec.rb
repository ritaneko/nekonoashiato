require 'rails_helper'

RSpec.describe Public::SessionsController,"ログインに関するテスト", type: :controller do
  before do
    @user = FactoryBot.create(:user)
  end


end