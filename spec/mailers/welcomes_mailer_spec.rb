require 'rails_helper'

RSpec.describe WelcomeMailer do
  let(:user) { create(:user, :with_profile) }
  let(:user_without_profile) { create(:user) }

  context 'when send Welcome e-mails' do
    it 'and valid informations has been sent' do
      email = WelcomeMailer.send_email(user)

      expect(email.from).to eq ['contato@spacedevs.com.br']
      expect(email.to).to eq [user.email_address]
      expect(email.subject).to eq "Boas vindas #{user.profile.first_name} 🧸"
      expect(email.body.to_s).to be_blank
    end

    it 'sent successfully' do
      expect do
        WelcomeMailer.send_email(user).deliver_later
      end.to have_enqueued_mail(WelcomeMailer, :send_email).with(user).once
    end

    it 'e-mail cannot be sent because there is no user profile' do
      expect do
        WelcomeMailer.send_email(user_without_profile).deliver_later
      end.not_to have_enqueued_mail(WelcomeMailer, :send_email).with(user).once
    end

    it 'returns nil when there is no user profile' do
      allow(WelcomeMailer).to receive(:send_email).with(user_without_profile).and_return(double(deliver_now: false))

      send_email = WelcomeMailer.send_email(user_without_profile).deliver_now

      expect(send_email).to be_falsey
      expect(WelcomeMailer).to have_received(:send_email).with(user_without_profile).exactly(1).times
      expect do
        send_email
      end.not_to have_enqueued_mail(WelcomeMailer, :send_email)
    end
  end
end
