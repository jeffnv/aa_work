//multiples, myEach, myMap, myInject

//Write a method that takes an array of integers and returns an array with the array elements multiplied by two.
Array.prototype.multiples = function(times){
	var result = [];
	this.forEach(function(element, index){
		result.push(element *  times);

	});
	return result;
};

console.log([23,46,76,1,22].multiples(3));


//Extend the Array class to include a method named my_each that takes a block, calls the block on every element of the array, and then returns the original array. Do not use Ruby's Enumerable's each method. I want to be able to write:

Array.prototype.myEach = function(functionToCall){
	for(var i = 0; i < this.length; i++){
		functionToCall(this[i]);
	}
	return this;
};

[5, 4, 6, 2].myEach(function(element){
	console.log("I'm in a function!" + element);
});

[5, 4, 6, 2].myEach(console.log.bind(console));

Array.prototype.myMap = function(functionToCall) {
	result = [];
	var funct = function(element) {
		result.push(functionToCall(element));
	}
	this.myEach(funct);

/*	for(var i = 0; i < this.length; i++){
		result.push(functionToCall(this[i]));
	} */
	return result;
	// is this a closure?
}

var multiple = 3;

console.log([5, 3, 2, 6].myMap(function(element) {
	return element * multiple;
}));

Array.prototype.myInject = function(functionToCall) {
	var accum = this[0];
	var funct = function(element) {
		accum = functionToCall(accum, element);
	}
	this.slice(1).myEach(funct);
	return accum;
}



console.log([1, 1, 1, 1].myInject(function (accum, elem) {
	return accum + elem;
})
);