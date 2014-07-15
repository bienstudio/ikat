module Mongoid
  module Userstamps
    extend ActiveSupport::Concern

    included do
      field :created_by, type: BSON::ObjectId
      field :updated_by, type: BSON::ObjectId
    end

    def creator
      self.created_by ? User.find(self.created_by) : nil
    end

    def creator=(u)
      self.created_by = u.id
    end

    def updater
      self.updated_by ? User.find(self.updated_by) : nil
    end

    def updater=(u)
      self.updated_by = u.id
    end
  end
end
