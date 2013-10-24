Function.prototype.inherits = function(parentObj) {
	function Surrogate() {};
	Surrogate.prototype = parentObj.prototype;
	this.prototype = new Surrogate();
}

function MovingObject() {};

MovingObject.prototype.moving = function() {
	console.log("i'm moving!");
}

function Ship() {}

Ship.inherits(MovingObject);

s = new Ship();

s.moving();

Ship.prototype.shipMoves = function() {
	console.log("ship is moving!");
}

new MovingObject().shipMoves();