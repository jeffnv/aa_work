Function.prototype.myBind = function(obj){
	var that = this;
	var boundFunction = function(){
		return that.apply(obj);
	}

	return boundFunction;
}

function Cat(){
	this.name = 'Sam'
}

var sayName = function(){
	console.log(this.name);
}

var sam = new Cat();
console.log("theirs")
sayName.bind(sam)();
console.log("ours");

var ourBoundFunction = sayName.myBind(sam);
ourBoundFunction();
//sayName.myBind(sam)();