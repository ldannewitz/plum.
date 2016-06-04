class EventsController < ApplicationController
  def show
    @event = Event.find(params[:id])
    render json: @event
  end
end
