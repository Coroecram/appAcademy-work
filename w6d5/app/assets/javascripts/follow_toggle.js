$.FollowToggle = function (el) {
  this.$el = $(el);
  this.userId = this.$el.data("user-id");
  this.followState = this.$el.data("initial-follow-state");
  this.render();
  this.handleClick();
};

$.FollowToggle.prototype.render = function () {
  this.$el.prop('disabled', false);
  if (this.followState === true) {
    this.$el.text("Unfollow!");
  } else {
    this.$el.text("Follow!");
  }
};

$.FollowToggle.prototype.handleClick = function () {
  this.$el.on("click", function (e) {

    var url = "/users/" + this.userId + "/follow"
    if (this.followState === true) {
      this.$el.prop('disabled', true);
      $.ajax ({
        url: url,
        type: "DELETE",
        dataType: "json",
        success: function () { this.followState = false;
                               this.render() }.bind(this)
      })
    } else {
      this.$el.prop('disabled', true);
      $.ajax ({
        url: url,
        type: "POST",
        dataType: "json",
        success: function () { this.followState = true;
                               this.render() }.bind(this)
      })
    }
  }.bind(this))
};

$.fn.followToggle = function () {
  return this.each(function () {
    new $.FollowToggle(this);
  });
};

$(function () {
  $("button.follow-toggle").followToggle();
});
