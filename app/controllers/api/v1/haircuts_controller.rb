class Api::V1::HaircutsController < Api::BaseController
	
	
	def index
		
		haircuts = @current_user.haircuts
		

		@haircuts = HaircutBlueprint.render(haircuts)
		
		render json: @haircuts, status: :ok
	end
	
	
	
	def create
		haircut = Haircut.create(haircut_params)
		haircut.user = @current_user
		
		if params[:front_photo].present?
			puts "================= FRONT " + params[:front_photo]
			haircut.remote_front_photo_url = params[:front_photo]
		end
		if params[:side_photo].present?
			haircut.remote_side_photo_url = params[:side_photo]
		end
		if params[:back_photo].present?
			puts "================= Back " + params[:back_photo]
			
			haircut.remote_back_photo_url = params[:back_photo]
		end
		if params[:misc_photo].present?
			puts "================= MISC " + params[:misc_photo]
			haircut.remote_misc_photo_url = params[:misc_photo]
		end
		
		haircut.save!
		
		puts "Params: " + params.inspect
	
		@haircut = HaircutBlueprint.render(haircut)
		render json: @haircut, status: :ok

	
	end
	
	
	private
	def haircut_params
	  params.require(:haircut).permit(:title, :body, :front_photo, :side_photo, :back_photo, :misc_photo)
	end

	
end