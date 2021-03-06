class PersonalRecordsController < ApplicationController

  def create
    @record = PersonalRecord.new(create_personal_record_params)
    authorize @record
    if @record.save
      render json: @record
    else
      render json: @record.errors, status: :unprocessable_entity
    end
  end

  def update
    @record = PersonalRecord.find(params[:id])
    authorize @record
    if @record.update(update_personal_record_params)
      render json: @record
    else
      render json: @record.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @record = PersonalRecord.find(params[:id])
    authorize @record
    @record.destroy
    render json: @record
  end

  private

  def create_personal_record_params
    params.require(:personal_record).permit(:title, :amount, :date, :personal_balance_id)
  end

  def update_personal_record_params
    params.require(:personal_record).permit(:title, :amount, :date)
  end

end
