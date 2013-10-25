(function(root) {
  var Snake = root.Snake = (root.Snake || {});
  var Board = Snake.Board = function(){
    this.buildBoard();
    this.cobra = new Snake.Cobra();
  }

  Snake.GAME_SIZE = 20;

  Board.prototype.buildBoard = function(){
    this.board = [];
    for(var i = 0; i < Snake.GAME_SIZE; i++){
      this.board[i] = [];
      for(var j = 0; j < Snake.GAME_SIZE; j++){
        this.board[i][j] = '.';
      }
    }
  }

  Board.prototype.updateBoard = function(){
    this.buildBoard();
    for(var i = 0; i < this.cobra.segments.length; i++){
      this.board[this.cobra.segments[i].row][[this.cobra.segments[i].col]] = 'S';
    }
  }

  Board.prototype.isSnakeDead = function() {
    var col = this.cobra.segments[0].col;
    var row = this.cobra.segments[0].row;

    if (col >= Snake.GAME_SIZE || row >= Snake.GAME_SIZE ) {
      return true;
    } else if (col < 0 || row < 0 ) {
      return true;
    }

    return false;

  }

  //
  // Board.prototype.render = function() {
  //
  //   for(var i = 0; i < Snake.GAME_SIZE; i++){
  //     var printableRow = [''];
  //     for(var j = 0; j < Snake.GAME_SIZE; j++){
  //       printableRow[i] += this.board[i][j];
  //       //randomly add apples;
  //     }
  //
  //     console.log(printableRow);
  //   }
  // }

})(this);