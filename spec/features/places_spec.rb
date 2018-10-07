require 'rails_helper'

describe "Places" do
  it "if one is returned by the API, it is shown at the page" do
    allow(BeermappingApi).to receive(:places_in).with("kumpula").and_return(
      [ Place.new( name:"Oljenkorsi", id: 1 ) ]
    )

    visit places_path
    fill_in('city', with: 'kumpula')
    click_button "Search"

    expect(page).to have_content "Oljenkorsi"
  end

  it "if multiple are returned by the API, all of them are shown on the page" do
    allow(BeermappingApi).to receive(:places_in).with("kumpula").and_return(
      [ Place.new( name:"paikka1", id: 1 ), Place.new( name:"paikka2", id: 2 ), Place.new( name:"paikka3", id: 3 ), Place.new( name:"paikka4", id: 4 ), Place.new( name:"paikka5", id: 5 )]
    )

    visit places_path
    fill_in('city', with: 'kumpula')
    click_button "Search"

    [1,2,3,4,5].each do |n|
      expect(page).to have_content "paikka#{n}"
    end
  end

  it "if none are returned by the API, a no results message is shown" do
    allow(BeermappingApi).to receive(:places_in).with("kumpula").and_return(
      []
    )
    visit places_path
    fill_in('city', with: 'kumpula')
    click_button "Search"
    expect(page).to have_content "No locations in kumpula"
  end
end