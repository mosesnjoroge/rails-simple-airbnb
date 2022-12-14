class FlatsController < ApplicationController
  before_action :set_flat, except: %i[index new create]
  def index
    if params[:query].present?
      @query = params[:query]
      @flats = Flat.where('name LIKE ?', "%#{params[:query]}%")
    else
      @flats = Flat.all
    end
  end

  def show; end

  def new
    @flat = Flat.new
  end

  def create
    @flat = Flat.new(flat_params)
    if @flat.save
      redirect_to flat_path(@flat), notice: 'flat was successfully created'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    @flat.update(flat_params)
    @flat.save
    redirect_to flat_path(@flat), notice: 'flat was successfully updated'
  end

  def destroy
    @flat.destroy
    redirect_to flats_path, notice: 'flat was successfully deleted'
  end

  private

  def set_flat
    @flat = Flat.find(params[:id])
  end

  def flat_params
    params.require(:flat).permit(:name, :address, :description, :price_per_night, :number_of_guests, :picture_url)
  end
end
