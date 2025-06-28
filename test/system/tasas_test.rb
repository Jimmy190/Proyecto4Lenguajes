require "application_system_test_case"

class TasasTest < ApplicationSystemTestCase
  setup do
    @tasa = tasas(:one)
  end

  test "visiting the index" do
    visit tasas_url
    assert_selector "h1", text: "Tasas"
  end

  test "should create tasa" do
    visit tasas_url
    click_on "New tasa"

    fill_in "Nombre", with: @tasa.nombre
    fill_in "Porcentaje", with: @tasa.porcentaje
    click_on "Create Tasa"

    assert_text "Tasa was successfully created"
    click_on "Back"
  end

  test "should update Tasa" do
    visit tasa_url(@tasa)
    click_on "Edit this tasa", match: :first

    fill_in "Nombre", with: @tasa.nombre
    fill_in "Porcentaje", with: @tasa.porcentaje
    click_on "Update Tasa"

    assert_text "Tasa was successfully updated"
    click_on "Back"
  end

  test "should destroy Tasa" do
    visit tasa_url(@tasa)
    click_on "Destroy this tasa", match: :first

    assert_text "Tasa was successfully destroyed"
  end
end
