"use strict";

var curriedSum = function (numArgs) {
  var numbers = [];
  return function () {
    numbers.push(arguments[0]);

    if ( numbers.length === numArgs ) {
      return function () {
        var sum = 0
        for (var i = 0; i < numbers.length; i++) {
          sum += numbers[i];
        };

        return sum;
      }();
    };
  };
}
