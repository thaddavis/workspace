require 'test_helper'

class ChefTest < ActiveSupport::TestCase

  def setup
    @chef = Chef.new(chefname: "jjj", email: "j@j.com")
  end

  test "chef should be valid" do
    assert @chef.valid?
  end

  test "chefname should be present" do
    @chef.chefname = ""
    assert_not @chef.valid?
  end

  test "chefname should not be too long" do
    @chef.chefname = "a" * 41
    assert_not @chef.valid?
  end

  test "chefname should not be too short" do
    @chef.chefname = "a" * 2
    assert_not @chef.valid?
  end

  test "email should be present" do
    @chef.email = ""
    assert_not @chef.valid?
  end

  test "email should be within bounds" do
    @chef.email = "a" * 101 + "example.com"
    assert_not @chef.valid?
  end

  test "email address should be unique" do
    dup_chef = Chef.new(chefname: "jjj", email: "j@j.com")
    @chef.save
    assert_not dup_chef.valid?
  end

  test "accept valid email addresses" do
    valid_addresses = %w[user@eee.com R_TDD-DS@eee.tht.org]
    valid_addresses.each do |a|
      @chef.email = a
      assert @chef.valid?, '#{a.inspect} should be valid'
    end
  end

  test "reject invalid email addresses" do
    valid_addresses = %w[user@eeecom R_TDD-DSeee.tht.org]
    valid_addresses.each do |a|
      @chef.email = a
      assert_not @chef.valid?, '#{a.inspect} should be invalid'
    end
  end

end
