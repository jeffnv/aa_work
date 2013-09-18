class Student
  def initialize(first, last)
    @first_name = first
    @last_name = last
    @courses = []
  end

  def name
    "#{@first_name} #{@last_name}"
  end

  def courses
    @courses.map(&:name).join(", ")
  end

  def enroll(course)
    conflict = @courses.any? do |enrolled_course|
      enrolled_course.conflicts_with? course
    end

    if conflict
      raise 'This course conflicts with your previously enrolled courses.'
    else
        @courses << course
        course.add_student(self)
    end
  end

  def course_load
    dept_hash = Hash.new(0)
    @courses.each do |course|
      dept_hash[course.department] += course.unit_hours
    end
    dept_hash
  end


end

class Course
  attr_reader :name, :unit_hours, :department, :students, :days, :time

  def initialize(name, department, unit_hours, days = [], time = 1 )

    @name = name
    @unit_hours = unit_hours
    @students = []
    @department = department
    @days = days
    @time = time
  end

  def add_student(name)
    @students << name unless @students.include?(name)
  end

  def conflicts_with? (other_course)
    day_conflict = other_course.days.any? do |day|
      self.days.include?(day)
    end

    if day_conflict
      other_course.time == self.time
    else
      false
    end
  end
end