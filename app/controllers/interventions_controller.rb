class InterventionsController < ApplicationController

  def getData
    id = request.query_parameters["id"]
    field = request.query_parameters["value"]

    @data = ""

    if field == 'building'
      @data = Building.where(customer: id)
    elsif field == 'battery'
      @data = Battery.where(building: id)
    elsif field == 'column'
      @data = Column.where(battery: id)
    elsif field == 'elevator'
      @data = Elevator.where(column: id)
    else
      @data = ""
    end

    return render json: @data

  end

  # POST /interventions or /interventions.json
  def create

    @intervention = Intervention.new(intervention_params)

      @intervention.author = Employee.find_by(user_id: current_user.id).id
      @intervention.customer_id = params["customer_id"]
      @intervention.building_id = params["building_id"]
      # @intervention.elevator_id = params["elevator_id"]
      # @intervention.column_id = params["column_id"] unless params["elevator_id"]
      # @intervention.battery_id = params["battery_id"] unless params["elevator_id"] == "" and params["column_id"] == ""


      if params["elevator_id"]
        @intervention.elevator_id = params["elevator_id"]
      end

      if params["elevator_id"] == ""
        @intervention.column_id = params["column_id"]
      end

      if params["elevator_id"] == "" and params["column_id"] == ""
        @intervention.battery_id = params["battery_id"]
      end

      @intervention.employee_id = params["employee_id"]

      @intervention.report = params["description"] unless params["description"] == ""

      @intervention.status = "Pending" 

    if @intervention.save
      redirect_back fallback_location: root_path, notice: "Your Intervention was successfully created and sent!"
    end
  end
    # Only allow a list of trusted parameters through.
    def intervention_params
      params.fetch(:intervention, {})
      # params.required(:interventions).permit!
    end
end