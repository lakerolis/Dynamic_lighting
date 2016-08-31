class SensorInputController < ApplicationController
  def sensorinput

  end

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
end

