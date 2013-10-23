var readline = require('readline');
var READER = readline.createInterface({
  input: process.stdin,
  output: process.stdout
});

var askLessThan = function(el1, el2, callback) {
	READER.question("Is " + el1 + " < " + el2 + "?:", function(response) {
		if (response === "yes") {
			callback(true);
		}
		else {
			callback(false);
		}
	});
};

var performSortPass = function(arr, i, madeAnySwaps, callback) {
	if (i < arr.length - 1) {
		askLessThan(arr[i], arr[i + 1], function(lessThan) {
			if (!lessThan) {
				var placeHolder = arr[i + 1];
				arr[i + 1] = arr[i];
				arr[i] = placeHolder;
				madeAnySwaps = true;
			}
			performSortPass(arr, (i + 1), madeAnySwaps, callback);
		}
	);

	}
	else {
		callback(madeAnySwaps);
	}
};

var crazyBubbleSort = function(arr, sortCompletionCallback) {
	var sortPassCallBack = function(madeAnySwaps) {
		if (madeAnySwaps) {
			performSortPass(arr, 0, false, sortPassCallBack);
		}
		else {
			sortCompletionCallback(arr);
		}
	};

	sortPassCallBack(true);
};







 crazyBubbleSort([3, 2, 1], function (arr) { console.log(arr) });