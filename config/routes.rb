Rails.application.routes.draw do
  root 'students#index'

  get 'year_with_most/men_percentage' => 'students#get_year_with_most_men_percentage'
  get 'women_students/most_popular_age' => 'students#get_women_students_with_most_popular_age'
  get 'women_students/most_popular_names' => 'students#get_most_popular_names_women'
  get 'men_students/most_popular_names' => 'students#get_most_popular_names_men'
  resources :students
end
