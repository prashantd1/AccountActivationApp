require 'rails_helper'

describe User, 'User Model Testing' do

  before(:all) do
     @user = build(:user, name: "Example User", email: "user@example.com",
                     password: "foobar", password_confirmation: "foobar")
  end
  
 
  it 'should be valid' do
    expect(@user.valid?).to equal(true)
  end

  it "email should be present" do
    @user.email = "     "
    expect(@user.valid?).to equal(false)
  end

  it "name should not be too long" do
    @user.name = "a" * 51
    expect(@user.valid?).to equal(false)
  end

  it "email should not be too long" do
    @user.email = "a" * 244 + "@example.com"
    expect(@user.valid?).to equal(false)
  end

  it "email addresses should be unique" do
    duplicate_user = @user.dup
    @user.save
    expect(duplicate_user.valid?).to equal(false)
  end

  it "password should be present (nonblank)" do
    @user.password = @user.password_confirmation = " " * 6
    expect(@user.valid?).to equal(false)
  end

  it "password should have a minimum length" do
    @user.password = @user.password_confirmation = "a" * 5
   expect(@user.valid?).to equal(false)
  end
 
end