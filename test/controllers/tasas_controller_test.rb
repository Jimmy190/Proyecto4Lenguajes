require "test_helper"

class TasasControllerTest < ActionDispatch::IntegrationTest
  setup do
    @tasa = tasas(:one)
  end

  test "should get index" do
    get tasas_url
    assert_response :success
  end

  test "should get new" do
    get new_tasa_url
    assert_response :success
  end

  test "should create tasa" do
    assert_difference("Tasa.count") do
      post tasas_url, params: { tasa: { nombre: @tasa.nombre, porcentaje: @tasa.porcentaje } }
    end

    assert_redirected_to tasa_url(Tasa.last)
  end

  test "should show tasa" do
    get tasa_url(@tasa)
    assert_response :success
  end

  test "should get edit" do
    get edit_tasa_url(@tasa)
    assert_response :success
  end

  test "should update tasa" do
    patch tasa_url(@tasa), params: { tasa: { nombre: @tasa.nombre, porcentaje: @tasa.porcentaje } }
    assert_redirected_to tasa_url(@tasa)
  end

  test "should destroy tasa" do
    assert_difference("Tasa.count", -1) do
      delete tasa_url(@tasa)
    end

    assert_redirected_to tasas_url
  end
end
