require 'test_helper'

class RecipeTest < ActiveSupport::TestCase
  def setup
    @chef = Chef.create(chefname: "jjj", email: "j@j.com")
    @recipe = @chef.recipes.build(name: "Grilled Chicken", summary:"Italian Style", description:"directions come on come on")
  end
  test "recipe should be valid" do
    assert @recipe.valid?
  end
  test "chef_id should be present" do
    @recipe.chef_id = nil
    assert_not @recipe.valid?
  end
  test "recipe name should be present" do
    @recipe.name = ""
    assert_not @recipe.valid?
  end
  test "recipe name should not be too long" do
    @recipe.name = "a" * 101
    assert_not @recipe.valid?
  end
  test "recipe name should not be too short" do
    @recipe.name = "a" * 4
    assert_not @recipe.valid?
  end
  test "recipe summary should be present" do
    @recipe.summary = ""
    assert_not @recipe.valid?
  end
  test "recipe summary should not be too long" do
    @recipe.summary = "a" * 151
    assert_not @recipe.valid?
  end
  test "recipe summary should not be too short" do
    @recipe.summary = "a" * 9
    assert_not @recipe.valid?
  end
  test "recipe description should be present" do
    @recipe.description = ""
    assert_not @recipe.valid?
  end
  test "recipe description should not be too long" do
    @recipe.description = "" * 501
    assert_not @recipe.valid?
  end
  test "recipe description should not be too short" do
    @recipe.description = "" * 19
    assert_not @recipe.valid?
  end
end
