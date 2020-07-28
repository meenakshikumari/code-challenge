require "test_helper"

class CompanyTest < ActiveSupport::TestCase

	def setup
    @company = companies(:hometown_painting)
  end

  test "name should be present" do
  	@company.name = nil
  	assert_not @company.save

  	@company.name = "Test"
  	assert @company.save
  end

	test "zipcode must be valid" do
    @company.zip_code = nil
    assert_not @company.save

    @company.zip_code = "abc"
    assert_not @company.save

    @company.zip_code = "1234"
    assert_not @company.save

    @company.zip_code = "1005678"
    assert_not @company.save

    @company.zip_code = "30331"
    assert @company.save
  end

  test "allow blank email" do
		@company.email = nil
		assert @company.save
  end

  test "email should have getmainstreet.com email domain" do
		@company.email = "hello@example.com"
		assert_not @company.save

		@company.email = "check@getmainstreet.com"
		assert @company.save
  end

  test "should create city and state" do
		@company.zip_code = "10021"
    @company.save
    assert_not_nil @company.city
    assert_not_nil @company.state
  end

  test "should change city and state when zip code changes" do
    @company.save
    old_city = @company.city
    old_state = @company.state

    @company.zip_code = "10021"
    @company.save

    assert_not_equal  old_city, @company.city
    assert_not_equal  old_state, @company.city
  end
end