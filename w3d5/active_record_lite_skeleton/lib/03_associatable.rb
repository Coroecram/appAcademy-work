require_relative '02_searchable'
require 'active_support/inflector'

# Phase IIIa
class AssocOptions
  attr_accessor(
    :foreign_key,
    :class_name,
    :primary_key
  )

  def model_class
    @class_name.constantize
  end

  def table_name
    model_class.table_name
  end


end


class BelongsToOptions < AssocOptions

  def initialize(name, options = {})
    @class_name = options[:class_name] || name.capitalize
    @foreign_key = options[:foreign_key] || (name.foreign_key).to_sym
    @primary_key = options[:primary_key] || :id
  end

end

class HasManyOptions < AssocOptions
  def initialize(name, self_class_name, options = {})
    @class_name = options[:class_name] || name.capitalize.singularize
    @foreign_key = options[:foreign_key] || (self_class_name.foreign_key).to_sym
    @primary_key = options[:primary_key] || :id
  end
end

module Associatable
  # Phase IIIb
  def belongs_to(name, options = {})
   assoc_options[name] = BelongsToOptions.new("#{name}", options)
   options = assoc_options[name]

   define_method(name) do
      foreign_id = self.send(options.foreign_key)
      result = options
      .model_class
      .where({options.primary_key => foreign_id})
      return nil if result.empty?
      result.first
    end
 end

  def has_many(name, options = {})
    assoc_options[name] = HasManyOptions.new("#{name}", self.name, options)
    options = assoc_options[name]
    
    define_method(name) do
       id = self.send(options.primary_key)
       result = options
       .model_class
       .where({options.foreign_key => id})
     end
  end

  def assoc_options
    @assoc_options ||= {}
  end
end

class SQLObject
  extend Associatable
end
