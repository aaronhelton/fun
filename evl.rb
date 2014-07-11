class Person
  attr_reader :id, :parents, :life, :liberty, :property, :desired_liberty, :desired_property, :productivity, 

  def initialize(id, parents, liberty, property, desired_liberty, desired_property, productivity)
    # attributes
    @id = id
    @life = 1
    @parents = parents
    @liberty = liberty
    @property = property
    @desired_liberty = desired_liberty
    @desired_property = desired_property
    @productivity = productivity
    
    # predicate states
    @has_robbed = []
    @has_been_robbed_by = []
    @has_murdered = []
    @has_worked_for = []
    @has_employed = []
    @enslaved_by = []
    @enslaves = []
  end

  def die
    @life = 0
    # Does this have an effect on the liberty or property of others?
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

  def murder(other)
    # Benefits?  Costs?
    other.die  
  end

  def create(other)
    # What rules govern this?
  end

  def enslave(other)
    # Gain 
  end

  def release(other)
    # Costs both property and liberty.  Why do this?  Uncaptured externality.
  end

  def buy_labor_from(other)
    # Costs property but gains an amount of liberty equal to a 
    # random fraction of other's productivity.
    self.lose_property(property_amount)
    self.gain_liberty(liberty_amount/2)
    other.lose_liberty(liberty_amount)
    other.gain_property(property_amount)
    @has_employed << other
  end

  def sell_labor_to(other)
    # Costs liberty but gains a random amount of property from other
  end

  def steal_from(other)
    # Costs nothing but gains random amount of property from other
    # All benefit, no cost...need some additional attributes to capture
    # what now exist as externalities.
  end

  def give_to(other)
    # Gains nothing but gives random amount of self's property to other
  end
end

# start with 10 people
i = 0
people = []

10.times do
  person = Person.new(i)
  i = i + 1
  people << person
end

puts people.inspect
