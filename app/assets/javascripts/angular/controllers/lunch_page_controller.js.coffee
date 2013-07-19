window.LunchPageController = ($scope, $modal, lunch, RestaurantDAO, VoteDAO) ->
  $scope.lunch = lunch
  $scope.restaurants = RestaurantDAO.all()
  $scope.query = ''

  $scope.restaurantSearch = (restaurant) ->
    matchTerms = _.union([restaurant.name], _.pluck(restaurant.tags, 'name'))
    matchTerms = _.select(matchTerms, (term) -> term?)
    _.any(matchTerms, (term) -> term.toLowerCase().indexOf($scope.query) != -1)

  ### vote methods ###

  $scope.voteButtonClicked = (restaurant) ->
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

  # init code

  if User.current and not User.current.workArea
    $modal(template: 'components/sign_in_modal', className: 'sign-in-modal', controller: 'FillDetailsController')