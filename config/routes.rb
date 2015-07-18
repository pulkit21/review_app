Rails.application.routes.draw do

  scope "/api" do
    resources :merchants, except: [:new, :edit] do
      resources :items, except: [:new, :edit]
      resources :comments, except: [:new, :edit]
    end
  end
end