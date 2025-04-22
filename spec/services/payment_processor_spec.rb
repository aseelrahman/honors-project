# spec/services/payment_processor_spec.rb
require 'rails_helper'

RSpec.describe PaymentProcessor do
  let(:booking) { create(:booking) }
  let(:payment) { create(:payment, booking: booking, amount: 1000) }
  let(:processor) { described_class.new(payment) }
  
  describe '#process' do
    context 'when payment is successful' do
      before do
        allow(processor).to receive(:simulate_stripe_payment).and_return(true)
      end
      
      it 'updates payment status to completed' do
        processor.process
        expect(payment.reload.status).to eq('completed')
      end
      
      it 'updates booking status to confirmed' do
        processor.process
        expect(booking.reload.status).to eq('confirmed')
      end
      
      it 'calculates platform fee and photographer payout' do
        processor.process
        expect(payment.reload.platform_fee).to eq(200)
        expect(payment.reload.photographer_payout).to eq(800)
      end
      
      it 'sends notification emails' do
        expect(PaymentMailer).to receive(:payment_confirmation).and_return(double(deliver_later: true))
        expect(PaymentMailer).to receive(:booking_notification).and_return(double(deliver_later: true))
        processor.process
      end
      
      it 'returns true' do
        expect(processor.process).to be true
      end
    end
    
    context 'when payment fails' do
      before do
        allow(processor).to receive(:simulate_stripe_payment).and_return(false)
      end
      
      it 'updates payment status to failed' do
        processor.process
        expect(payment.reload.status).to eq('failed')
      end
      
      it 'returns false' do
        expect(processor.process).to be false
      end
    end
  end
end