class EventsController < ApplicationController
  def show
    @event = Event.find(params[:id])
    render json: @event
  end

  def new_expense
    group = Group.find_by(name: params[:group])
    params[:group] = group

    @event = Event.new(event_params)
    @event.group_id = group.id

    if @event.save
      render json: @event, status: :created, location: @event
    else
      render json: @event.errors, status: :unprocessable_entity
    end
  end

  private

  def expense_params
    params.permit(:event_id, :spender_id, :description, :amount, :location, :photo_url)
  end
end
