var Student = function(firstname, lastname) {
	this.name = firstname + " " + lastname;
	this.courses = [];
	this.courseLoad = {};
}


Student.prototype.enroll = function(course) {
	try{
		if(course.addStudent(this)) {
			this.courses.push(course);
			this.courseLoad[course.dept] = this.courseLoad[course.dept] || 0;
			this.courseLoad[course.dept] += course.credits;
		}
	}
	catch(error){
		console.log(error);
	}
}

Student.prototype.canEnroll = function(otherCourse){
	var that = this;
	this.courses.forEach(function(course){
		if(course.hasConflict(otherCourse)) {
			throw ("Course conflicts with the schedule of " + that.name);
		}
	});
};

var Course = function(name, dept, credits, days, time) {
	this.name = name;
	this.dept = dept;
	this.credits = credits;
	this.students = [];
	this.days = days;
	this.time = time;
}

Course.prototype.addStudent = function(student) {
	student.canEnroll(this);

	if (this.students.indexOf(student) === -1) {
		this.students.push(student);
		return true;
	}
	else {
		return false;
	}
};


Course.prototype.hasConflict = function(otherCourse) {
	if (otherCourse.time === this.time) {
		var anySameDay = function(day, dayIndex, days) {
			return (otherCourse.days.indexOf(day) !== -1 );
		};
		return (this.days.some(anySameDay));
	}
	return false;
};


alice = new Student("Alice", "Sheldon");
bob = new Student("Bob", "Jones");
math1 = new Course("Math 1", "Math", 5, ["M", "W", "F"], 1);
math2 = new Course("Math 2", "Math", 5, ["M", "W", "F"], 2);
math3 = new Course("Math 3", "Math", 5, ["M", "W", "F"], 1);
alice.enroll(math1);
alice.enroll(math2);
bob.enroll(math1);
bob.enroll(math1);

console.log(alice.courses);
console.log(bob.courses);
console.log(math1.students);

console.log(math1.hasConflict(math2));
console.log(math1.hasConflict(math3));
console.log(alice.courseLoad);