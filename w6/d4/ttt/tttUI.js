(function(root) {
  var TTT = root.TTT = (root.TTT || {})

  var UI = TTT.UI = function(game, maincontainer) {
    this.game = game;
    this.maincontainer = maincontainer;

    //binds css elements

    maincontainer.on('click', '.ttt-tile', this.handleClick.bind(this));

  }

  UI.prototype.handleClick = function(event){
    var clickLoc = [];
    clickLoc[0] = parseInt($(event.target).attr("data-row"));
    clickLoc[1] = parseInt($(event.target).attr("data-col"));

    var currentPlayer = this.game.player;
    var moveSuccess = this.game.move(clickLoc);

    if (!moveSuccess) {
      alert("Illegal move!");
    } else {
      $(event.target).html(currentPlayer);
      this.checkForWinner(currentPlayer);
    }
  }

  UI.prototype.checkForWinner = function(currentPlayer){
    if(this.game.winner()){
      alert(currentPlayer + " wins!!!");
      this.resetGame();
    }
  }

  UI.prototype.play = function() {
    // move(2 coord array), returns t or f depending on success
    //check winner(), returns t or f
    // validpos()?


  }

  UI.prototype.resetGame = function(){
    //create a new game object, reset all squares to empty
    this.game = new TTT.Game();

    $('.ttt-tile').html('');
  }






})(this)