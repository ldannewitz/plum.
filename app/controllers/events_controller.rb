class EventsController < ApplicationController
  def show
    @event = Event.find(params[:id])
    render json: @event
  end

  def new_expense
    # group = Group.find_by(name: params[:group])
    # params[:group] = group

    @expense = Expense.new(expense_params)
    # @expense.group_id = group.id

    if @expense.save
      render json: @expense, status: :created, location: @expense
    else
      render json: @expense.errors, status: :unprocessable_entity
    end
  end

  private

  def expense_params
    params.permit(:event_id, :spender_id, :description, :amount, :location, :photo_url)
  end
end
