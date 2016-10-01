App = {}
map = ""
heatmap = ""
(($) ->
    App = $.extend(App,
        mapHandler = 
            initMap : (e)->
                map = new google.maps.Map(document.getElementById('map'),
                    center: 
                        lat: 50.0731932
                        lng: 14.4072928
                    zoom: 12
                    streetViewControl: false
                    fullscreenControl: false
                    mapTypeControl: false
                )
                App.heatMap()
                return
            mapTest : (e)->
                console.log "OK"
            heatMap: (e) ->
                heatmap = new HeatmapOverlay(map,
                        "radius": 0.005 
                        "maxOpacity": .3
                        "scaleRadius": true
                        "useLocalExtrema": true
                        latField: "lat"
                        lngField: "lng"
                        valueField: "count"
                        gradient:
                            ".7": "#e56706"
                            "1": "#45efd9"
                    )
                d = {
                    zoom: map.getZoom()
                }
                App.getData(heatmap)
            getData: (heatmap, d)->
                #console.log d
                $("#loader").fadeIn(150);
                $.ajax( 
                    dataType: "json"
                    url: "/data/bigdata.json"
                    data: d
                    success: (data)->
                        #console.log data
                        $("#loader").fadeOut(150);
                        App.displayData(heatmap,data)

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
                $(".modal .fa-close").on "click touch", (e)->
                    $(this).parents(".modal").fadeOut(500)
            legendModal: ->
                $("#info-toggler").on "click touch", (e)->
                    $(".legend-modal").fadeIn(500)

                
            filterInit: ->
                $(".map-options-toggler").on "click touch", (e)->
                    $(".filter-modal").fadeIn(500)
                $(".filter-modal").find(".button").on "click touch", (e)->
                    dfp = $("#dfp").find("input:checked").val()
                    dfs = $("#dfs").find("input:checked").val()
                    zoom = map.getZoom()

                    #in case I'll decide to do something more with this...
                    bounds = {
                        ne : {}   
                        sw : {}   
                    }
                    bounds.ne.lng = map.getBounds().getNorthEast().lng()
                    bounds.ne.lat = map.getBounds().getNorthEast().lat()
                    bounds.sw.lng = map.getBounds().getSouthWest().lng()
                    bounds.sw.lat = map.getBounds().getSouthWest().lat()
                    d = {
                        dfp: dfp
                        dfs: dfs
                        nelng: bounds.ne.lng
                        nelat: bounds.ne.lat
                        swlng: bounds.sw.lng
                        swlat: bounds.sw.lat
                        zoom: zoom
                    }
                    console.log "bounds" 
                    console.log bounds 
                    $(".filter-modal").fadeOut(500)
                    App.getData(heatmap,d)
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