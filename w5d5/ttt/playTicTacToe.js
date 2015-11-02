var readline = require("readline");
var reader = readline.createInterface({
  input: process.stdin,
  output: process.stdout,
  terminal: false
});
var Stuff = require("./index.js");
var board = new Stuff.Board ();
console.log(board);
var game = new Stuff.Game(reader);
game.run(function(){ console.log( this.players[this.currentPlayer] + " wins!")}.bind(game));
