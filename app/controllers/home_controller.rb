class HomeController < ApplicationController
  protect_from_forgery except: :pay

  def top
  end

  def pay
     Payjp.api_key = ENV["TEST_SECKEY"]

    token =Payjp::Token.create(
    :card => {
    :number => params[:number],
    :cvc => params[:cvc],
    :exp_month => params[:exp_month],
    :exp_year => params[:exp_year]
  }
)

    charge = Payjp::Charge.create(
      :amount => 10000,
      :card => token.id,
      :currency => 'jpy',
    )

    redirect_to "/home/top"

    flash[:notice] = "支払い完了"

  end
end
