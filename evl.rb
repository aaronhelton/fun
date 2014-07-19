class Person
  attr_reader :id, :liberty, :property, :pay_per_round, :is_subscribed_to

  def initialize(id, liberty, property, pay_per_round)
    # attributes
    @id = id
    # liberty tops out at 100
    @liberty = liberty
    # property has no cap
    @property = property
    @pay_per_round = rand(10) # More? Less? Any ability to change it later?

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

  def voice_to(organization,action,amount)
    # this costs the organization
  end

  def consider(offer)
    # probability of switching now?
    switch_base_probability = 100 - self.is_subscribed_to[:loyalty]
    affordability_additive = 0

    # can person afford it?
    if self.property >= offer.subscribe_cost_initial && self.pay_per_round >= offer.subscribe_cost_per_round
      # yes, but affordability isn't worth much
      # It would be better to test relative affordability...
      affordability_additive = 10
    elsif self.property < offer.subscribe_cost_initial
      # nope
      self.reject(offer)
    elsif self.pay_per_round < offer.subscribe_cost_per_round
      # can afford it NOW, but it's inadvisable
      affordability_additive = 5
    end

    # effect on liberty?
    liberty_additive = offer.liberty_afforded - self.liberty
    # we can also know what factor of the offer was (un)attractive...
    lower_price = 0
    higher_price = 0
    more_liberty = 0
    less_liberty = 0

    if affordability_additive < 0
      higher_price = 1
    elsif affordability_additive > 0
      lower_price = 1
    elsif liberty_additive < 0
      less_liberty = 2
    elsif liberty_additive > 0
      more_liberty = 2
    end
    # this sends an imperfect signal, by design, to the offering organization; 
    # the organization can't know precisely why the offer was rejected or accepted.
    # possible outcomes: 0: neither, 1: affordability, 2: liberty, 3: both
    reason_signal = lower_price + higher_price + more_liberty + less_liberty
      
    switch_probability = switch_base_probability + affordability_additive + liberty_additive
    
    # moment of truth
    r = rand() * 100
    if switch_probability <= 0 || r > switch_probability
      self.reject(offer,reason_signal)
    elsif r <= switch_probability
      self.accept(offer,reason_signal)
    end
  end

  def accept(offer,reason_signal)
    loyalty = 50	# really we should be able to do better...
    @is_subscribed_to = {  :organization => offer.organization, 
			   :loyalty => loyalty,
                           :paid_subscribe_cost_initial => offer.subscribe_cost_initial,
                           :current_subscribe_cost_per_round => offer.subscribe_cost_per_round,
                           :current_afforded_liberty => offer.afforded_liberty }
    organization.signal('accept',reason_signal)
  end

  def reject(offer)
    organization.signal('reject',reason_signal)
  end

end

class Offer
  attr_reader :id, :organization_id, :subscribe_cost_initial, :subscribe_cost_per_round, :liberty_afforded

  def initialize(id, organization, subscribe_cost_initial, subscribe_cost_per_round)
    @id = id
    @organization_id = organization_id
    @subscribe_cost_initial = subscribe_cost_initial
    @subscribe_cost_per_round = subscribe_cost_per_round
    @liberty_afforded = liberty_afforded
  end 
end

class Organization
  attr_reader :id, :viability, :current_reserve, :fixed_cost_per_round, :cost_per_unit_liberty, :signal, :subscribers

  def initialize(id, fixed_cost_per_round, cost_per_unit_liberty)
    @id = id
    @fixed_cost_per_round = fixed_cost_per_round
    @cost_per_unit_liberty = cost_per_unit_liberty
    @signal = Hash.new
    @subscribers = Hash.new
    @viability = 1 # ???
  end

  def publish_offer(offers_count)
    # parse out signal if there's anything
    if @signal.length > 0
      if @signal[:accepts] > @signal[:rejects]
        if @signal[:accepts][:reason] == 1
          # raise price for this offer
        elsif @signal[:accepts][:reason] == 2
          # decrease benefit for this offer
        else
          # ???
        end
      elsif @signal[:rejects] > @signal[:accepts]

      else
        #do something random?
      end
    else
      # do something random
    end

    offer = { :id = offers_count + 1,
	      :organization_id = @id,
              :subscribe_cost_initial = subscribe_cost_initial,
              :subscribe_cost_per_round = subscribe_cost_per_round,
              :liberty_afforded = liberty_afforded }
    return offer
  end

  def subscribe(person)

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
