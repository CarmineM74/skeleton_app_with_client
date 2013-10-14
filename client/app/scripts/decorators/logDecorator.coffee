angular.module('decorators',[])
  .config(($provide) ->
    $provide.decorator('$log', ($delegate) ->

      log = $delegate.log
      info = $delegate.info
      warn = $delegate.warn
      error = $delegate.error
      debug = $delegate.debug

      prepareFn = (fn,className) ->
        enhancedFn = ->
          args = Array.prototype.slice.call(arguments)
          now = moment().format('DD/MM/YYYY HH:mm:ss')
          unless className?
            className = ''
          args[0] = now + " - " + className + args[0]
          fn.apply(null,args)

        return enhancedFn

      getInstance = (className) ->
        name = ''
        if className?
          name = className + "::"

        return {
          log     : prepareFn(log,name)
          info    : prepareFn(info,name)
          debug   : prepareFn(debug,name)
          warn    : prepareFn(warn,name)
          error   : prepareFn(error,name)
        }

      $delegate.log = prepareFn($delegate.log)
      $delegate.debug = prepareFn($delegate.debug)
      $delegate.warn = prepareFn($delegate.warn)
      $delegate.error = prepareFn($delegate.error)
      $delegate.info = prepareFn($delegate.info)

      $delegate.getInstance = getInstance

      return $delegate
    )
  )
