require_relative "../config/environment.rb"
require 'pry'
class Student

  # Remember, you can access your database connection anywhere in this class
  #  with DB[:conn]
  attr_accessor :name, :grade, :id

  def initialize(name, grade, id=nil)
    @name = name
    @grade = grade
    @id = id
  end

  def self.create_table
    DB[:conn].execute("create table students(id integer primary key, name text, grade text)")
  end

  def self.drop_table
    DB[:conn].execute("drop table students")
  end

  def save
    if self.id
        self.update
      else
        sql = <<-SQL
          INSERT INTO students (name, grade) VALUES (?, ?)
        SQL
  
        DB[:conn].execute(sql, self.name, self.grade)
        @id = DB[:conn].execute("SELECT last_insert_rowid() FROM students")[0][0]
      end
  end
end
