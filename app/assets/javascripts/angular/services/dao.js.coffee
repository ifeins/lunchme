_createVotes = (lunch, votes, RestaurantDAO, UserDAO) ->
  _.map(votes, (voteData) ->
    user = UserDAO.findOrInitializeById(voteData.user)
    restaurant = RestaurantDAO.find(voteData.restaurantId)
    vote = new Vote(lunch, user, restaurant)
    vote.id = voteData.id

    vote
  )

_createVisits = (lunch, visits, UserDAO, RestaurantDAO) ->
  _.map(visits, (visitData) ->
    user = UserDAO.findOrInitializeById(visitData.user)
    restaurant = RestaurantDAO.find(visitData.restaurantId)
    visit = new Visit(lunch, user, restaurant)
    visit.id = visitData.id

    visit
  )

_createSurvey = (lunch, user, data) ->
  new Survey(data.status, user, lunch)

angular.module('DAO', []).factory('RestaurantDAO', ($http, $q) ->

  restaurants = new OrderedHash()

  @load = ->
    dfd = $q.defer()
    $http.get('restaurants.json').success((list) ->
      _.each(list, (data) -> restaurants.set(data.id, new Restaurant(data)))
      dfd.resolve()
    )
    dfd.promise

  @all = ->
    restaurants.all()

  @find = (id) ->
    restaurants.get(id)

  @findByName = (name) ->
    _.findWhere(@all(), name: name)

  @availableTags = (restaurant) ->
    dfd = $q.defer()
    $http.get("restaurants/#{restaurant.id}/available_tags.json").success((list) ->
      dfd.resolve(list)
    )
    dfd.promise

  @
).factory('UserDAO', (OfficeDAO) ->

  users = {}

  @findOrInitializeById = (userData) ->
    return null unless userData

    user = users[userData.id]
    unless user
      user = User.parse(userData)
      user.office = OfficeDAO.findOrInitializeById(userData.office) if userData.office
      users[user.id] = user

    user

  @

).factory('VoteDAO', ($http) ->

  @create = (vote) ->
    vote.lunch.addVote vote
    $http.post("lunches/#{vote.lunch.id}/votes.json", vote.toJSON()).success((response) ->
      vote.id = response.id
    ).error(->
      # in case of failure we revert the addition
      vote.lunch.removeVote vote
    )

  @destroy = (vote) ->
    vote.lunch.removeVote vote
    $http.delete("lunches/#{vote.lunch.id}/votes/#{vote.id}.json").error(->
      vote.lunch.addVote vote
    )

  @

).factory('LunchDAO', ($http, $q, RestaurantDAO, UserDAO) ->

  @today = ->
    fetchLunchFromPath('lunches/today.json')

  @yesterday = ->
    fetchLunchFromPath('lunches/yesterday.json')

  @findByDate = (date) ->
    fetchLunchFromPath("lunches/#{date}.json")

  fetchLunchFromPath = (path) ->
    dfd = $q.defer()
    RestaurantDAO.load().then( ->
      $http.get(path).success((data) ->
        dfd.resolve(parseLunch(data))
      ).error(->
        dfd.reject()
      )
    )
    dfd.promise

  parseLunch = (data) ->
    lunch = new Lunch(data.id, data.date)
    lunch.votes = _createVotes(lunch, data.votes, RestaurantDAO, UserDAO)
    lunch.visits = _createVisits(lunch, data.visits, UserDAO, RestaurantDAO)
    lunch.userSurvey = _createSurvey(lunch, User.current, data.userSurvey) if data.userSurvey

    lunch

  @
).factory('TagDAO', ($http, $q) ->

  @create = (tag) ->
    tag.restaurant.addTag tag

    dfd = $q.defer()
    $http.post("restaurants/#{tag.restaurant.id}/tags.json", tag.toJSON()).success((response) ->
      tag.quantity = response.quantity
      tag.id = response.id
      tag.usersIds ||= {}
      tag.usersIds.push(User.current.id)
      dfd.resolve()
    ).error(->
      tag.restaurant.removeTag tag
      dfd.reject()
    )

    dfd.promise

  @vote = (tag) ->
    tag.vote(User.current)

    $http.put("restaurants/#{tag.restaurant.id}/tags/#{tag.id}/vote.json", tag.toJSON()).error(->
      tag.unvote(User.current) # revert operation
    )

  @

).factory('VisitDAO', ($http, $q) ->

  @update = (visit, restaurant) ->
    lunch = visit.lunch
    previousRestaurant = visit.restaurant
    visit.restaurant = restaurant

    dfd = $q.defer()
    $http.put("lunches/#{lunch.id}/visits/#{visit.id}.json", visit.toJSON()).success(->
      dfd.resolve()
    ).error(->
      visit.restaurant = previousRestaurant
      dfd.reject()
    )

    dfd.promise


  @create = (visit) ->
    lunch = visit.lunch
    lunch.addVisit(visit)

    dfd = $q.defer()
    $http.post("lunches/#{lunch.id}/visits.json", visit.toJSON()).success((response) ->
      visit.id = response.id
      dfd.resolve()
    ).error(->
      lunch.removeVisit(visit)
      dfd.reject()
    )

    dfd.promise

  @
).factory('SurveyDAO', ($http, $q) ->

  @create = (survey) ->
    lunch = survey.lunch
    dfd = $q.defer()
    $http.post("lunches/#{lunch.id}/surveys.json", survey.toJSON()).success( ->
      # this time will only set the survey on the lunch after successful response from the server
      lunch.userSurvey = survey
      dfd.resolve()
    ).error(->
      dfd.reject()
    )

    dfd.promise

  @
).factory('OfficeDAO', ($http, $q) ->

  offices = {}

  @findOrInitializeById = (officeData) ->
    unless offices[officeData.id]
      officeData.location = new Location(officeData.location)
      offices[officeData.id] = new Office(officeData)

    offices[officeData.id]

  @load = ->
    dfd = $q.defer()
    $http.get('offices.json').success((list) =>
      _.each(list, (data) => @findOrInitializeById(data))
      dfd.resolve()
    )

    dfd.promise

  @all = ->
    _.values(offices)

  @
)

