require_relative "../config/environment.rb"

class Student

  attr_accessor :name, :grade
  attr_reader :id

  # Remember, you can access your database connection anywhere in this class
  #  with DB[:conn]

  def initialize(name, grade, id = nil)
    @name = name
    @grade = grade
    @id = id
  end

  def self.create_table
    sql = <<-SQL
      CREATE TABLE students(
        id INTEGER PRIMARY KEY,
        name TEXT,
        grade INTEGER
      );
      SQL

    DB[:conn].execute(sql)
  end

  def self.create_table
    sql = <<-SQL
      DROP TABLE students
      SQL

    DB[:conn].execute(sql)
  end

  def save
    if self.id != nil
      self.update
    else
      sql = <<-SQL
        INSERT INTO students
        VALUES (name, grade)
        SQL

      DB[:conn].execute(sql, self.name, self.grade)
      @id = DB[:conn].execute("SELECT last_instert_rowid() FROM students")[0][0]
    end
  end

  def self.create(name, grade)
    studuent = Student.new(name, grade)
    student.save
    student
  end

  def self.new_from_db(row)
    id = row[0]
    name = row[1]
    grade = row[2]

    Student.new(name, grade, id)
  end

  def self.find_by_name(name)
    sql = <<-SQL
      SELECT * FROM students
      WHERE name = ?
      SQL

    row = DB[:conn].execute(sql, name)[0]

    self.new_from_db(row)
  end

  def update
    binding.pry
  end
  
end
