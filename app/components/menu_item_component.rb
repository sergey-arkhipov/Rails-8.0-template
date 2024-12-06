class MenuItemComponent < ViewComponent::Base
  def initialize(path: "#", image: "", title: "Title")
    @path = path
    @image = image
    @title = title
  end
end
