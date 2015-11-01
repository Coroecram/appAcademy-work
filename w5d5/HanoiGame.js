
var readline = require('readline');
var reader = readline.createInterface({
  input: process.stdin,
  output: process.stdout
});

var HanoiGame = function () {
  this.towers = {
    1 : [3,2,1],
    2 : [],
    3 : []
  };
};


HanoiGame.prototype.isWon = function () {
  console.log(this.towers["2"]);
  if (this.towers["2"][2] === 1 || this.towers["3"][2] === 1 ) {
    return true;
  }
  return false;
};

HanoiGame.prototype.isValidMove = function (startIdx, endIdx) {
  if (this.towers[endIdx].last > this.towers[startIdx].last ||
      this.towers[endIdx].last === undefined) {
    return true;
  }
  return false;
};


HanoiGame.prototype.move = function (startIdx, endIdx) {
  console.log(this);
  if (this.isValidMove(startIdx, endIdx)){
    this.towers[endIdx].push(this.towers[startIdx].pop());
    return true;
  }
  return false;
};

HanoiGame.prototype.print = function() {
  console.log(JSON.stringify("Tower 1: " + this.towers[1]));
  console.log(JSON.stringify("Tower 2: " + this.towers[2]));
  console.log(JSON.stringify("Tower 3: " + this.towers[3]));
};

HanoiGame.prototype.promptMove = function (callback) {
  this.print();
  reader.question("Move from where?", function (numString1){
    reader.question("Move to where?", function (numString2) {
      var fromTower = numString1;
      var toTower = numString2;
      if (callback(fromTower, toTower)){
        console.log ("\nERROR: WRONG TOWER");
        this.promptMove(callback);
      }
    }.bind(this));
  }.bind(this));
};

HanoiGame.prototype.run = function (completionCallback){
  this.promptMove(function (startIdx, endIdx) {
    this.move(startIdx, endIdx);
    if (this.isWon()) {
      completionCallback();
    } else {
      this.run(completionCallback);
    };
  }.bind(this));
};

HanoiGame.prototype.completeGame = function () {
    reader.close();
  console.log("You're amazing!");
  console.log("You builded tower!");
};

var game = new HanoiGame();
console.log(game);
game.run(game.completeGame);
