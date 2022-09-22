class HospitalLabelsController < ApplicationController
  before_action :set_hospital_label, only: %i[show edit update destroy]
  # before_action :master_required

  def index
    @hospital_labels = HospitalLabel.all.order(name: :asc)
  end

  def new
    @hospital_label = HospitalLabel.new
  end

  def create
    @hospital_label = HospitalLabel.new(hospital_label_params)

    respond_to do |format|
      if @hospital_label.save
        format.html { redirect_to hospital_labels_path, notice: 'Label was successfully created.' }
        format.json { render :index, status: :created, location: @hospital_label }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @hospital_label.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit; end

  def update
    respond_to do |format|
      if @hospital_label.update(hospital_label_params)
        format.html { redirect_to hospital_labels_path, notice: 'Label was successfully updated.' }
        format.json { render :index, status: :ok, location: @hospital_label }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @hospital_label.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @hospital_label.destroy
    respond_to do |format|
      format.html { redirect_to hospital_labels_path, notice: 'Label was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_hospital_label
      @hospital_label = HospitalLabel.find(params[:id])
    end

    def hospital_label_params
      params.require(:hospital_label).permit(:name)
    end
end
