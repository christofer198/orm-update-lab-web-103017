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

  def update
      
      DB[:conn].execute(update students set name='#{self.name}', grade='#{self.grade}', id='#{self.id}')
  
  end
    
  def save
    DB[:conn].execute("insert into students (name, grade) values ('#{self.name}', '#{self.grade}')")
    self.id = DB[:conn].execute("select id from students where name='#{self.name}'").flatten.join.to_i
    binding.pry
  end
end
