angular.module('Lunchtime').controller('LunchPageController', ($scope, $modal, lunch, RestaurantDAO, VoteDAO) ->
  $scope.lunch = lunch
  $scope.restaurants = RestaurantDAO.all()
  $scope.query = ''

  $scope.restaurantSearch = (restaurant) ->
    matchTerms = _.union([restaurant.name], [restaurant.localizedName], _.pluck(restaurant.tags, 'name'))
    matchTerms = _.select(matchTerms, (term) -> term?)
    _.any(matchTerms, (term) -> term.toLowerCase().indexOf($scope.query) != -1)

  ### vote methods ###

  $scope.voteButtonClicked = (restaurant) ->
    return unless User.current # TODO: should display error message

    vote = lunch.userVoteForRestaurant(User.current, restaurant)
    if vote
      VoteDAO.destroy(vote)
    else
      VoteDAO.create(new Vote(lunch, User.current, restaurant))

  $scope.voteButtonText = (restaurant) ->
    return "I want in!" unless User.current

    if lunch.isVotedForRestaurant(User.current, restaurant)
      "I want out"
    else
      "I want in!"

  $scope.restaurantOrder = (restaurant) ->
    lunch.votesForRestaurant(restaurant).length

  $scope.showRestaurant = (restaurant) ->
    $modal(template: 'components/restaurant_modal', className: 'restaurant-modal', controller: 'RestaurantModalController', locals: {restaurant: restaurant})

  # init code
  if User.current
    $modal(template: 'components/sign_in_modal', className: 'sign-in-modal', controller: 'FillDetailsController')
)