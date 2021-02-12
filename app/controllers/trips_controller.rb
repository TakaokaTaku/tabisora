class TripsController < ApplicationController
  before_action :correct_user,   only: [:show, :create, :update, :destroy]

  def index
    if params[:title].present?
      @trips = Trip.where('title LIKE ?', "%#{params[:title]}%")
                   .and(Trip.where(user_id: current_user.id))
                   .paginate(page: params[:page], per_page: 9)
    else
      @trips = Trip.where(user_id: current_user.id)
                   .paginate(page: params[:page], per_page: 9)
    end
  end

  def show
    @trip = Trip.find(params[:id])
    @images = @trip.images.order("created_at DESC")
                   .paginate(page: params[:page], per_page: 9)
  end

  def new
    @trip = current_user.trips.build
  end

  def create
    @trip = current_user.trips.build(trip_params)
    if @trip.save
      flash[:success] = "投稿しました。"
      redirect_to @trip
    else
      render 'new'
    end
  end

  def update
    @trip = current_user.trips.find_by(id: params[:id])
    if params[:trip][:images].present?
      unless @trip.images.attach(params[:trip][:images])
        flash[:danger] = "有効な画像形式にしてください。"
        redirect_to @trip
      end
    end
    if @trip.update(params.require(:trip).permit(:title))
      flash[:success] = "内容を変更しました。"
      redirect_to @trip
    else
      flash[:danger] = "100文字以内のタイトルを入力してください。"
      redirect_to @trip
    end
  end

  def destroy_image
    @trip = current_user.trips.find_by(id: params[:id])
    if params[:trip] && params[:trip][:image_ids]
      params[:trip][:image_ids].each do |image_id|
        image = @trip.images.find(image_id)
        image.destroy
      end
      flash[:success] = "写真を削除しました。"
      redirect_to (@trip) and return
    end
    flash[:danger] = "削除する写真を選択してください。"
    redirect_to (@trip)
  end

  def destroy
    Trip.find(params[:id]).destroy
    flash[:success] = "投稿を消去しました"
    redirect_to trips_path
  end

  private

  def trip_params
    params.require(:trip).permit(:title, images: [])
  end

  def correct_user
    @trip = current_user.trips.find_by(id: params[:id])
    redirect_to root_url if @trip.nil?
  end

end
