module RansackableAttributes
  extend ActiveSupport::Concern

  included do
    def self.ransackable_attributes(auth_object = nil)
      column_names + _ransackers.keys
    end

    def self.ransackable_associations(auth_object = nil)
      reflect_on_all_associations.map(&:name)
    end
  end
end
