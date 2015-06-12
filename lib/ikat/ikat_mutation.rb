class IkatMutation < Mutations::Command
  def mongoid_errors!(obj)
    # If there isn't an object passed, just return
    return if obj.nil?

    # If there are any validation errors...
    if obj.errors.any?

      # Go through each of the errors..,
      obj.errors.each do |field, message|
        klass = obj.class.name.downcase

        # Add a Mutation `:validation_error` for each error.
        self.add_error("#{klass}.#{field}", :validation_error, "#{field.capitalize}: #{message}")
      end
    end
  end
end
