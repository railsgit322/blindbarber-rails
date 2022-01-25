class UniversalLinksController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  def index
	render layout: false
  end

  def apple_site_assoc

	paths = ["/*"]
	appID = "95JG2MWZX2.com.blindbarber"

	render content_type: 'application/pkcs7-mime', # 'application/json',
	  json: {
		applinks: {
		  apps: [],
		  details: [
			{
			  appID: appID,
			  paths: paths
			}
		  ]
		},
		webcredentials: {
		  apps: [appID]
		}
	  }
  end

end