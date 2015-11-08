"use strict";
Function.prototype.myBind = function (context) {
  var fn = this;
  var args = [].slice.call(arguments, 1);

  return function () {
    var allArgs = [];
    if (typeof(arguments) !== "undefined"){
      allArgs = [].slice.call(arguments);
    }

    allArgs.push(args);

    return fn.apply(context, allArgs);
  };
};
