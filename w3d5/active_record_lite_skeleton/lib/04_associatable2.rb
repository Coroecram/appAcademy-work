require_relative '03_associatable'

# Phase IV
module Associatable
  # Remember to go back to 04_associatable to write ::assoc_options

  def has_one_through(name, through_name, source_name)
    define_method(name) do
      through_values = self.class.assoc_options[through_name]
      source_values = through_values
        .model_class
        .assoc_options[source_name]

      through_table = through_values.table_name
      through_id = through_values.primary_key
      through_fk = through_values.foreign_key

      source_table = source_values.table_name
      source_id = source_values.primary_key
      source_fk = source_values.foreign_key

      key_id = self.send(through_fk)

      results = DBConnection.execute(<<-SQL)
        SELECT
          #{source_table}.*
        FROM
          #{through_table}
        JOIN
          #{source_table}
        ON
          #{through_table}.#{source_fk} = #{source_table}.#{through_id}
        WHERE
          #{through_table}.#{through_id} = #{key_id}
      SQL

      source_values.model_class.parse_all(results).first
    end
  end
end
