function Clock () {
  this.increment = 5000;
};

// Clock.increment = 5000;

Clock.prototype.printTime = function () {
  console.log(this);
  var hour = this.currentTime.getHours();
  var minutes = this.currentTime.getMinutes();
  var seconds = this.currentTime.getSeconds();
  console.log(hour + ":" + minutes + ":" + seconds);
};

Clock.prototype.run = function () {
  console.log(this);
  this.currentTime = new Date();
  this.printTime();
  setInterval(this._tick.bind(this),this.increment);

};

Clock.prototype._tick = function () {
  var seconds = this.currentTime.getSeconds() + 5;
  this.currentTime.setSeconds(seconds);
  this.printTime();
};



var readline = require('readline');
var reader = readline.createInterface({
  input: process.stdin,
  output: process.stdout
});

function addNumCallback (sum, numString, numsLeft) {
  var num = parseInt(numString);
  sum += num;
  console.log("Total sum:" + sum);
  numsLeft -= 1;
  if (numsLeft > 0) {
    addNumbers(sum, numsLeft, addNumCallback)
  } else {
    reader.close();
  };
};

function addNumbers (sum, numsLeft, completionCallback) {
    reader.question("What number to add?", function (numString) {
     completionCallback(sum, numString, numsLeft);
   });
};


function askIfGreaterThan (el1,el2, callback) {
  reader.question("Is " + el1 + " greater than " + el2 + "?", function (answer) {
    if (answer === "yes") {
      callback(true);
    } else {
      callback(false);
    };
  });
};


function innerBubbleSortLoop(arr, i, madeAnySwaps, outerBubbleSortLoop) {
  if (i < arr.length - 1){
    askIfGreaterThan(arr[i], arr[i+1], function (isGreaterThan) {
      if (isGreaterThan === true){
        var x = arr[i];
        var y = arr[i+1];
        arr[i] = y;
        arr[i+1] = x;
        innerBubbleSortLoop(arr, i + 1, true, outerBubbleSortLoop);
      }
      else {
        innerBubbleSortLoop(arr,i+1, madeAnySwaps, outerBubbleSortLoop);
      };
    });
  } else {
    outerBubbleSortLoop(madeAnySwaps);
  };
};

// function sortCompletionCallback (arr) {
//   console.log(arr);
//   return arr;
// };

function absurdBubbleSort(arr, sortCompletionCallback){
  function outerBubbleSortLoop(madeAnySwaps) {
    if (madeAnySwaps === true){
      innerBubbleSortLoop(arr, 0, false, outerBubbleSortLoop);
    } else  {
      sortCompletionCallback(arr);
    }
  }
  outerBubbleSortLoop(true);
};

absurdBubbleSort([3, 2, 1], function (arr) {
  console.log("Sorted array: " + JSON.stringify(arr));
  reader.close();
});









Function.prototype.myBind(context) {
  var fn = this;
  function (fn,context) {
    fn.apply(context);
  };
};
