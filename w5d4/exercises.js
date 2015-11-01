var x = [1,2,3]
var y = [2,3,4]

Array.prototype.myUniq = function () {
  var returnArray = [];
  var seenHash = {};
  for (var i = 0; i < this.length; i++){
    if (!seenHash[this[i]]) {
      returnArray.push(this[i]);
      seenHash[this[i]] = true;
    }
  }
  return returnArray;
};

Array.prototype.twoSum = function () {
  var returnArray = [];
  for (var i = 0; i < (this.length - 1); i++) {
    for (var j = i+1; j < this.length; j++) {
      if (this[i] + this[j] === 0) {
        returnArray.push([i,j]);
      }
    }
  };
  return returnArray;
};

Array.prototype.myTranspose = function () {
  var tArray = [];
  for (var i = 0; i < this[0].length; i++) {
    tArray.push([]);
  };
  for (var i = 0; i < this.length; i++) {
    for (var j = 0; j < this[0].length; j++){
      tArray[j].push(this[i][j]);
    }
  };
  return tArray;
};

Array.prototype.myEach = function (func) {
  for (var i = 0; i < this.length; i++) {
    func(this[i]);
  };
  return this;
};

var printMe = function(num){
  console.log(num);
};


Array.prototype.myMap = function (func) {
  var returnArray = [];
  var boo = function(ele){ returnArray.push(func(ele)) }
  this.myEach(function(ele){ returnArray.push(func(ele)) })
  return returnArray
};

Array.prototype.myInject = function (func) {
  var accumulator = this[0];
  (this.slice(1)).myEach(function(ele) { accumulator = func(accumulator, ele) });
  return accumulator;
};

var injectFunc = function(x, y) {
  return x + y;
};

Array.prototype.bubbleSort = function (){
  do {
    var unSorted = false;
    for (var i = 0; i < this.length-1; i++){
      if(this[i] > this[i+1]){
        var x = this[i];
        var y = this[i+1];
        this[i] = y;
        this[i+1] = x;
        unSorted = true;
      }
    }
  } while (unSorted);
  return this;
};

String.prototype.subStrings = function () {
  var returnArray = [];
  var seen = {};
  for (var i = 0; i < this.length; i++) {
    for (var j = i + 1; j <= this.length; j++) {
      var sub = this.slice(i,j)
      if ( !(seen[sub]) ){
        returnArray.push(sub);
        seen[sub] = true;
      }
    }
  }
  return returnArray;
};

var exp = function(base, exponent){
  var result = 1;
  if(exponent === 0){
    return result;
  }
  else{
    result = base * exp(base, exponent-1);
  }
  return result;
};

var fibo = function(n){
  var base = [0, 1];
  if (n === 1){
    return [0];
  }
  else if (n === 2){
    return base;
  }
  else{
    var lastFibs = fibo( n - 1 );
    var nextFib = lastFibs[n - 2] + lastFibs[n - 3];
    lastFibs.push(nextFib);
    return lastFibs;
  }
};

Array.prototype.bSearch = function (target) {
  var mid = Math.floor(this.length / 2);

  if ( this[mid] < target ){
    var rightHalf = this.slice(mid + 1);
    var result = (rightHalf.bSearch(target));
    if ( result === null){
      return null;
    }
    else {
      return result + mid + 1;
    }
  }
  else if ( this[mid] > target ) {
    var leftHalf = this.slice(0,mid);
    var result = leftHalf.bSearch(target);
    if ( result === null){
      return null;
    }
    else {
      return result;
    }
  }
  else if ( this[mid] === target) {
    return mid;
  }
  else if (this.length === 0) {
    return null;
  }
};

var makeChange = function (total, coins){
  var bestChange = [];
  for (var i = 0; i < coins.length; i ++){
    if (total < coins[i]) { continue; }
    var dif = total - coins[i];
    var nextChange = makeChange(dif, coins.slice(i))
    nextChange.push(coins[i]);
    if ((bestChange.length > nextChange.length) || (bestChange.length === 0 )) {
      bestChange = nextChange;
    }
  }
  return bestChange;
};

Array.prototype.mergeSort = function(){
  if (this.length <= 1){
    return this;
  }
  var mid = Math.floor(this.length / 2);

  var merge = function(array1, array2){
    var returnArray = [];
    var ar1 = array1;
    var ar2 = array2;
    while (ar1.length != 0 || ar2.length != 0){
        if (ar1[0] < ar2[0]){
          returnArray.push(ar1[0]);
          ar1 = ar1.slice(1);
        }
        else{
          returnArray.push(ar2[0]);
          ar2 = ar2.slice(1);
        }
    }
    return returnArray.concat(ar1.concat(ar2));
  }

  var left = this.slice(0,mid);
  var right = this.slice(mid);
  left = left.mergeSort();
  right = right.mergeSort();
  return merge(left, right);
};

Array.prototype.subSets = function () {
  var seen = {};
  if (this.length === 0){
    return [[]];
  }
  var firstEl = this[0];
  var otherSubSets = (this.slice(1)).subSets();
  var ourSubSets = [];
  for (var i = 0; i< otherSubSets.length; i++){
    var toConcat = (otherSubSets[i].concat(firstEl)).sort();
    if (!(seen[toConcat.toString()])){
      ourSubSets.push(toConcat);
      seen[toConcat.toString()] = true;
    }
  };
  return otherSubSets.concat(ourSubSets);
};


var Cat = function(name, owner){
  this.name = name;
  this.owner = owner;
};

Cat.prototype.cuteStatement = function(){
  return this.owner + " loves " + this.name;
};

Cat.prototype.meow = function() {
  return "meow";
};

// ---------------------------------------------------------------

var Student = function(fname,lname){
  this.fname = fname;
  this.lname = lname;
  this.courses = [];
};

var Course = function(name,department,credits, days, timeblock){
  this.name = name;
  this.department = department;
  this.credits = credits;
  this.students = [];
  this.days = days;
  this.timeblock = timeblock;
};

Student.prototype.name = function(){
  return this.fname + " " + this.lname;
}

Student.prototype.enroll = function(course){
  this.courses.push(course);
  course.students.push(this);
};

Course.prototype.addStudent = function(student){
  student.enroll(this);
};

Student.prototype.courseLoad = function(){
  var creditLoad = {};
  for (var i = 0; i < this.courses.length; i++){
    var thisCourse = this.courses[i];
    creditLoad[thisCourse.department] += thisCourse.credits;
  }
  return creditLoad;
};
