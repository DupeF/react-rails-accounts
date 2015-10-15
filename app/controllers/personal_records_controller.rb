class PersonalRecordsController < ApplicationController

  def create
    @record = PersonalRecord.new(personal_record_params)
    if @record.save
      render json: @record
    else
      render json: @record.errors, status: :unprocessable_entity
    end
  end

  def update
    @record = PersonalRecord.find(params[:id])
    if @record.update(personal_record_params)
      render json: @record
    else
      render json: @record.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @record = PersonalRecord.find(params[:id])
    @record.destroy
    head :no_content
  end

  private

  def personal_record_params
    params.require(:personal_record).permit(:title, :amount, :date, :personal_balance_id)
  end

end
