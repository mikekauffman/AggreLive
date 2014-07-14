class EventsController < ApplicationController
  def create
    event_info = Event.get_info(params[:event_id])
    event = Event.create!(
      event_id: event_info[:id],
      user_id: current_user.id,
      date: event_info[:date],
      url: event_info[:url],
      tag_line: event_info[:tag_line],
      artist: event_info[:artist],
    )
    redirect_to user_path(current_user)
  end
end