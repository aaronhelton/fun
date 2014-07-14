class Person
  attr_reader :id, :liberty, :property, :desired_liberty, :desired_property, :pay_per_round, :is_subscribed_to

  def initialize(id, liberty, property, pay_per_round)
    # attributes
    @id = id
    # liberty tops out at 100
    @liberty = liberty
    # property has no cap
    @property = property
    @pay_per_round = rand(10) # More? Less?

    # loyalty predicate
    @is_subscribed_to = Hash.new
  end

  def lose_liberty(amount)
    @liberty = @liberty - amount
  end

  def gain_liberty(amount)
    @liberty = @liberty + amount
  end

  def lose_property(amount)
    @property = @property - amount
  end

  def gain_property(amount)
    @property = @property + amount
  end

  def get_paid
    self.gain_property(@pay_per_round)
  end

  def pay_to(organization)
    self.lose_property(organization.subscriber_fee_per_round)
  end

  def subscribe_to(organization,loyalty)
    # costs something, but this could be negative.
    self.lose_property(organization.subscriber_fee_initial)
    # gain something
    self.gain_liberty(organization.afforded_liberty_per_customer)
    @is_subscribed_to = {	:id => organization.id, 
				:loyalty => loyalty, 
				:current_subscriber_fee_per_round => organization.subscriber_fee_per_round,
				:current_afforded_liberty => organization.afforded_liberty }
  end

  def unsubscribe_from(organization)
    # is there an exit cost?
    self.lose_property(organization.subscriber_exit_cost)
    self.lose_liberty(@is_subscribed_to.current_afforded_liberty)
    @is_subscribed_to = Hash.new
  end

  def voice_to(organization,action,amount)
    # this costs the organization
    
  end

  def can_pay_to?(organization)
  end

  def can_switch_from_to?(origin_organization,destination_organization)
    switching_cost = origin_organization.unsubscribe_cost + destination_organization.subscribe_cost_initial
    if @property - switching_cost >= 0
      return true
    else
      return false
    end
  end

  def choose_action
    switch_probability = 0 
    # Actor patterns might be appropriate here
    if (@is_subscribed_to.current_subscriber_fee_per_round / @is_subscribed_to.current_afforded_liberty) > 1
      switch_probability = switch_probability + 10
      @is_subscribed_to.loyalty = @is_subscribed_to.loyalty + 2
    elsif (@is_subscribed_to.current_subscriber_fee_per_round / @is_subscribed_to.current_afforded_liberty) = 1
      switch_probability = switch_probability + 15
      @is_subscribed_to.loyalty = @is_subscribed_to.loyalty + 1
    elsif (@is_subscribed_to.current_subscriber_fee_per_round / @is_subscribed_to.current_afforded_liberty) < 1
      switch_probability = switch_probability + 25
      @is_subscribed_to.loyalty = @is_subscribed_to.loyalty - 2
    end
  end
end


# start with 10 people
i = 0
people = []

10.times do
  prop = rand(100)
  lib = rand(100)
  dprop = prop + (rand(100 - prop))
  dlib = lib + (rand(100 - lib))
  person = Person.new(i, lib, prop, dlib, dprop)
  i = i + 1
  people << person
end

puts people.inspect
