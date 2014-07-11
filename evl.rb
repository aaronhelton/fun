class Person
  attr_reader :id, :life, :liberty, :property, :desired_liberty, :desired_property

  def initialize(id)
    @id = id
    @life = 1
    @liberty = rand(100) + 1
    @property = rand(100) + 1
    @desired_liberty = rand(100) + 1
    @desired_happiness = rand(100) + 1
    @bound_to = []
    @binds = []
    @has_robbed = []
    @was_robbed_by = []
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
    # Benefits?  
  end

  def create(other)
    # What rules govern this?
  end

  def enslave(other)
    
  end

  def release(other)
    # Costs both property and liberty.  Why do this?
  end

  def buy_labor_from(other)

  end

  def sell_labor_to(other)

  end

  def steal_from(other)
    stolen = rand(other.property)
    other.lose_property(stolen)
    @property = @property + stolen
  end

  def give_to(myself,other)
    given = rand(myself.property)
    other.gain_property(given)
    @property = @property - given
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
