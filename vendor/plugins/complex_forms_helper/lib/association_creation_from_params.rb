module AssociationCreationFromParams
  def self.included(base)
    base.send :include, InstanceMethods
    base.alias_method_chain :has_many, :creation_from_params
    base.alias_method_chain :has_one, :creation_from_params
  end

  module InstanceMethods

    # For the purposes of the documentation, let's assume
    #
    #   class Project
    #     has_many :tasks, :enable_creation_from_params => true
    #     has_many :resource_assignments
    #     has_many :resources, :through => :resource_assignments, :enable_creation_from_params => true
    #   end
    #
    # The following methods are added for the has_many:
    # * new_task_attributes=
    # * existing_task_attributes=
    # * save_tasks
    # * after_update :save_tasks
    #
    # The following methods are added for the has_many :through:
    # * resource_attributes=(attributes)
    # * save_resource_assignments
    # * after_upate :save_resource_assignments
    #
    # If you define this on both sides of the relationship, you'll cause an endless loop
    def has_many_with_creation_from_params(association_id, options = {}, &extension)
      enable_creation_from_params = options.delete(:enable_creation_from_params)
      reflection = create_has_many_reflection(association_id, options, &extension)
      if enable_creation_from_params
        if options[:through]

          define_method("#{Inflector.singularize(association_id.to_s)}_attributes=") do |child_attributes|
            child_attributes.each do |id, value|
              join_object = send(options[:through]).detect{|c| c.send(reflection.association_foreign_key).to_s == id.to_s}
              if join_object && value.to_s == "0"
                join_object.marked_for_deletion = true
                send(reflection.name).delete_if{|c| c.send(reflection.klass.primary_key).to_s == id.to_s}
              elsif  join_object.nil? && value.to_s == "1"
                category = reflection.klass.find_by_id(id)
                send(options[:through]).build(reflection.association_foreign_key => id)
                send(reflection.name).insert(send(reflection.name).length, category)
                send(reflection.name).compact!
              end
            end
          end

          name = options[:through]
          define_method("save_#{name.to_s}") do
            send(name).each do |child|
              child.save! # => so it cancels any transactions that might be in place
            end
          end
          after_update "save_#{name.to_s}"

        else

          define_method("new_#{Inflector.singularize(association_id.to_s)}_attributes=") do |new_attributes|
            new_attributes.each do |id,attributes|
              send(association_id).build(attributes)
            end
          end

          define_method("existing_#{Inflector.singularize(association_id.to_s)}_attributes=") do |existing_attributes|
            send(association_id).reject(&:new_record?).each do |child|
              attributes = existing_attributes[child.send(reflection.klass.primary_key).to_s]
              if attributes
                child.attributes = attributes
              else
                child.marked_for_deletion = true
              end
            end
          end

          define_method("#{association_id}_without_deleted") do
            send(association_id).select{|t| t.marked_for_deletion == false}
          end

          name = association_id
          define_method("save_#{name.to_s}") do
            send(name).each do |child|
              child.save! # => so it cancels any transactions that might be in place
            end
          end
          after_update "save_#{name.to_s}"

        end
      end
      has_many_without_creation_from_params(association_id, options, &extension)
    end

    def has_one_with_creation_from_params(association_id, options = {})
      enable_creation_from_params = options.delete(:enable_creation_from_params)
      if options[:through]
        reflection = create_has_one_through_reflection(association_id, options)
      else
        reflection = create_has_one_reflection(association_id, options)
        define_method "#{association_id}_attributes=" do |has_one_attributes|
          send("build_#{association_id}") if send(association_id).nil?
          send(association_id).attributes = has_one_attributes
        end

        define_method "save_#{association_id}" do
          if send(association_id) && send(association_id).changed?
            send(association_id).save!
          end
        end
        after_save "save_#{association_id}"

      end      
      has_one_without_creation_from_params(association_id, options)
    end

  end
end