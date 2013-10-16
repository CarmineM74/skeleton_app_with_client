'use strict';

angular.module('clientApp')
  .directive('pwCheck', ($log,$parse) ->
    $log = $log.getInstance('pwCheck-Directive')
    $log.log('Initializing ...')

    d = {
      restrict: 'A'
      require: 'ngModel'
      link: (scope, elem, attrs, ctrl) ->
        me = attrs.ngModel
        other = attrs.otherPw
        #$log.log(me + ' - Other: ' + other)
        # 2013.10.15
        #The following watches could have been made into one
        #using the $watch('[me,other]'... notation.
        #Doing that leads to error in the browser's console,
        #hinting that a deep recursion on $digest is happening,
        #that is halted after the maximum of 10 calls.
        #I still can't figure out why this happens, since
        #there's no modification of the observed value occuring
        #inside the watches.
        scope.$watch(me,(v,ov) ->
          if v == ov
            return false
          me_val = $parse(me)(scope)
          other_val = $parse(other)(scope)
          #$log.log(me_val + ' == ' + other_val)
          ctrl.$setValidity('pwcheck', me_val == other_val)
        )
        scope.$watch(other,(v,ov) ->
          if v == ov
            return false
          me_val = $parse(me)(scope)
          other_val = $parse(other)(scope)
          ctrl.$setValidity('pwcheck', me_val == other_val)
        )
    }

    return d
  )
