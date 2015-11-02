var Board = require('./board.js');
var board = new Board ();

var Game = function (reader){
  this.reader = reader,
  this.currentPlayer = 0,
  this.players = ["X", "O"]
};

Game.prototype.run = function (completionCallback) {
  board.render()
    this.reader.question("Place your mark where? (x, y)", function (position) {
      var posArray = position.split(", ")
      posArray[0] = parseInt(posArray[0]);
      posArray[1] = parseInt(posArray[1]);
      if (posArray.length != 2 ){
        console.log("That is not a valid length.");
        this.run(completionCallback);
      } else if ( typeof(posArray[0]) != "number" || typeof(posArray[1]) != "number"){
        console.log("Those aren't numbers.");
        this.run(completionCallback);
      } else if( posArray[0] !== posArray[0] || posArray[1] !== posArray[1] ){
          console.log("That is not a valid input.");
          this.run(completionCallback);
      } else if ( this.rangeCheck(posArray)){
        console.log("That is not a valid position.");
        this.run(completionCallback);
      } else if (!board.empty(posArray[0], posArray[1])){
        console.log("That position is already taken.");
        this.run(completionCallback);
      } else {
        var row = parseInt(posArray[0]);
        var col = parseInt(posArray[1]);
        var mark = this.players[this.currentPlayer];
        debugger
        board.mark(row, col, mark);
        if (board.won() === true){
          board.render();
          completionCallback();
          this.reader.close();
        }else {
          this.currentPlayer = (this.currentPlayer === 0 ? 1 : 0);
          this.run(completionCallback);
        }
      };
    }.bind(this));
};

Game.prototype.rangeCheck = function (posArray) {
  parseInt(posArray[0]) > 2 || parseInt(posArray[1] > 2) ||
  parseInt(posArray[0]) < 0 || parseInt(posArray[1] < 0 )};

module.exports = Game;
