class HomeController < ApplicationController
  protect_from_forgery except: :pay
  before_action :heroku_pubkey_production?, :heroku_seckey_production?
  def top
  end

  def pay
     Payjp.api_key = @sec_env



    charge = Payjp::Charge.create(
      :amount => 10000,
      :card => payjp_token,
      :currency => 'jpy',
    )

    redirect_to "/home/top"

    flash[:notice] = "支払い完了"

  end

  private

  def heroku_seckey_production?
    if Rails.env.production?
      @sec_env = ENV['HEROKU_TEST_SECKEY']
    else
      @sec_env = ENV['TEST_SECKEY']
    end
  end

  def heroku_pubkey_production?
    if Rails.env.production?
      @pub_env = ENV['HEROKU_TEST_PUBKEY']
    else
      @pub_env = ENV['TEST_PUBKEY']
    end
  end

end
