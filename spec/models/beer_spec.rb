require 'rails_helper'

RSpec.describe Beer, type: :model do
  let(:brewery){ FactoryBot.create(:brewery) }
  
  it "is saved when it has a name, style and a brewery." do
    beer = FactoryBot.create(:beer)
    expect(beer).to be_valid
    expect(Beer.count).to eq(1)
  end

  it "is not created or saved if it has no name" do
    beer = Beer.create style:"style", brewery: brewery
    expect(beer).not_to be_valid
    expect(Beer.count).to eq(0)
  end

  it "is not created or saved if it has not style" do
    beer = Beer.create name:"beer", brewery: brewery
    expect(beer).not_to be_valid
    expect(Beer.count).to eq(0)
  end
end
