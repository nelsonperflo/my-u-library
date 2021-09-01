require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  # def setup
  #   @role = roles(:student)
  # end

  # test "invalid information" do
  #   get new_user_path
  #   assert_no_difference 'User.count' do
  #     post users_path, params: { user: { first_name:  "",
  #                                        last_name: "",
  #                                        email: "user@invalid",
  #                                        password:              "foo",
  #                                        password_confirmation: "bar",
  #                                        role: "" } }
  #   end
  #   assert_equal "/users", path
  #   assert_select 'div#error_explanation'
  #   assert_select 'div.field_with_errors'
  # end

  # test "valid information" do
  #   get new_user_path
  #   assert_difference 'User.count', 0 do
  #     post users_path, params: { user: { first_name:  "Example",
  #                                        last_name: "User",
  #                                        email: "example_user@example.com",
  #                                        password:              "Fargo01$-",
  #                                        password_confirmation: "Fargo01$-",
  #                                        role_id: @role.id } }
  #   end
  #   user = @controller.view_assigns['user']
  #   assert_equal "/users/#{user.id}", path
  # end
end
