require 'rails_helper'

RSpec.describe JsonWebToken do
  subject { JsonWebToken }

  before :each do
    Timecop.freeze(Time.now)
  end

  let(:payload) { { user_id: 1, exp: 24.hours.from_now.to_i } }

  describe '::encode' do
    it 'should call JWT.encode method' do
      expect(JWT).to receive(:encode).with(payload, Rails.application.secrets.secret_key_base)
      subject.encode(user_id: 1)
    end
  end

  describe '::decode' do
    let(:token){ subject.encode(user_id: 1) }

    it 'should call JWT.decode method' do
      expect(JWT).to receive(:decode).with(token, Rails.application.secrets.secret_key_base).and_call_original
      subject.decode(token)
    end

    it 'should return nil if token is invalid' do
      expect(subject.decode('invalidToken')).to be_nil
    end
  end
end
