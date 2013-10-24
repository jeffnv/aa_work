var sum = function() {
	var sum = 0;
	for(var i = 0; i < arguments.length; i++) {
		sum += arguments[i];
	}
	return sum;
}

console.log(sum(1,2,3,4,5));



Function.prototype.myBind = function(myObj) {
	var that = this;
	var args = Array.prototype.slice.call(arguments, 1);
	return function() {
		that.apply(myObj, args);
	}
}

var greet = function(num1, num2, num3) {
	console.log("hi " + this.name + num1 + num2 + num3);
}

function Dog(name) {
	this.name = name;
}

var d = new Dog("fido");

greet.myBind(d, 1, 2, 3)();



var curriedSum = function(numArgs) {
	var numbers = [];
	var _curriedSum = function(num){
		var sum = 0;
		numbers.push(num);
		if (numbers.length === numArgs) {
			for(var i = 0; i < numbers.length; i++) {
				sum += numbers[i];
			}
			return sum;
		}
		else {
			return _curriedSum;
		}
	}
	return _curriedSum;
}

var c = curriedSum(3);
c1 = c(1);
c2 = c1(2);
var sum =  c2(3);
console.log(sum);



Function.prototype.curry = function(numArgs) {
  var elements = [];
  var that = this;
	var obj = this.caller;
  var _curriedElements = function(el) {
  	elements.push(el);
  	if(numArgs === elements.length) {
  		that.apply(this, elements);
  	}
  	else {
  		return _curriedElements;
  	}
  };
  return _curriedElements;
}

function Person(name){this.name = name; }
Person.prototype.eat = function(food1, food2, food3){
	console.log( this.name +  " is eating "  + food1 + food2 + food3);
};

var irene = new Person("irene");
irene.eat("pho", "cereal", "steak");

console.log("\n\n oh no... \n\n");

var c = irene.eat.curry(3);
c1 = c("pho");
c2 = c1("cereal");
c2.bind(irene)("steak");