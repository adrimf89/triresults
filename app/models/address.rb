class Address
  attr_accessor :city, :state, :location

  def initialize hash
    @city = hash[:city]
    @state = hash[:state]
    @location = hash[:loc]
  end

  def mongoize
    {
      city: @city,
      state: @state,
      loc: @location.mongoize
    }
  end

  def self.mongoize object
    case object
    when nil then nil
    when Hash then object
    when Address then object.mongoize
    end
  end

  def self.demongoize object
    case object
    when nil then nil
    when Hash then Address.new(city: object[:city], state: object[:state], loc: Point.new(object[:loc][:coordinates][0], object[:loc][:coordinates][1]))
    when Address then object
    end
  end

  def self.evolve object
    case object
    when nil then nil
    when Hash then object
    when Address then object.mongoize
    end
  end
end
