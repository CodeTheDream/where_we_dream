module StatesHelper
  def states_data(states)
    output = {}

    states.each do |state|
      output[state.abbreviation] = {
        id: state.id,
        in_state_css: state.in_state_css
      }
    end

    output.to_json.html_safe
  end
end
