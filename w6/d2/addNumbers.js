var readline = require('readline');
var READER = readline.createInterface({
  input: process.stdin,
  output: process.stdout
});

function addNumbers(sum, numsLeft, completionCallback) {
	if(numsLeft > 0) {
		READER.question("Enter number:", function (numberString) {
      var number = parseInt(numberString);
			sum += number;
			console.log("current sum: " + sum);
			addNumbers(sum, numsLeft - 1, completionCallback);
    });
	}
	else {
		completionCallback(sum);
	}
}

addNumbers(0, 4, function (sum) {
  console.log("Total Sum: " + sum);
});