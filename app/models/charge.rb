class Charge < ApplicationRecord
  belongs_to :note
  belongs_to :user
  def save_with_payment
    if valid?
      customer = Stripe::Customer.create({
        email: params[:stripeEmail],
        source: params[:stripeToken],
      })
      self.stripe_customer_token = customer.id
      self.note.update_attribute(customer_id: customer.id)
      charge = Stripe::Charge.create({
      customer: customer.id,
      amount: @amount,
      description: 'Rails Stripe customer',
      currency: 'usd',
     })
    end
    rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to new_charge_path
    flash[:notice] = "Please try again"
    end
end
