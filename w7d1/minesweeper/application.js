var Board = React.createClass({
  handleClick: function(e){
    debugger;
    console.log("click");
  },
  render: function(){
    var grid = this.props.board.grid.map(function(row, rowIdx){
                    return (<div key={rowIdx} className="row group">
                        {row.map(function(tile, tileIdx){
                          return <Tile key={tileIdx} tile={tile} onClick={this.handleClick} update={this.props.update}/>;

                        }.bind(this))}
                    </div>);
               }.bind(this));
    return (
             <div>
               {grid}
             </div>
           );
  }
});

var Tile = React.createClass({
  displayState: function(){
    var tile = this.props.tile;
    if (tile.explored){
      if (tile.bombed){
        return " ۞ ";
      } else if (tile.adjacentBombCount() === 0){
        return "   ";
      } else {
        return " " + tile.adjacentBombCount() + " ";
      }
    } else if (tile.flagged){
      return " ⚑ ";
    } else {
      return " T ";
    }
  },


  render: function(){
    return <div onClick={this.props.onClick} className="tile">{this.displayState()}</div>;
  }

});



var Game = React.createClass({
  getInitialState: function() {
    return { board: new window.Minesweeper.Board(8,6),
             over: false,
             won: false
           };
  },
  updateGame: function() {
    return;
  },
  render: function() {
    return (
          <div>
            <Board board={this.state.board} update={this.updateGame} />
          </div>
        );
  }
});

React.render (
  <Game />,
  document.getElementById("minesweeper")
);
