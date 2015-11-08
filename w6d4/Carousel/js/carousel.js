(function(){


var Carousel = window.$.Carousel = window.$.Carousel ||
function(el){
  this.$el = $(el);
  this.activeIdx = 0;
  this.transitioning = false;
  this.$el.find('button').on('click', this.slide.bind(this));
  this.$strip = this.$el.find('.items');
  this.$el.find('.items li:first-child').addClass('active');

};





Carousel.prototype.slide = function(e){
  if (this.transitioning) {
    return;
  };
  var $button = $(e.currentTarget);
  var lastPicIdx =  this.$strip.find('li:last-child').index();
  var instance = this;
  var moveDir = 0;
  var origPic = this.$strip.children().eq(this.activeIdx);
  this.transitioning = true;

  var slideLeft = function () {
    this.$strip.children().eq(this.activeIdx).removeClass('right');
  };

  var slideRight = function () {
    this.$strip.children().eq(this.activeIdx).removeClass('left');
  };


  if($button.attr('class') === 'slide-left' && this.activeIdx < lastPicIdx){
    //  this.$strip.css('margin-left', -((this.activeIdx+1) * 300) );
    origPic.addClass('left');
    this.activeIdx += 1;
    this.$strip.children().eq(this.activeIdx).addClass('active right');
    window.setTimeout(slideLeft.bind(this), 0);
  } else if ($button.attr('class') === 'slide-right' && this.activeIdx > 0){
    // this.$strip.css('margin-left', -((this.activeIdx-1) * 300) );
    origPic.addClass('right');
    this.activeIdx -= 1;
    this.$strip.children().eq(this.activeIdx).addClass('active left');
    // this = carousel instance
    window.setTimeout(slideRight.bind(this), 0);
  }

  origPic.one("transitionend", function(){
    origPic.removeClass()
    this.transitioning = false;
  }.bind(this));

};

$.fn.carousel = function () {
  return this.each(function () {
    new $.Carousel(this);
  });
};




}());
