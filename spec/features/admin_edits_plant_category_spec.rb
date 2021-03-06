# As an admin
# In order to facilitate users plant selection process
# I want to manage plant categories

# Acceptance Criteria:
# * Name, and edibility are required

# Usage:
# * From home screen, click "Manage Plant Categories", click on an existing category name
# * Edit the category information
# * You should be redirected to plant categories list and the updated information should be in the list

# (Note: This story was split from #1)

feature "Update a plant category" do

  background do
    @tomato = Fabricate(:category, name: "tomato", edible: true)
  end

  scenario "Regular users can't access editing categories" do
    login_as Fabricate(:user)
    visit edit_admin_category_path(@tomato)
    page.should have_content("You are not authorized to view that page.")
    current_path.should == gardens_path
  end

  scenario "Happy path, user successfully updates plant category." do
    login_as Fabricate(:admin)
    visit '/'
    click_on "Manage Plant Categories"
    click_link "tomato"
    click_on "Edit Plant Category"
    fill_in "Name", with: "Fruit"
    check "Edible"
    click_on "Update Plant Category"
    page.should have_content("The Fruit category has been updated.")
    current_path.should == admin_categories_path
  end

  scenario "Sad path, plant category name is blank and is not updated." do
    login_as Fabricate(:admin)
    visit '/'
    click_on "Manage Plant Categories"
    click_link "tomato"
    click_on "Edit Plant Category"
    fill_in "Name", with: ""
    click_on "Update Plant Category"
    page.should have_content("Your changes could not be saved.")
    current_path.should == admin_category_path(@tomato)
  end
end
