# ported to coffescript from http://stackoverflow.com/a/17876761/1082326

Lunchtime.directive('withLocals', ->
  scope: true
  compile: (element, attributes, transclusion) ->
    # for each attribute that matches locals-* (camelcased to locals[A-Z0-9]),
    # capture the "key" intended for the local variable so that we can later
    # map it into $scope.key (in the linking function below)
    mapLocalsToParentExp = {}
    for attr of attributes
      if attributes.hasOwnProperty(attr) and /^locals[A-Z0-9]/.test(attr)
        localKey = attr.slice(6)
        localKey = localKey[0].toLowerCase() + localKey.slice(1)
        mapLocalsToParentExp[localKey] = attributes[attr]

    pre: ($scope, $element, $attributes) ->
      # setup `$scope.locals` hash so that we can map expressions from the parent scope into it.
      for localKey of mapLocalsToParentExp
        # For each local key, $watch the provided expression and update the $scope.locals hash
        # (i.e. attribute `locals-cars` has key `cars` and the $watch-ed value maps to `$scope.locals.cars`)
        $scope.$watch(
          mapLocalsToParentExp[localKey],
          ((localKey) ->
            (newValue, oldValue) -> $scope[localKey] = newValue
          )(localKey),
          true
        )

      # Also watch the local value and propagate any changes
      # back up to the parent scope.
      parsedGetter = $parse(mapLocalsToParentExp[localKey])
      if parsedGetter.assign
        $scope.$watch(localKey,
          (newValue, oldValue) ->
            parsedGetter.assign($scope.$parent, newValue)
            $scope.$apply()
        , true)
)