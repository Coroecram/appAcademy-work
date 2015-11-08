$.UserSearch = function (el) {
  this.$el = $(el);
  this.$input = this.$el.find('input');
  this.$ul = this.$el.find('.users');


  this.bindInput();
};


$.UserSearch.prototype.bindInput = function (){
  this.$input.on("input", this.search.bind(this))
}

$.UserSearch.prototype.search = function () {
  $.ajax ({
    url: "/users/search",
    type: "GET",
    data: { "query": this.$input.val() },
    dataType: "json",
    success: function (data) {
      this.renderResults(data) }.bind(this)
    })
}

$.UserSearch.prototype.renderResults = function (data) {
  var that = this;
  that.$ul.empty();
  data.forEach(function (el) {
    var $li = $("<li>").text(el.username);
    var $newButton = $('<button>')
        .data( {"user-id": el.id, "initial-follow-state": el.followed} );

    $li.append($newButton);
    new $.FollowToggle($newButton)

    that.$ul.append($li);
  });
};



$.fn.userSearch = function () {
  return this.each(function () {
    new $.UserSearch(this);
  });
};

$(function () {
  $("div.users-search").userSearch();
});
