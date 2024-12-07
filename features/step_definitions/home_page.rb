Пусть(/^пользователь запустил приложение$/i) do
  visit root_path
end

Тогда(/^отображаются пункты меню:$/i) do |menu_items|
  menu_items.raw.flatten.each do |item|
    expect(page).to have_link(item)
  end
end

Тогда(/^логотип с надписью "([^"]*)"$/i) do |logo_name|
  expect(page).to have_content(logo_name)
end

Когда(/^пользователь нажимает на аватар$/) do
  find_by_id("user_avatar").click
end
