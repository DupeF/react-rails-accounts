class PersonalRecordsController < ApplicationController

  def create
    @record = PersonalRecord.new(personal_record_params)
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
    if @record.update(personal_record_params)
      render json: @record
    else
      render json: @record.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @record = PersonalRecord.find(params[:id])
    authorize @record
    @record.destroy
    head :no_content
  end

  private

  def personal_record_params
    params.require(:personal_record).permit(:title, :amount, :date, :personal_balance_id)
  end

end
