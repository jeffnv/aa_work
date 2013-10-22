var Cat = function(name, owner){
	this.owner = owner;
	this.name = name;
};

Cat.prototype.cuteStatement = function(){
//	return this.owner + " loves " + this.name + "!";
return this.owner + " loves " + this.name + "!";

}

var theCatNamedBob = new Cat("Bob", "Fred");
var allison = new Cat("Allison", "John");
console.log(theCatNamedBob.cuteStatement());
console.log(allison.cuteStatement());

Cat.prototype.cuteStatement = function(){
//	return this.owner + " loves " + this.name + "!";
return "Everybody loves " + this.name + "!";
}

console.log(theCatNamedBob.cuteStatement());
console.log(allison.cuteStatement());

Cat.prototype.meow = function(){
	return "Meow!";
}

allison.meow = function(){
	return "ROAR!";
}

console.log(theCatNamedBob.meow());
console.log(allison.meow());
