# As a User
# In order for user to be aware of all varieties of a plant
# I want to view a specific plant variety
#
# Acceptance Criteria:
#
#     The view page will list the name, images, description, and Amazon URL for variety
#
# Usage:
#
#     User will click "Plants", select a specific Plant Category, then click a specific plant
#     User will be greeted with a short profile of the variety including:
#         Name
#         Description
#         Images
#         Amazon URL

feature "User views a specific plant variety" do
  background do
    @potato = Fabricate(:category, name: "Potato", edible: true)
    @category_id = Category.find_by(id: @potato.id)
    @yukon = Fabricate(:variety, name: "Yukon", description: "Not Cornelius", category: @category_id)

    visit categories_path
    click_link "Potato"
    click_link "Yukon"
  end

  scenario "displays details of a plant variety" do
    page.should have_content("Yukon")
    page.should have_content("Not Cornelius")
    current_path.should eq edit_category_variety_path(@category_id, @yukon.id)
  end
end
