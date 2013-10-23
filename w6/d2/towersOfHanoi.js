var readline = require('readline');
var READER = readline.createInterface({
  input: process.stdin,
  output: process.stdout
});


(function (root) {
  var Hanoi = root.Hanoi = (root.Hanoi || {});

	var Game = Hanoi.Game = function(){
		this.name = "hanoi";
		this.player = new Player();
		this.board = new Board();
	}

	Game.prototype.play = function () {
		console.log("Welcome to Hanoi!");
		this.player.getMove(this.board);
	}

	var Player = Hanoi.Player = function() {
	}

	Player.prototype.getMove = function(gameBoard) {
		gameBoard.print();
		var that = this;

		READER.question("Enter column to move from: ", function (columnFrom) {
			READER.question("Enter column to move to: ", function (columnTo) {
				var col1 = parseInt(columnFrom);
				var col2 = parseInt(columnTo);

				gameBoard.movePiece(col1, col2);
				if (gameBoard.gameWon()) {
					console.log("You win!!");
					READER.close();
				}
				else
				{
					console.log(that);
					that.getMove(gameBoard);
				}
			});
		});
	}

	var Board = Hanoi.Board = function() {
		this.state = [[5, 4, 3, 2, 1], [], []];
	}

	Board.prototype.movePiece = function(col1, col2) {

		var piece = this.state[col1].pop();
		this.state[col2].push(piece);
	}

	Board.prototype.gameWon = function() {
		console.log(this.state[0]);
		console.log(this.state[1]);
		return this.state[0].length === 0 && this.state[1].length === 0;
	}

	Board.prototype.print = function() {
		console.log(this.state);
	}

})(this);

var root = this;
var game = new root.Hanoi.Game();
game.play();
// console.log(game.name);
//
//
// cat = {
// 	name: 'cat',
// 	sayName: function () {
// 		console.log(this.name);
// 	}
// }