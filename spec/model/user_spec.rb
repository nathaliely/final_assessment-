require 'rails_helper'

RSpec.describe User, type: :model do

  # testing active record associations using shoulda-matchers
  context "active record associations " do
    it { is_expected.to have_many(:items) }
  end

  # testing validations using shoulda-matchers
  context "validations" do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:email) }

    # testing emails with correct and incorrect values
    it { is_expected.to allow_value("good@email.com").for(:email) }
    # it { is_expected.not_to allow_value("bad@email").for(:email) }
  end
end
