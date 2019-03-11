class ChargesController < ApplicationController
  require "stripe"
  Stripe.api_key = Rails.application.secrets.stripe_private_key
  skip_before_action :verify_authenticity_token
  def new
    @note = Note.find_by(id: params[:note_id])
  end

  def create
    @note = Note.find_by(id: params[:note_id])
    @amount = @note.price.to_i
    Stripe.api_key = 'sk_test_03WL0w8AXxhoDzSBOLNXY8C3'
    @payment = Charge.new(params[:charges])
    # render plain: params.inspect
    respond_to do |format|
      if @payment.save_with_payment
        format.html
        format.js { redirect_to @payment, notice: 'Payment was successfully created.' }
        format.json { render json: @payment, status: :created, location: @payment }
      else
        format.html
        format.js { render action: "new" }
        format.json { render json: @payment.errors, status: :unprocessable_entity }
      end
    end
  end
end
