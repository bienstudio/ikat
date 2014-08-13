module Mongoid
  module Userstamps
    extend ActiveSupport::Concern

    included do
      field :created_by_type, type: String
      field :created_by, type: BSON::ObjectId

      field :updated_by_type, type: String
      field :updated_by, type: BSON::ObjectId
    end

    def creator
      self.created_by ? self.created_by_type.constantize.find(self.created_by) : nil
    end

    def creator=(o)
      self.created_by = o.id
      self.created_by_type = o.class.to_s
    end

    def updater
      self.updated_by ? self.updated_by_type.constantize(self.updated_by) : nil
    end

    def updater=(o)
      self.updated_by = o.id
      self.updated_by_type = o.class.to_s
    end
  end
end
