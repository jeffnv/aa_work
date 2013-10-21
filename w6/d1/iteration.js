Array.prototype.bubbleSort = function(){
	var sorted = false;
	while (sorted === false) {
		sorted = true;
		for (var i = 1; i < this.length; i++) {
			if (this[i-1] > this[i]) {
				var temp = this[i-1];
				this[i-1] = this[i];
				this[i] = temp;
				sorted = false;
			}
		}
	}
	return this;
};

console.log([5, 4, 6, 8, 1].bubbleSort());

String.prototype.subStrings = function(){
	var subs = [];
	for(var start_index = 0; start_index  < this.length; start_index++){
		for(var end_index = start_index + 1; end_index < this.length + 1; end_index++){
			var sub = this.slice(start_index, end_index);
			if(subs.indexOf(sub) === -1)
			{
				subs.push(sub);
			}
		}
	}
	return subs;
};


console.log("Hello".subStrings());