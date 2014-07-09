class State
  attr_reader :id, :population, :voice_tolerance, :exit_tolerance, :tax_level, :equality, :last_action, :votes_for, :votes_against
  def initialize(id)
    @id = id
    @population = 0
    @voice_tolerance = rand(101)
    @exit_tolerance = rand(101)
    @tax_level = rand(101)
    @equality = rand(101)
    @last_action = ["raise_voice_tolerance","lower_voice_tolerance","raise_exit_tolerance","lower_exit_tolerance","raise_tax_level","lower_tax_level","raise_equality","lower_equality"].sample
    @votes_for = 0
    @votes_against = 0
    @exits_this_turn = 0
  end

  def raise_population(amount)
        @population = @population + amount
  end
  def raise_voice_tolerance(amount)
        @voice_tolerance = @voice_tolerance + amount
  end
  def raise_exit_tolerance(amount)
        @exit_tolerance = @exit_tolerance + amount
  end
  def raise_tax_level(amount)
        @tax_level = @tax_level + amount
  end
  def raise_equality(amount)
        @equality = @equality + amount
  end
  def collect_vote(sentiment,amount)
    if sentiment == "for"
        @votes_for = @votes_for + amount
    elsif sentiment == "against"
        @votes_against = @votes_against + amount
    end
  end
  def log_exits(amount)
        @exits_this_turn = @exits_this_turn + amount
  end

  def lower_population(amount)
        @population = @population - amount
  end
  def lower_voice_tolerance(amount)
        @voice_tolerance = @voice_tolerance - amount
  end
  def lower_exit_tolerance(amount)
        @exit_tolerance = @exit_tolerance - amount
  end
  def lower_tax_level(amount)
        @tax_level = @tax_level - amount
  end
  def lower_equality(amount)
        @equality = @equality + amount
  end

  def log_last_action(action)
    @last_action = action
  end

  def reset
    @votes_for = 0
    @votes_against = 0
    @exits_this_turn = 0
  end

  def decide
    p "State #{@id} last decided to #{last_action}.  Result was #{@votes_for} votes for, #{@votes_against} votes against, and #{@exits_this_turn} exits. Deciding..."  
  end
end

class Citizen
  attr_reader :id, :state_id, :loyalty
  def initialize(id,states)
    @id = id
    @state_id = rand(states.length)
    states[@state_id].raise_population(1)
    @loyalty = rand(100)
  end

  def raise_loyalty(amount)
      @loyalty = @loyalty + amount
  end

  def lower_loayalty(amount)
      @loyalty = @loyalty - amount
  end

  def exit_state(id,states)
    @state_id = rand(states.length) 
    states[id].lower_population(1)
    states[@state_id].raise_population(1)
  end

  def cast_vote(state,sentiment)
    #only citizens can vote
    if @state_id == state.id
      if sentiment == "for"
        state.collect_vote('for',1)
      elsif sentiment == "against"
        state.collect_vote('against',1)
      end
    end
  end
end

number_of_states = 3
states = []
s_index = 0

number_of_states.times do
  state = State.new(s_index)
  states << state
  s_index = s_index + 1
end

number_of_citizens = 100
citizens = []
c_index = 0

number_of_citizens.times do
  citizen = Citizen.new(c_index,states)
  citizens << citizen
  c_index = c_index + 1
end

rounds = 10
# Now start a round
rounds.times do 
  states.each do |state|
    decision = state.decide
  end
end
