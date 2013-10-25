(function(root) {
  var Snake = root.Snake = (root.Snake || {});

  var UI = Snake.UI =  function($el) {
    this.$el = $el;
  }

  UI.prototype.start = function(){
    this.board = new Snake.Board();
    //bind key events
    $(document).on('keydown', this.handleKeyEvent.bind(this));
    // this.step()
    this.intervalId = setInterval(this.step.bind(this), 100);

  }

  UI.prototype.handleKeyEvent = function(event) {

    switch (event.keyCode) {
    case 37://left
      this.board.cobra.turn("W");
      break;
    case 38://up
      this.board.cobra.turn("N");
      break;
    case 39://right
     this.board.cobra.turn("E");
      break;
    case 40://down
     this.board.cobra.turn("S");
      break;
    }

  }

  UI.prototype.step = function() {
    this.board.cobra.move();
    if(this.board.isSnakeDead()){
      alert("You DEAD!");
      this.board = new Snake.Board();
    }
    else{
      this.board.updateBoard();
      this.render();
    }


    //check for death

  }

  UI.prototype.render = function() {
    this.$el.empty();
    //redraw

    for(var i = 0; i < this.board.board.length; i++){
      this.$el.append("<div class='row' data-row-idx=" + i +"></div>");
      var $row = $('[data-row-idx=' + i + ']');
      for(var j = 0; j < this.board.board[i].length; j++){
        //is it a snake, apple or empty?
        //'.' for empty, 'S' for snake, 'A' for apple
        var boardContent = this.board.board[i][j];
        $row.append('<div class="square" data-type="' + boardContent +  '"></div>');

      }
    }

    $("[data-type='S']").css('background-color', 'red');

  }


})(this);