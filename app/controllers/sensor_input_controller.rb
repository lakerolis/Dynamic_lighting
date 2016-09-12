class SensorInputController < ApplicationController
  def sensorinput

  end

  def receiveSensorInput
    value = params[:value]
    sensor = Sensor.find(params[:id])
    sensor.update_attribute(:value, value)

    start_condition_checker

    respond_to do |format|
      format.html { redirect_to sensorinput_path, notice: '' }
      format.json { render json: @user, status: :created, location: @user }
    end
  end

  #test sensor input
  def sendinput
    @id = params[:id]
    @value = params[:value]
    @rulesInPlay = []
    @conditions = []
    @triggeredRules = []

    logger.info "sensorInput: id="+@id+" value="+@value

    Condition.all.each do |c|
      if c.sensor_id.to_s == @id.to_s
        @conditions << c
      end
    end

    Rule.all.each do |rule|
      @rule = []
      @conditions.each do |condition|
        if condition.rule_id.to_s == rule.id.to_s
          @rule << condition
          logger.info 'rule: '+rule.name + ' condition: '+condition.name
        end
      end
      unless @rule.empty?
        @rulesInPlay << @rule
      end
    end

    trigger = false
    @rulesInPlay.each do |r|
      ruleId = ''
      r.each do |c|
        operator = c.operator
        if operator == '>' && @value.to_i > c.operator_value.to_i
          trigger = true
          ruleId = c.rule_id.to_s
        elsif operator == '<' && @value.to_i < c.operator_value.to_i
          trigger = true
          ruleId = c.rule_id.to_s
        elsif operator == '=' && @value.to_i == c.operator_value.to_i
          trigger = true
          ruleId = c.rule_id.to_s
        end
        if trigger == true
          @triggeredRules << r[0].rule_id.to_s
          logger.info 'rule triggered: '+ruleId.to_s
        end
        trigger = false
      end
    end

    Aaction.all.each do |a|
      if @triggeredRules.include? ""+a.rule.id.to_s
        logger.info 'trigger info: '+a.config
      end
    end


    SensorInput.create :sensor_id => @id.to_s, :sensorvalue => @value, :triggered => 'false'
    respond_to do |format|
      format.html { redirect_to sensorinput_path, notice: 'Action was successfully destroyed.' }
      format.json { head :no_content }
      #render :nothing => true
    end
  end

  def start_condition_checker
    rules_in_play = []
    triggered_rules = []
    conditions = Condition.all

    Rule.all.each do |rule|
      rule_conditions = []
      conditions.each do |condition|
        if condition.rule_id.to_s == rule.id.to_s
          rule_conditions << condition
        end
      end
      unless rule_conditions.empty?
        rules_in_play << rule_conditions
      end
    end

    trigger = false
    rules_in_play.each do |r|
      rule_id = r.first.rule_id.to_s
      logger.info '----------------------------'
      logger.info 'RuleID: '+r[0].rule_id.to_s
      r.each do |c|
        operator = c.operator
        operator_value = c.operator_value.to_i
        sensor_name = c.sensor.name
        sensor_value = c.sensor.value.to_i
        if operator == '>' && sensor_value > operator_value
          trigger = true
        elsif operator == '<' && sensor_value < operator_value
          trigger = true
        elsif operator == '=' && sensor_value == operator_value
          trigger = true
        else
          trigger = false
          logger.info 'CONDITION FALSE'
          logger.info 'sensorValue: '+sensor_value.to_s+'!'+operator+operator_value.to_s
          logger.info 'sensor: '+sensor_name +'. sensorValue: '+sensor_value.to_s
          logger.info 'conditionName: '+c.name + '. operatorValue: '+operator_value.to_s
          break
        end
        if trigger == true
          logger.info 'CONDITION TRUE'
          logger.info 'sensorValue: '+sensor_value.to_s+operator+operator_value.to_s
          logger.info 'sensor: '+sensor_name +'. sensorValue: '+sensor_value.to_s
          logger.info 'conditionName: '+c.name + '. operatorValue: '+operator_value.to_s
        end
      end
      if trigger == true
        triggered_rules << rule_id
        logger.info 'RULE TRIGGERED!'
      end
    end

    Aaction.all.each do |a|
      if triggered_rules.include? a.rule.id.to_s
        logger.info 'trigger name: '+a.actor.name+' config:'+a.config
      end
    end
  end
end

