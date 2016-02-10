class Placing
  attr_accessor :name, :place

  def initialize hash
    @name = hash[:name]
    @place = hash[:place]
  end

  def mongoize
    {
      name: @name,
      place: @place
    }
  end

  def self.mongoize object
    case object
    when nil then nil
    when Hash then object
    when Placing then object.mongoize
    end
  end

  def self.demongoize object
    case object
    when nil then nil
    when Hash then Placing.new(name: object[:name], place: object[:place])
    when Place then object
    end
  end

  def self.evolve object
    case object
    when nil then nil
    when Hash then object
    when Placing then object.mongoize
    end
  end
end
