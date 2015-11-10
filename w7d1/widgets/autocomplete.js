var Autocomplete = React.createClass({
  getInitialState: function() {
    return { searchString: "" };
  },
  handleChange: function(e){
    this.setState({ searchString: e.target.value });
  },
  render: function(){
    var names = this.props.names,
      searchString = this.state.searchString.trim().toLowerCase();
    if(searchString.length > 0){
      names = names.filter(function(name){
        return name.toLowerCase().match(searchString);
      });
    }
    namesLI = function(){
      var arrayLI = [];
      for (var i = 0; i < names.length; i++){
        arrayLI.push(<li>{names[i]}</li>);
      }
      return arrayLI;
    }();
    return (
      <div>
        <h1>Autosearch</h1>
        <input
          type="text"
          value={this.state.searchString}
          onChange={this.handleChange}
          placeholder="Search name here" />
        <ul>
          {namesLI}
        </ul>
      </div>
    );
  }
});

var names = [ "Tommy", "Sennacy", "Firetrux", "Breakfast", "Brunch", "Zebra", "Fox McCloud" ];
