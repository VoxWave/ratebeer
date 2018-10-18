module TopRated
  extend ActiveSupport::Concern

  def self.included(obj)
    obj.extend(ClassMethods)
  end

  module ClassMethods
    def top(amount)
      all.sort_by{ |b| -(b.average_rating || 0) }.take(amount)
    end
  end
end
