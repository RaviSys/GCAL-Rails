class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy, :sync_event_with_google]
  before_action :authenticate_user!

  def index
    @events = current_user.events
  end

  def show; end

  def new
    @event = Event.new
  end

  def edit; end

  def create
    @event = Event.new(event_params)
    respond_to do |format|
      if @event.save
        format.html { redirect_to @event, notice: 'Event was successfully created.' }
        format.json { render :show, status: :created, location: @event }
      else
        format.html { render :new }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  rescue Google::Apis::ClientError => error
    redirect_to events_path, notice: error.message
  end

  def update
    respond_to do |format|
      if @event.update(event_params)
        format.html { redirect_to @event, notice: 'Event was successfully updated.' }
        format.json { render :show, status: :ok, location: @event }
      else
        format.html { render :edit }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @event.destroy
    respond_to do |format|
      format.html { redirect_to events_url, notice: 'Event was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def event_calendar; end

  def events_for_calendar
    @events = []
    Event.all.each do |event|
      @events << {
        title: event.title,
        start: event.start_date.strftime("%Y-%m-%d"), 
        start: event.end_date.strftime("%Y-%m-%d"),
        url: event_path(event)
      }
    end
    render json: @events
  end

  def add_quick_event
    @event = Event.new(event_params)
    respond_to do |format|  
      if @event.save
        @event.add_quick_google_event(@event, current_user)
        format.html { redirect_to event_calendar_events_path, notice: 'Quick Event was successfully created.' }
      end
    end
  end

  def sync_event_with_google
    @event = Event.find(params[:id])
    ge = @event.get_google_event(@event.google_event_id, @event.user)
    guests = ge.attendees.map {|at| at.email}.join(", ")
    @event.update(guest_list: guests)
    redirect_to event_path(@event), notice: "Event has been synced with google successfully."
  end

  def sync_all_user_events_with_google
    @events = current_user.events
    @events.each do |event|
      ge = event.get_google_event(@event.google_event_id, @event.user)
      guests = ge.attendees.map {|at| at.email}.join(", ")
      event.update(guest_list: guests)
    end
    redirect_to events_path, notice: "All events has been synced with google successfully."
  end

  private

    def set_event
      @event = Event.find(params[:id])
    end

    def event_params
      params.require(:event).permit!
    end
end
