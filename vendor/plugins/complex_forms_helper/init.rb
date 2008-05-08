require 'association_creation_from_params'
require 'marked_for_deletion'
ActiveRecord::Base.send :include, MarkedForDeletion
ActiveRecord::Associations::ClassMethods.send :include, AssociationCreationFromParams