console.log("Eureka!")

Array.prototype.noDups = function(){
	var newArray = [];
this.forEach(function(element /*, index, array */){
		if(newArray.indexOf(element) === -1){
			newArray.push(element);
		}
	});
	return newArray;
}
console.log([1,1,2,2,3,3,3,4].noDups());

Array.prototype.twoSum = function(){
	var newArray = [];
	this.forEach(function(startElement, startIndex, array) {
		array.slice(startIndex + 1).forEach(function(endElement, endIndex, subArray) {
			if (startElement + endElement === 0) {
				newArray.push([startIndex, endIndex + startIndex + 1]);
			}
		});
	});
	return newArray;
}

console.log([-1, 0, 2, -2, 1].twoSum());

Array.prototype.transpose = function(){
	var transposed = new Array(this.length);
	this.forEach(function(row, rowIndex) {

		row.forEach(function(element, colIndex) {
			if(rowIndex ===0) {
				transposed[colIndex] = new Array(transposed.length);
			}
			transposed[colIndex][rowIndex] = element;
		});
	});
	return transposed;
}

var rows = [
    [0, 1, 2],
    [3, 4, 5],
    [6, 7, 8]
  ];

console.log(rows.transpose());
