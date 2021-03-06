require 'rails_helper'

RSpec.describe "location_rels/edit", :type => :view do
  before(:each) do
    @location_rel = assign(:location_rel, LocationRel.create!(
      :unit_id => 1,
      :location_id => 1
    ))
  end

  it "renders the edit location_rel form" do
    render

    assert_select "form[action=?][method=?]", location_rel_path(@location_rel), "post" do

      assert_select "input#location_rel_unit_id[name=?]", "location_rel[unit_id]"

      assert_select "input#location_rel_location_id[name=?]", "location_rel[location_id]"
    end
  end
end
