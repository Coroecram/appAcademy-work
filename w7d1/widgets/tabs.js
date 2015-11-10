var Tabs = React.createClass({
  getInitialState: function(){
    return { activeIndex: 0 };
  },
  handleClick: function(e){
    var selectedIdx = parseInt(e.currentTarget.id);
    this.setState({activeIndex : selectedIdx});
  },
  render: function(){
    var titlesLI = [];
    var articlesLI = [];
    for (var i = 0; i < this.props.articles; i++){
      var title = <li key={i} id={i} onClick={this.handleClick}><strong className={ (this.state.activeIndex === i ? "active" : "") + " title" }>Articles {i+1}</strong></li>;
      var article = <li key={i} id={i}><p className={ this.state.activeIndex === i ? "active" : "" }> {i}{i}{i}{i}{i}{i} Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore
                                magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.</p></li>;

      titlesLI.push(title);
      articlesLI.push(article);
    }

    return(
      <div>
      <h1>ArticleTabs</h1>
        <ul className="group">
          {titlesLI}
        </ul>
        <ul>
          {articlesLI}
        </ul>
      </div>
    );
  }
});
