class CheckoutController < ApplicationController
  def create

    @total = params[:total].to_d
    @event_id = params[:event_id]

    @session = Stripe::Checkout::Session.create(
      payment_method_types: ['card'],
      line_items: [
        {
          price_data: {
            currency: 'eur',
            unit_amount: (@total*100).to_i,
            product_data: {
              name: 'Rails Stripe Checkout',
            },
          },
          quantity: 1
        },
      ],
      mode: 'payment',
      success_url: checkout_success_url + '?session_id={CHECKOUT_SESSION_ID}',
      cancel_url: checkout_cancel_url,
      metadata: {
        event_id: @event_id
    }
    )
    redirect_to @session.url, allow_other_host: true

  end

  def success
    @session = Stripe::Checkout::Session.retrieve(params[:session_id])
  @payment_intent = Stripe::PaymentIntent.retrieve(@session.payment_intent)
  @user = current_user
  @event_id = @session.metadata.event_id
  
  if @payment_intent.status == 'succeeded'
    attendance = Attendance.new(
      user_id: @user.id, 
      event_id: @event_id, 
      stripe_customer_id: @session.customer
    )
    
    if attendance.save
      # Inscription réussie, redirection avec succès
      redirect_to event_path(@event_id), notice: "Inscription réussie!"
    else
      # Gestion de l'erreur de création
      redirect_to event_path(@event_id), alert: "Erreur lors de la création de l'inscription : #{attendance.errors.full_messages.join(", ")}"
    end
  end
  end

  def cancel
    @session = Stripe::Checkout::Session.retrieve(params[:session_id])
    @payment_intent = Stripe::PaymentIntent.retrieve(@session.payment_intent)
  end

end
