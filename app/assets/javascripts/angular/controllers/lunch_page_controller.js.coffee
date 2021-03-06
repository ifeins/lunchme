angular.module('Lunchtime').controller('LunchPageController', ($scope, $rootScope, $modal, lunch, RestaurantDAO, VoteDAO, UserDAO, Pusher) ->
  $scope.user = User.current
  $scope.lunch = lunch
  $scope.restaurants = RestaurantDAO.all()
  $scope.query = ''
  $rootScope.lunchLoaded = true

  $scope.restaurantSearch = (restaurant) ->
    matchTerms = _.union([restaurant.name], [restaurant.localizedName], _.pluck(restaurant.tags, 'name'))
    matchTerms = _.select(matchTerms, (term) -> term?)
    _.any(matchTerms, (term) -> term.toLowerCase().indexOf($scope.query.toLowerCase()) != -1)

  ### vote methods ###

  $scope.voteButtonClicked = (restaurant) ->
    unless User.current
      $modal(template: 'components/sign_in_modal', className: 'sign-in-modal', controller: 'SignInController')
      return

    return if $scope.duringVote

    $scope.duringVote = true

    vote = lunch.userVoteForRestaurant(User.current, restaurant)
    if vote
      VoteDAO.destroy(vote, -> $scope.duringVote = false)
    else
      VoteDAO.create(new Vote(lunch, User.current, restaurant), -> $scope.duringVote = false)

  $scope.voteButtonText = (restaurant) ->
    return "I want in!" unless User.current

    if lunch.isVotedForRestaurant(User.current, restaurant)
      "I want out"
    else
      "I want in!"

  $scope.isVoted = (restaurant) ->
    return false unless User.current

    lunch.isVotedForRestaurant(User.current, restaurant)

  $scope.restaurantOrder = (restaurant1, restaurant2) ->
    votes1 = lunch.votesForRestaurant(restaurant1).length
    votes2 = lunch.votesForRestaurant(restaurant2).length

    if User.isSignedIn()
      return -1 if lunch.isVotedForRestaurant(User.current, restaurant1) and not lunch.isVotedForRestaurant(User.current, restaurant2)
      return 1 if lunch.isVotedForRestaurant(User.current, restaurant2) and not lunch.isVotedForRestaurant(User.current, restaurant1)

    if votes1 > votes2
      return -1
    else if votes1 < votes2
      return 1
    else
      return restaurant1.distanceFromOffice() - restaurant2.distanceFromOffice()

  $scope.showRestaurant = (restaurant) ->
    $modal(template: 'components/restaurant_modal', className: 'restaurant-modal', controller: 'RestaurantModalController', locals: {restaurant: restaurant})

  voteFromPusherData = (data) ->
    voteData = JSON.parse(data.vote_json)
    user = UserDAO.findOrInitializeById(voteData.user)
    restaurant = RestaurantDAO.find(voteData.restaurant_id)
    new Vote($scope.lunch, user, restaurant)

  # init code
  if User.current and not User.current.office
    $modal(template: 'components/sign_up_modal', className: 'sign-up-modal', controller: 'FillDetailsController')

  Pusher.subscribe("lunch-#{$scope.lunch.id}", 'restaurant-voted', (data) ->
    vote = voteFromPusherData(data)
    safeApply($scope, -> $scope.lunch.addVote(vote))
    unless vote.user.isCurrentUser()
      WindowTitleSupport.flashWindowTitle("#{vote.user.firstName} voted for #{vote.restaurant.name}")
  )

  Pusher.subscribe("lunch-#{$scope.lunch.id}", 'restaurant-unvoted', (data) ->
    vote = voteFromPusherData(data)
    safeApply($scope, -> $scope.lunch.removeVote(vote))
    unless vote.user.isCurrentUser()
      WindowTitleSupport.flashWindowTitle("#{vote.user.firstName} unvoted for #{vote.restaurant.name}")
  )

)