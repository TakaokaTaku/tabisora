class StaticPagesController < ApplicationController
  def home
    if user_signed_in?
      if params[:title].present?
        @trips = Trip.where('title LIKE ?', "%#{params[:title]}%")
                     .or(Trip.where('address LIKE ?', "%#{params[:title]}%"))
                     .and(Trip.where(user_id: current_user.id))
                     .paginate(page: params[:page], per_page: 9)
      else
        @trips = Trip.where(user_id: current_user.id)
                     .paginate(page: params[:page], per_page: 9)
      end
    end
  end

  def help
  end

  def about
  end

  def contact
  end

  def search
  end
end
