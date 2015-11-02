var Board = function () {
  this.layout = [[], [], []]
};

Board.prototype.diagonal1 = function () {
   return [this.layout[0][0], this.layout[1][1], this.layout[2][2]];
  };

Board.prototype.diagonal2 = function () {
  return [this.layout[0][2], this.layout[1][1], this.layout[2][0]];
  };

Board.prototype.position = function (row, col) {
  return this.layout[row][col];
};

Board.prototype.empty = function (row, col) {
  return this.position(row, col) === undefined;
};

Board.prototype.mark = function (row, col, mark) {
  if (!this.empty(row, col)) {
    return "Cannot place mark there"
  } else {
    this.layout[row][col] = mark;
  };
};

Board.prototype.render = function () {
  for (var i = 0; i < 3; i++){
    var rowDisplay = "";
      for (var j = 0; j < 3; j++){
        if ( j != 2 ){
          debugger
          if (this.empty(i,j)){
            rowDisplay = rowDisplay + "  | ";
          }else {
            rowDisplay = rowDisplay + this.position(i,j) + " | ";
          };
        } else {
          if (this.empty(i,j)){
            rowDisplay = rowDisplay + "  ";
          }else {
            rowDisplay = rowDisplay + this.position(i,j);
          };
        };
      }
    console.log(rowDisplay);
    if (i < 2){
      console.log("----------")
    };
  }
};

Board.prototype.won = function (){
  var columns = [[], [], []];
  for (var i = 0; i < 3; i++){
    if ( this.layout[i].matches(["X", "X", "X"]) ) {
      console.log("here");
      return true;
    } else if (this.layout[i].matches(["O", "O", "O"])){
      console.log("here2");
      return true;
    }
    for (var j = 0; j < 3; j++){
      columns[j].push(this.layout[i][j]);
    };
  };
  for (var j = 0; j < 3; j++){
    if (columns[j].matches(["X", "X", "X"]) || columns[j].matches(["O", "O", "O"])){
      console.log("here3");
      return true;
    };
  };
  var diagonalDown = this.diagonal1();
  var diagonalUp = this.diagonal2();
  if ( diagonalDown.matches(["X", "X", "X"]) || diagonalUp.matches(["X", "X", "X"]) ){
    console.log("here4");
    return true;
  } else if (diagonalDown.matches(["O","O","O"])  || diagonalUp.matches(["O","O","O"])){
    console.log("here5");
    return true;
  };
  return false;
};

Array.prototype.matches = function(arr2) {
  if (this.length != arr2.length || !Array.isArray(arr2)) {
    return false;
  } else {
    for (var i = 0; i < this.length; i++) {
      if (this[i] !== arr2[i]){
        return false;
      }
    }
    return true;
  }
};

module.exports = Board;
// Board.layout[0][0] = "O";
// Board.layout[1][0] = "O";
// Board.layout[2][0] = "O";
