var Tabs = $.Tabs = function (el) {
  this.$el = $(el);
  this.$contentTabs = $(this.$el.data('contentTabs'));
  this.$activeTab = this.$el.find('.active');

  this.$el.on('click', 'a', this.clickTab.bind(this));
};

Tabs.prototype.clickTab = function (e) {
  e.preventDefault();
  var aClicked = $(e.currentTarget);
  var articleFocus = this.$el.find($(aClicked.attr('href')));

  this.$activeTab.removeClass();
  this.$activeTab.addClass('transitioning');
  articleFocus.addClass('active transitioning');
  aClicked.addClass('active');

  this.$activeTab.one("transitionend", function(){
    articleFocus.removeClass('transitioning')
    this.$activeTab.removeClass();
    this.$activeTab = this.$el.find('.active');
  }.bind(this));

};



$.fn.tabs = function () {
  return this.each(function () {
    new $.Tabs(this);
  });
};
