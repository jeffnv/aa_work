(function(root){
  var UI = Hanoi.UI = (Hanoi.UI || {});

  UI = Hanoi.UI = function(game, $el){
    this.game = game;
    this.$el = $el; //$('div.hanoi')
    this.fromTree = -1;
  };


  UI.prototype.play = function(){
    this.render();
    this.bindEvents();
  };

  UI.prototype.handleClick = function(event){
    var treeIndex = parseInt($(event.target).data('id'));

    if ($(event.target).attr('class') === 'disc') {
      treeIndex =  parseInt($(event.target.parentNode).data('id'));
    }

    if(this.fromTree === -1){
      this.fromTree = treeIndex;
    }
    else{
      this.game.move(this.fromTree, treeIndex);
      this.fromTree = -1;
    }

    if(this.game.isWon()) {
      alert('Congrats, you are the king of Hanoi!')
      this.game = new Hanoi.Game();
    }

    this.render();
  }




  UI.prototype.bindEvents = function(){
    this.$el.on('click', '.tower', this.handleClick.bind(this));
    // this.$el.on('click', '.disc', this.handleClick.bind(this));

  };

  UI.prototype.render = function(){
    //
    this.$el.empty();
    for(i = 0; i < this.game.towers.length; i++) {
      this.$el.append("<div class='tower' data-id=" + i +"></div>");
      var $tree = $('[data-id=' + i + ']');
      if(this.fromTree === i){
        //color the tree differently
        $tree.css('background-color', 'orange')
      }

      for(j = this.game.towers[i].length - 1; j >= 0; j--) {
        // appends the tile
        // var disc = document.createElement('div');
        var dataDiscSize = this.game.towers[i][j];

        $tree.append("<div class='disc' data-disc-size=" + dataDiscSize +  "></div>");

        $('[data-disc-size=' + dataDiscSize + ']').width((dataDiscSize *100) + "%");
        $('[data-disc-size=' + dataDiscSize + ']').css('left', (-1 * (dataDiscSize -1) * 50) + "%");

      }

    }
    //$('.disc').css('width', $(this).attr('data-disc-size') * 100);
  }

})(this)