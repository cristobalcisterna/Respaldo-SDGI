class DutyManagersController < ApplicationController
  before_action :set_duty_manager, only: %i[ show edit update destroy ]

  # GET /duty_managers or /duty_managers.json
  def index
    @duty_managers = DutyManager.all
  end

  def show_dutymanager_unit
    @duty_managers = DutyManager.unscoped{DutyManager.where(unit_id: params[:id])}
  end

  # GET /duty_managers/1 or /duty_managers/1.json
  def show
  end

  # GET /duty_managers/new
  def new
    @duty_manager = DutyManager.new
  end

  # GET /duty_managers/1/edit
  def edit
  end

  # POST /duty_managers or /duty_managers.json
  def create
    @duty_manager = DutyManager.new(duty_manager_params)

    respond_to do |format|
      if @duty_manager.save
        format.html { redirect_to @duty_manager, notice: "Duty manager was successfully created." }
        format.json { render :show, status: :created, location: @duty_manager }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @duty_manager.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /duty_managers/1 or /duty_managers/1.json
  def update
    respond_to do |format|
      if @duty_manager.update(duty_manager_params)
        format.html { redirect_to @duty_manager, notice: "Duty manager was successfully updated." }
        format.json { render :show, status: :ok, location: @duty_manager }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @duty_manager.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /duty_managers/1 or /duty_managers/1.json
  def destroy
    @duty_manager.destroy
    respond_to do |format|
      format.html { redirect_to duty_managers_url, notice: "Duty manager was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_duty_manager
      @duty_manager = DutyManager.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def duty_manager_params
      params.require(:duty_manager).permit(:name_duty_manager, :rut, :email, :unit_id)
    end
end
