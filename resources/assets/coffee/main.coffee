App = {}
map = ""
heatmap = ""
(($) ->
    masterto = false
    App = $.extend(App,
        mapHandler = 
            initMap : (e)->
                map = new google.maps.Map(document.getElementById('map'),
                    center: 
                        lat: 50.0731932
                        lng: 14.4072928
                    zoom: 14
                    streetViewControl: false
                    fullscreenControl: false
                    mapTypeControl: false
                )
                App.heatMap()

                return
            eventHandler:(e)->
                google.maps.event.addListener map, "bounds_changed",->
                    console.log "changed"
                    App.refreshShow()
                $("#refresher").on "click touch", (e)->
                    App.getData(heatmap)
            refreshShow: (e)->
                if masterto
                    clearTimeout(masterto)
                    masterto = false
                if not masterto
                    masterto = 
                        setTimeout (->
                            $("#refresher").fadeIn(300)
                            return
                        ), 100

                    
            mapTest : (e)->
                console.log "OK"
            heatMap: (e) ->
                heatmap = new HeatmapOverlay(map,
                        "radius": 0.001 
                        "maxOpacity": .5
                        "scaleRadius": true
                        "useLocalExtrema": true
                        latField: "lat"
                        lngField: "lng"
                        valueField: "val"
                        minOpacity: .5
                        gradient:
                            ".1": "#b21e9e"
                            ".54": "#b21e9e"
                            ".55": "#c693b8"
                            ".64": "#c693b8"
                            ".65": "#abcece"
                            ".74": "#abcece"
                            ".75": "#5C9999"
                            ".84": "#5C9999"
                            ".85": "#7FC7AF"
                            ".94": "#7FC7AF"
                            ".95": "#45efd9"
                    )
                d = {
                    zoom: map.getZoom()
                }
                google.maps.event.addListenerOnce map, 'idle', ->
                    App.getData(heatmap)
                    App.eventHandler()
            getData: (heatmap)->
                #console.log d
                $("#loader").fadeIn(150);
                d = App.fetchPostData()
                $.ajax( 
                    dataType: "json"
                    url: "http://13.93.50.100:5000/"
                    data: d
                    success: (data)->
                        console.log data
                        $("#loader").fadeOut(150);
                        $("#refresher").hide()
                        App.displayData(heatmap,data)
                    error:  (d) ->
                        console.log "error get"
                        $("#loader").fadeOut(150);
                )
            displayData: (heatmap,data)->
                console.log "setting data"
                heatData = {
                    max: 1000
                    data: data
                }
                heatmap.setData(heatData)
                #console.log heatmap
        modals =
            initModals: ->
                App.generalModals()
                App.legendModal()
                App.filterInit()
            generalModals: ->
                $(".modal").on "click touch", (e)->
                    $(this).fadeOut(500)
                $(".modal-hold").on "click touch", (e)->
                    e.stopPropagation()
                $(".modal .fa-close").on "click touch", (e)->
                    $(this).parents(".modal").fadeOut(500)
            legendModal: ->
                $("#info-toggler").on "click touch", (e)->
                    $(".legend-modal").fadeIn(500)

            findBounds: ->
                #in case I'll decide to do something more with this...
                bounds = {
                    ne : {}   
                    sw : {}   
                }
                console.log map.getBounds()
                bounds.ne.lng = map.getBounds().getNorthEast().lng()
                bounds.ne.lat = map.getBounds().getNorthEast().lat()
                bounds.sw.lng = map.getBounds().getSouthWest().lng()
                bounds.sw.lat = map.getBounds().getSouthWest().lat()
                return bounds
            fetchPostData: ->
                zoom = map.getZoom()
                bounds = App.findBounds()
                local = $("#local").find("input:checked").val()
                pollution = $("#pollution").find("input:checked").val()
                cell = $("#cell").find("input:checked").val()
                dfp = $("#dfp").find("input:checked").val()
                dfs = $("#dfs").find("input:checked").val()
                d = {
                    dfp     : dfp
                    dfs     : dfs
                    pollution    : pollution
                    cell    : cell
                    local   : local
                    nelng   : bounds.ne.lng
                    nelat   : bounds.ne.lat
                    swlng   : bounds.sw.lng
                    swlat   : bounds.sw.lat
                    zoom    : zoom
                }
                return d    
            filterInit: ->
                $(".map-options-toggler").on "click touch", (e)->
                    $(".filter-modal").fadeIn(500)
                $(".filter-modal").find(".button").on "click touch", (e)->
                    $(".filter-modal").fadeOut(500)
                    App.getData(heatmap)
        contentLayer =
            contentLayerInit: (e)->
                $(".main-menu a").each ->
                    $(@).on "click touch", (e)->
                        e.preventDefault()
                        $('.main-nav').removeClass "mobile-open"
                        href = ($(this).attr("href"))
                        if href != "#map"
                            $(href)
                                .addClass "open-block"
                                .siblings()
                                .removeClass "open-block"
                        else
                            $(".content-overlay").each ->
                                $(this).removeClass "open-block"
                            console.log "not map"
        layout = 
            menu: ->
                $('.hamburger').on 'click touch', (event) ->
                    event.preventDefault()
                    $(this).parents('.main-nav').toggleClass 'mobile-open'
                    return
            tt: ->
                cookie = App.readcookie("tt")
                console.log cookie
                if cookie != "1"
                    $(".tt").addClass "open"

                $(".tt").on "click touch", (e)->
                    e.stopPropagation()
                    $(this).removeClass "open"
                    App.setcookie("tt",1,2)
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
        App.initModals()
        App.menu()
        App.contentLayerInit()
        App.tt()

) jQuery