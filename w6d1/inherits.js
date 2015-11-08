"use strict";

Function.prototype.inherits = function (SuperClass) {
  var Surrogate = function () {};
  Surrogate.prototype = SuperClass.prototype;
  this.prototype = new Surrogate();
  this.prototype.constructor = this;
}
