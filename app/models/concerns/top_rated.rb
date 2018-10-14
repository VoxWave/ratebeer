module TopRated
  extend ActiveSupport::Concern

  def self.top(n)
    all.sort_by{ |b| -(b.average_rating || 0) }.take(n)
  end
end