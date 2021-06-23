class ApplicationController < ActionController::API
rescue_from ActiveRecord::RecordNotFound, with: :no_record

    def no_record
      render json: {error: "No records matched the given search"}
    end
    
end
