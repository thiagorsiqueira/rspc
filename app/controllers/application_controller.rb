class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
include PublicActivity::StoreController

protect_from_forgery with: :exception


before_action :configure_permitted_parameters, if: :devise_controller?
protected
	def configure_permitted_parameters
		devise_parameter_sanitizer.for(:sign_up) << :gender
		devise_parameter_sanitizer.for(:sign_up) << :name		
		devise_parameter_sanitizer.for(:sign_up) << :avatar
		devise_parameter_sanitizer.for(:sign_up) << :phone
		devise_parameter_sanitizer.for(:sign_up) << :date_birthday
		devise_parameter_sanitizer.for(:sign_up) << :address
		devise_parameter_sanitizer.for(:sign_up) << :neighborhood
		devise_parameter_sanitizer.for(:sign_up) << :city
		devise_parameter_sanitizer.for(:sign_up) << :state
		devise_parameter_sanitizer.for(:sign_up) << :zipcode
		devise_parameter_sanitizer.for(:sign_up) << :complement
		devise_parameter_sanitizer.for(:sign_up) << { ability_ids: [] }
		devise_parameter_sanitizer.for(:sign_up) << { interest_ids: [] }
		devise_parameter_sanitizer.for(:account_update) << :gender
		devise_parameter_sanitizer.for(:account_update) << :name		
		devise_parameter_sanitizer.for(:account_update) << :avatar
		devise_parameter_sanitizer.for(:account_update) << :phone
		devise_parameter_sanitizer.for(:account_update) << :date_birthday
		devise_parameter_sanitizer.for(:account_update) << :address
		devise_parameter_sanitizer.for(:account_update) << :neighborhood
		devise_parameter_sanitizer.for(:account_update) << :city
		devise_parameter_sanitizer.for(:account_update) << :state
		devise_parameter_sanitizer.for(:account_update) << :zipcode
		devise_parameter_sanitizer.for(:account_update) << :complement
		devise_parameter_sanitizer.for(:account_update) << { ability_ids: [] }
		devise_parameter_sanitizer.for(:account_update) << { interest_ids: [] }
	end
end