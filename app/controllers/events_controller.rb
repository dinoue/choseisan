class EventsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:show]
  before_action :set_event, only: [:show]
  before_action :set_my_event, only: [:edit, :update, :destroy]
  before_action :set_event_entry, only: [:show]
  before_action :set_option_entries_selection, only: [:show]
  before_action :check_created_events_count, only: [:new, :create]

  def index
    @events = current_user.related_events.eager_load(:event_entries).order(id: :desc).page(params[:page])
  end

  def show
    @event.event_entries = @event.event_entries.eager_load(:user, option_entries: :option).order(id: :asc)
  end

  def new
    @event = current_user.created_events.build
  end

  def edit
  end

  def create
    @event = current_user.created_events.build
    if EventService.bulk_insert(@event, event_params)
      redirect_to event_path(@event.hash_id), notice: 'イベントを作成しました。'
    else
      render :new
    end
  end

  def update
    if EventService.bulk_update(@event, event_params)
      redirect_to event_path(@event.hash_id), notice: 'イベント情報を変更しました。'
    else
      render :edit
    end
  end

  def destroy
    if EventService.bulk_delete(@event)
      redirect_to events_path, notice: 'イベントを削除しました。'
    else
      render :show
    end
  end

  private
    def set_event
      @event = Event.find_by!(hash_id: params[:id]) # ログインレスでもアクセス可能
    end

    def set_my_event
      @event = current_user.created_events.find(params[:id])
    end

    def set_event_entry
      @event_entry = EventEntry.find_or_initialize_by(event_id: @event, user_id: current_user) do |event_entry|
        event_entry.attributes = { event: @event, user: current_user }
      end
    end

    def set_option_entries_selection
      @option_entries_selection = OptionEntry.option_entries_selection(@event.options, @event_entry)
    end

    def event_params
      params.require(:event).permit(:title, :memo, :options_text, options_deletes: [])
    end

    def check_created_events_count
      if current_user.created_events.count >= Settings.max_count.events
        redirect_to events_path, alert: "イベントは#{Settings.max_count.events}個までしか作成できません。"
      end
    end
end
