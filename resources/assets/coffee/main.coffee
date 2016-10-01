App = {}
(($) ->
    App = $.extend(App,
        mapHandler = 
            initMap = ->
                map = new google.maps.Map(document.getElementById('map'),
                    center: 
                        lat: 15
                        lng: 15
                    zoom: 8
                    )
        layout = 
            menu: ->
                $('.hamburger').on 'click touch', (event) ->
                    event.preventDefault()
                    $(this).parents('.main-nav').toggleClass 'mobile-open'
                    return
        cookies = 
            setcookie: (cname, cvalue, exdays) ->
                d = new Date
                d.setTime d.getTime() + exdays * 24 * 60 * 60 * 1000
                expires = 'expires=' + d.toUTCString()
                document.cookie = cname + '=' + cvalue + '; ' + expires
                return
            readcookie: (cname) ->
                name = cname + '='
                ca = document.cookie.split(';')
                i = 0
                while i < ca.length
                    c = ca[i]
                    while c.charAt(0) == ' '
                        c = c.substring(1)
                    if c.indexOf(name) == 0
                        return c.substring(name.length, c.length)
                    i++
                ''
    )
    
    $(document).ready ->
        console.log "CS Ready"
        App.initMap
) jQuery