// Write a recursive method, range, that takes a start and an end and returns an array of all numbers between.
var range = function(start, end){
	if(start === end){
		return [start];
	}else{
		return [start] + range(start + 1, end);
	}
};

console.log(range(1,5));


// Write both a recursive and iterative version of sum of an array.
var recSum = function(array){
	if(array.length === 0){
		return 0;
	}
	else if(array.length === 1){
		return array[0];
	}
	else{
		return array[0] + recSum(array.slice(1));
	}
};

console.log(recSum([1,1,1,1]));

var iterSum = function(array){
	var sum = 0;
	for (var i = 0; i < array.length; i++) {
		sum += array[i];
	}
	return sum;
};

console.log(iterSum([1,1,-1,1]));

// Write two versions of exponent that use two different recursions:

var exp = function(base, expon) {
	if (expon === 0) {
		return 1;
	}
	else {
		return base * exp(base, expon - 1);
	}
};

console.log(exp(2, 5));

var exp2 = function(base, expon) {
	if (expon === 0) {
		return 1;
	}
	else if (expon % 2 === 0) {
		var subexp = exp(base, expon / 2);
		return subexp * subexp;
	}
	else {
		var subexp = exp(base, (expon - 1) / 2);
		return base * subexp * subexp;
	}
};

console.log(exp2(2, 5));

var recFib = function(num) {
	if (num === 0) {
		return [];
	}
	else if (num === 1) {
		return [0];
	}
	else if (num === 2) {
		return [0, 1];
	}
	else {
		var lastFibs = recFib(num-1);
		return lastFibs.concat(lastFibs[lastFibs.length-1] + lastFibs[lastFibs.length-2]);
	}
};

console.log(recFib(10));

var iterFib = function(num){
	var result = [];
	for(var i = 0; i < num; i++){
		if(i ===0 ){
			result.push(0);
		}
		else if(i === 1){
			result.push(1);
		}
		else{
			result.push(result[i - 1] + result[i - 2]);
		}
	}
		return result;
}

console.log(iterFib(10));


var recBinarySearch = function(array, target){
	var midIndex = Math.floor(array.length / 2);
	var midItem = array[midIndex];
	if(array.length === 0){
		return -1;
	}
	if(midItem === target){
		return midIndex;
	}
	else if(midItem < target){
		var subResult = recBinarySearch(array.slice(midIndex + 1), target);
		return subResult === -1 ? -1 : midIndex + subResult + 1;
	}
	else if(midItem > target){
		var subResult = recBinarySearch(array.slice(0, midIndex), target);
		return subResult === -1 ? -1 : subResult;
	}
}

console.log(recBinarySearch([0, 1, 1, 2, 3, 5, 8, 13, 21, 34], 35));

var makeChange = function(value, coins) {
	if (value === 0) {
		return [];
	}
	else {
		for(var i = 0; i < coins.length; i++){
			if (value >= coins[i])
			{
				return [coins[i]].concat(makeChange(value - coins[i], coins ));
				break;
			}
		}
		return null;
	}

};

console.log(makeChange(39, [25, 10, 5, 1]));

var merge = function(left, right) {
	var result = []
	while (left.length || right.length) {
		if (left.length && right.length) {
			if (left[0] <= right[0]) {
				result.push(left.shift());
			}
			else {
				result.push(right.shift());
			}
		}
		else if (left.length) {
			return result.concat(left);

		}
		else {
			return result.concat(right);
		}
	}
};

var mergeSort = function(array){
	if(array.length < 2){
		return array;
	}
	else{
		var midIndex = Math.floor(array.length / 2);
		var left = mergeSort(array.slice(0, midIndex));
		var right = mergeSort(array.slice(midIndex));
		return merge(left, right);
	}
};

console.log(mergeSort([9, 4, 643, -1, 6, 9, 4]));

var subsets = function(array){
	if (array.length === 0){
		return [[]];
	}
	else {

		var the_rest =  subsets(array.slice(0, array.length - 1));
		var last_item = array[array.length - 1];
		var this_group = [];
		for(var i = 0; i < the_rest.length; i++){
			this_group.push(the_rest[i].concat(last_item));
			//the_rest.push(the_rest[i].concat(last_item));
		}
		return the_rest.concat(this_group);
	}
};

console.log(subsets([]));
console.log(subsets([1]));
a = subsets([1,2]);
console.log(a);
console.log(subsets([1,2,3]));


















