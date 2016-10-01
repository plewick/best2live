App = {}
map = ""
(($) ->
    App = $.extend(App,
        mapHandler = 
            initMap : (e)->
                map = new google.maps.Map(document.getElementById('map'),
                    center: 
                        lat: 50
                        lng: 14
                    zoom: 8
                )
                App.heatMap()
                return
            mapTest : (e)->
                console.log "OK"
            heatMap: (e) ->
                heatmap = new HeatmapOverlay(map,
                        "radius": 0.01
                        "maxOpacity": .5
                        "scaleRadius": true
                        "useLocalExtrema": true
                        latField: "lat"
                        lngField: "lng"
                        valueField: "id"
                    )
                App.getData(heatmap)
            getData: (heatmap)->
                $.ajax( 
                    dataType: "json"
                    url: "/data/praguemap.json"

                    success: (data)->
                        console.log data
                        App.displayData(heatmap,data)

                )
            displayData: (heatmap,data)->
                console.log "setting data"
                heatData = {
                    max: 4000
                    data: data
                }
                heatmap.setData(heatData)
                console.log heatmap
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
        App.initMap()
) jQuery