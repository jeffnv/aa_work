(function(root) {
  var Snake = root.Snake = (root.Snake || {});
  var Cobra= Snake.Cobra =  function() {
    this.dir = "N";
    // this.segments = [new Snake.Coord(Snake.GAME_SIZE / 2, Snake.GAME_SIZE / 2)];
    this.segments = [new Snake.Coord(19, 10)];

  }

  Cobra.prototype.move = function(){

    var snakeBody = this.segments.slice(1);

    for (var i = this.segments.length - 1; i > 0; i--) {
      // currentCoord = this.segments[i];
      this.segments[i] = new Coord(this.segments[i-1].row, this.segments[i-1].col);
    }
    this.segments[0].plus(this.dir);

  }

  Cobra.prototype.turn = function(dir){
    this.dir = dir;
  }


  //*********************coords
  Snake.Coord = function(row,col){
    this.row = row;
    this.col = col;
  }

  Snake.Coord.prototype.plus = function(dir){
    switch(dir){
    case "N":
      this.row -=1;
      break;
    case "S":
      this.row += 1;
      break;

    case "W":
      this.col -= 1;
      break;

    case "E":
      this.col += 1;
      break;
    }
  }

})(this);