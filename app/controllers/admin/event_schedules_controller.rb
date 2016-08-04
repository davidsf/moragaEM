module Admin
  class EventSchedulesController < Admin::BaseController
    load_and_authorize_resource :event_schedule

    def create
      if @event_schedule.save
        render json: { 'status' => 'ok', event_schedule_id: @event_schedule.id }
      else
        render json: { 'status' => 'error' }
      end
    end

    def update
      if @event_schedule.update(event_schedule_params)
        render json: { 'status' => 'ok', event_schedule_id: @event_schedule.id }
      else
        render json: { 'status' => 'error' }
      end
    end

    def destroy
      if @event_schedule.destroy
        render json: { 'status' => 'ok' }
      else
        render json: { 'status' => 'error' }
      end
    end

    private

    def event_schedule_params
      params.require(:event_schedule).permit(:schedule_id, :event_id, :room_id, :start_time)
    end
  end
end
