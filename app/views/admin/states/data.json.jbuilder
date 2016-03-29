# @states.each do |state|
#   json.set! state.abbreviation, state.in_state
# end
@states.each do |state|
  json.set! state.abbreviation do
    json.id state.id
    json.in_state_css state.in_state_css
  end
end
