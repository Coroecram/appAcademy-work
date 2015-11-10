var WeatherClock = React.createClass({
  getInitialState: function() {
    return {time: new Date(), state: undefined, condition: undefined, temp: undefined };
  },
  componentDidMount: function() {
    this.timer = setInterval(this.tick, 1000);
    this.getWeather();
  },
  componentWillUnmount: function(){
    clearInterval(this.timer);
  },
  tick: function(){
      this.setState({ time: new Date() });
  },
  getWeather: function(){
    return navigator.geolocation.getCurrentPosition(function(position){
      var lat = position.coords.latitude.toFixed(2);
      var lon = position.coords.longitude.toFixed(2);

      this.xmlRequest(lat, lon);

    }.bind(this));
  },
  xmlRequest: function(lat, lon){
    var apiKey = 'cf990e4aaf4d2e948227605078344cfd';
    var url = 'http://api.openweathermap.org/data/2.5/weather?lat=' + lat + '&lon=' + lon + '&APPID=' + apiKey;
    var xmlhttp;
    var weatherClock = this;

    if (window.XMLHttpRequest) {
        // code for IE7+, Firefox, Chrome, Opera, Safari
        xmlhttp = new XMLHttpRequest();
    } else {
        // code for IE6, IE5
        xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
    }

    xmlhttp.onreadystatechange = function() {
        if (xmlhttp.readyState == XMLHttpRequest.DONE ) {
           if(xmlhttp.status == 200){
              var weather = JSON.parse(xmlhttp.responseText);
              var weatherCity = weather.name;
              var weatherCond = weather.weather[0].main;
              var weatherTemp = Math.floor(weather.main.temp);

              weatherClock.setState({ city: weatherCity, condition: weatherCond, temp: weatherTemp });
           }
           else if(xmlhttp.status == 400) {
              return;
           }
           else {
            return;
           }
        }
    };

    xmlhttp.open("GET", url, true);
    xmlhttp.send();
  },

  displayWeather: function(){
    if(this.state.city === undefined) {
      return "weather loading...";
    }
    var kToF = Math.ceil((this.state.temp *  9/5) - 459.67);
    return ('City: ' + this.state.city + ' Condition: ' + this.state.condition + ' Temperature: ' + kToF + 'F');
  },

  render: function(){
    return (
      <div><h1>Weather Clock</h1>
        <p className="wc"> Current Time: {this.state.time.toString()}</p>
        <p className="wc"> {this.displayWeather()} </p>
      </div>
    );
  }
});
