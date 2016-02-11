class Entrant
  include Mongoid::Document
  include Mongoid::Timestamps
  store_in collection: "results"
  field :bib, type: Integer
  field :secs, type: Float
  field :o, as: :overall, type: Placing
  field :gender, type: Placing
  field :group, type: Placing

  embeds_many :results, class_name: "LegResult", order: [:"event.o".asc], after_add: :update_total

  def update_total(result)
    if self.secs.nil?
      self.secs = result.secs
    else
      self.secs = self.secs + result.secs
    end
  end
end
