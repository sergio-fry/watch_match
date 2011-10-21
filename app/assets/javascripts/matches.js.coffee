# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$(() ->
  ratings = $.makeArray($(".match .rating")).map (el)->
    parseFloat($(el).text())

  console.log ratings;
  console.log Math.max.apply @, ratings;
  console.log Math.min.apply @, ratings;
  #max = ratings.max();
);
