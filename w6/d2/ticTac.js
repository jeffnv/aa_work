var readline = require('readline');
var READER = readline.createInterface({
	input: process.stdin,
	output: process.stdout
});


(function (root) {
	var TicTacToe = root.TicTacToe = (root.TicTacToe || {});

	var Game = TicTacToe.Game = function(){
		this.name = "TicTacToe";
		this.player1 = new Player(" X ");
		this.player2 = new Computer(" O ");
		this.board = new Board();
		this.currentPlayer = this.player1;
	}

	Game.prototype.play = function () {
		console.log("Welcome to TicTacToe!");
		this.currentPlayer.getMoveFromPlayer(this.board, this.playMove.bind(this));
	}

	Game.prototype.playMove = function(row, col, playerSymbol){
		this.board.makeMoveForPlayer(row, col, playerSymbol);
		if(this.board.gameWon(playerSymbol)){
			this.board.print();
			console.log(playerSymbol + " won the game!");
		}
		else
		{
			this.currentPlayer =
			(this.currentPlayer === this.player1) ? this.player2 : this.player1;

			this.currentPlayer.getMoveFromPlayer(this.board, this.playMove.bind(this));
		}

	}

	var Computer  = TicTacToe.Computer = function(symbol){
		this.symbol = symbol;
	}

	Computer.prototype.getMoveFromPlayer = function(gameBoard, playMoveCallback) {
		//check every emptySquare and see if a move there would result in a victory
		//if so, make that move
		var empties = gameBoard.emptySquareArray();

		for (var i = 0; i < empties.length; i++) {
			var row = empties[i][0];
			var col = empties[i][1];
			gameBoard.makeMoveForPlayer(row, col, this.symbol);
			if (gameBoard.gameWon(this.symbol)) {
				// return winning move
				playMoveCallback(row, col, this.symbol);
				return;
			}
			else {
				gameBoard.makeMoveForPlayer(row, col, " - ");
			}
		}

		//if not, pick a random one
		var randomMove = empties[Math.floor(Math.random() * empties.length)];

		playMoveCallback(randomMove[0], randomMove[1], this.symbol);
	}


	var Player = TicTacToe.Player = function(symbol) {
		this.symbol = symbol;
	}

	Player.prototype.getMoveFromPlayer = function(gameBoard, playMoveCallback) {
		gameBoard.print();
		var that = this;

		READER.question("Enter row to move from: ", function (row) {
			READER.question("Enter column to move to: ", function (col) {
				row = parseInt(row);
				col = parseInt(col);

				if (gameBoard.emptySquare(row, col)) {
					playMoveCallback(row, col, that.symbol);
				}
				else {
					console.log("You selected an occupied square. Please try again");
					that.getMoveFromPlayer(gameBoard, playMoveCallback);
				}

			});
		});
	}

	var Board = TicTacToe.Board = function() {
		this.state = [[" - ", " - ", " - "],
		[" - ", " - ", " - "],
		[" - ", " - ", " - "]];
	}

	Board.prototype.makeMoveForPlayer = function(row, col, playerSymbol) {
		this.state[row][col] = playerSymbol;
	}

	Board.prototype.rowVictory = function (playerSymbol) {
		for (var row = 0; row < this.state.length; row++) {
			if (this.state[row][0] === playerSymbol &&
				this.state[row][1] === playerSymbol &&
				this.state[row][2] === playerSymbol) {
					return true;
				}
			}

			return false;
		}

		Board.prototype.colVictory = function (playerSymbol) {
			for (var col = 0; col < this.state.length; col++) {
				if (this.state[0][col] === playerSymbol &&
					this.state[1][col] === playerSymbol &&
					this.state[2][col] === playerSymbol) {
						return true;
					}
				}

				return false;
			}

			Board.prototype.diagVictory = function (playerSymbol) {
				if (this.state[0][0] === playerSymbol &&
					this.state[1][1] === playerSymbol &&
					this.state[2][2] === playerSymbol) {
						return true;
					}

					if (this.state[0][2] === playerSymbol &&
						this.state[1][1] === playerSymbol &&
						this.state[2][0] === playerSymbol) {
							return true;
						}

						return false;
					}


					Board.prototype.gameWon = function(playerSymbol) {

						return (
							this.rowVictory(playerSymbol) ||
							this.colVictory(playerSymbol) ||
							this.diagVictory(playerSymbol)
						)
					}

					Board.prototype.print = function() {
						for (var i = 0; i < this.state.length; i++) {
							console.log(this.state[i]);
						}
					}

					Board.prototype.emptySquare = function(row, col) {
						return this.state[row][col] === " - ";
					}

					Board.prototype.emptySquareArray = function(){
						var empties = [];
						for(var i = 0; i < this.state.length; i++)
						{
							for(var j = 0; j < this.state[i].length; j++){
								if(this.emptySquare(i, j)){
									empties.push([i,j]);
								}
							}
						}
						return empties;
					}



				})(this);

				var root = this;
				var game = new root.TicTacToe.Game();
				game.play();