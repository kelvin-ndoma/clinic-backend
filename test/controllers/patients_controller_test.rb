require "test_helper"

class PatientsControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get patients_create_url
    assert_response :success
  end

  test "should get show" do
    get patients_show_url
    assert_response :success
  end

  test "should get appointments" do
    get patients_appointments_url
    assert_response :success
  end
end
