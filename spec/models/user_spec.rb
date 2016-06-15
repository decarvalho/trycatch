require 'rails_helper'
require 'spec_helper'

RSpec.describe User, :type => :model do
  context "user is default role for User model" do
    it "admin is not the default role" do
      user = User.new
      user.save
      expect(user.admin?).to be false
    end

    it "admin is super user of the User model" do
      user = User.new
      user.role = :admin
      user.save
      expect(user.admin?).to be true
    end
  end
end
