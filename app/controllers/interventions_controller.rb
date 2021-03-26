require 'zendesk_api'
class InterventionsController < ApplicationController

  #AJAX function call
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
      @intervention.elevator_id = params["elevator_id"]
      @intervention.column_id = params["column_id"] if params["elevator_id"] == ""
      @intervention.battery_id = params["battery_id"] if params["elevator_id"] == "" and params["column_id"] == ""
      @intervention.employee_id = params["employee_id"]
      @intervention.report = params["description"] unless params["description"] == ""
      @intervention.status = "Pending" 

    if @intervention.save
      redirect_back fallback_location: root_path, notice: "Your Intervention was successfully created and sent!"
    end

    client = ZendeskAPI::Client.new do |config|
      config.url = ENV['ZENDESK_URL']
      config.username = ENV['ZENDESK_USERNAME']
      config.token = ENV['ZENDESK_TOKEN']
    end

    if params["elevator_id"] == "" and params["column_id"] == ""
      message = "The battery specified has the ID of #{params["battery_id"]}."
    elsif params["elevator_id"] == ""
      message = "The battery specified has the ID of #{params["battery_id"]}, with a column ID of #{params["column_id"]}."
    else
      message = "The battery specified has the ID of #{params["battery_id"]}, with a column ID of #{params["column_id"]}, and an elevator ID of #{params["elevator_id"]}."
    end

    if params['employee_id'] != ""
      employeeMessage = "#{Employee.find_by(id: params["employee_id"]).first_name} #{Employee.find_by(id: params["employee_id"]).last_name}, ID: #{Employee.find_by(id: params["employee_id"]).id}, was requested to handle this intervention."
    else
      employeeMessage = "No employee was specified to handle this intervention."
    end

    if params["description"] != ""
      descriptionMessage = "#{params["description"]}"
    else
      descriptionMessage = "No description provided."
    end
    
    ZendeskAPI::Ticket.create!(client, 
      :subject => "#{Employee.find_by(user_id: current_user.id).first_name} #{Employee.find_by(user_id: current_user.id).last_name} submitted an intervention.", 
      :comment => { 
          :value => "#{Employee.find_by(user_id: current_user.id).first_name} #{Employee.find_by(user_id: current_user.id).last_name} submitted an intervention for #{Customer.find_by(id: params["customer_id"]).company_name}, on their building with the ID of #{params["building_id"]}.
          #{message}
          #{employeeMessage}
          The description of the intervention is as follows:
          #{descriptionMessage}"
      }, 
      :requester => { 
          "name": Employee.find_by(user_id: current_user.id).first_name + " " + Employee.find_by(user_id: current_user.id).last_name,
      },
      :priority => "normal",
      :type => "question"
      )
  end

    # Only allow a list of trusted parameters through.
    def intervention_params
      params.fetch(:intervention, {})
      # params.require(:intervention).permit(:customer_id, :building_id, :battery_id, :column_id, :elevator_id, :employee_id, :description)
    end
    
end