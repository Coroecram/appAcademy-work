$.TweetCompose = function (el) {
  this.$el = $(el);

  this.bindSubmit();
};

$.TweetCompose.prototype.bindSubmit = function () {
  tweetCompose = this;

  this.$el.on("submit", function (e) {
    e.preventDefault();
    $(this).find('input').each(function () {
      $(this).prop("disabled", true)
    });

    var content = this[1].value;
    var mentionIds = this[2].value;
    var url = "/tweets";

    $.ajax({
      url: url,
      type: "POST",
      dataType: "json",
      data: {"tweet[content]" : content, "tweet[mention_user_ids]" : mentionIds },
      success: function(data) { this.postTweet(data); }.bind(tweetCompose)
    })
  })
};

$.TweetCompose.prototype.postTweet = function (data) {
  this.$el.find('input').each(function () {
    $(this).prop("disabled", false)
  });

  var feedId = this.$el.data("tweets-ul");
  var $ul = $(document).find(feedId);
  var $li = $("<li>");
  var content = data.content;
  var username = data.user.username;
  var mentionIds = data.mentions;
  $li.append(content + ' -- <a href="http://localhost:3000/user/' + mentionIds + '"' + ">" + username + "</a> -- ");
  $li.append(Date.UTC(data.created_at));
  $ul.prepend($li);
}

$.fn.tweetCompose = function () {
  return this.each(function () {
    new $.TweetCompose(this);
  });
};

$(function () {
  $("form.tweet-compose").tweetCompose();
});
