# @states.each do |state|
#   json.set! state.abbreviation, state.in_state
# end
@states.each do |state|
  json.set! state.abbreviation do
    json.id state.id
    json.in_state state.in_state
  end
end
