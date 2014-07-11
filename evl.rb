class Person
  attr_reader :id, :liberty, :property, :desired_liberty, :desired_property, :pay_per_round, :is_subscribed_to

  def initialize(id, liberty, property, desired_liberty, desired_property)
    # attributes
    @id = id
    @liberty = liberty
    @property = property
    @desired_liberty = desired_liberty
    @desired_property = desired_property
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

  def subscribe_to(organization)
    # costs something
    self.lose_property(organization.subscriber_cost_amount)
    # gains soemthing else
    self.gain_liberty(organization.subscriber_benefit_amount)
    # default subscriber loyalty is 50.
    organization.add_subscriber({:subscriber => self.id, :loyalty => 50})
  end

  def unsubscribe_from(organization)
    # is there an exit cost?
  end

  def voice_to(organization)
    # this costs the organization
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
