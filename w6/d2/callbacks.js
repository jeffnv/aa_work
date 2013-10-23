var Clock = function() {
	this.today = new Date();
	this.hour = this.today.getHours();
	this.minute = this.today.getMinutes();
	this.seconds = this.today.getSeconds();
	var that = this;

	this.tick = function() {
		that.seconds += 5;
		if (that.seconds > 60) {
			that.seconds = that.seconds % 60;
		}

		console.log(that.hour + " : " + that.minute + " : " + that.seconds);
	};

};

Clock.prototype.run = function() {
	setInterval(this.tick, 5000);
};


var clock = new Clock();
clock.run();