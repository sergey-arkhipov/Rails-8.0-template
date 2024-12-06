require "rails_helper"

RSpec.describe MenuItemComponent, type: :component do
  before { render_inline(described_class.new(title: "Это пункт меню", image: "bar.svg", path: "/home/index.html")) }

  it "renders title menu item" do
    expect(page).to have_text "Это пункт меню"
  end

  it "renders path for menu item" do
    expect(page).to have_link(href: "/home/index.html")
  end

  it "renders image for menu item" do
    expect(page).to have_css("img[src*=bar-]")
  end
end
