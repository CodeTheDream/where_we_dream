class OpinionsController < ApplicationController
  before_filter :set_variables

  def opinionate
    @opinion.update(value: @value)
    render nothing: true
  end

  private

  def set_variables
    user_id = session[:user_id]
    opinionable_type = params[:like][:opinionable_type]
    opinionable_id = params[:like][:opinionable_id]
    @value = params[:like][:value]
    @opinion = Opinion.find_or_initialize_by(opinionable_id: opinionable_id, opinionable_type: opinionable_type, user_id: user_id)
  end

end
