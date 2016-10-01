<!-- Stored in resources/views/layouts/master.blade.php -->
<!DOCTYPE html>
<html lang="en">
<head>
    <!-- metas -->
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <meta charset="utf-8">
    <!-- /metas -->
    <!-- styles -->
        <link rel="shortcut icon" href="/favicon.ico">
        <link href="https://fonts.googleapis.com/css?family=Lato:300,400|Raleway:900&subset=latin-ext" rel="stylesheet">
        
        <link href="/css/main.css" rel="stylesheet">
        <link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.6.3/css/font-awesome.min.css" rel="stylesheet">
        <!--[if lte IE 8]>
            <link rel="stylesheet" href="http://yui.yahooapis.com/pure/0.6.0/grids-responsive-old-ie-min.css">
        <![endif]-->
        <!--[if gt IE 8]><!-->
            <link rel="stylesheet" href="http://yui.yahooapis.com/pure/0.6.0/grids-responsive-min.css">
        <!--<![endif]-->
    <!-- /styles -->
    <!-- head -->
    <!-- /head -->
    <title>Best2Live</title>
    <script> 
    var $buoop = {vs:{i:8,f:25,o:12.1,s:7},c:2}; 
    function $buo_f(){ 
     var e = document.createElement("script"); 
     e.src = "//browser-update.org/update.min.js"; 
     document.body.appendChild(e);
    };
    try {document.addEventListener("DOMContentLoaded", $buo_f,false)}
    catch(e){window.attachEvent("onload", $buo_f)}
    </script>
</head>
<body>
    <header class="site-header">
        <div class="head">
            <h1 class="site-title"><img src="/images/best2live-logo.svg" width="180" alt="Best2live"></h1>
        </div>
        <nav class="site-nav main-nav">
            <div class="hamburger">
                <div class="hamico"></div>
            </div>
            <div class="menu-holder">
                <ul class="main-menu">
                    <li><a href="#map"><span class="fa fa-map"></span>Map</a></li>
                    <li><a href="#about"><span class="fa fa-info"></span>About</a></li>
                </ul>
            </div>
        </nav>
    </header>
    <div class="container">
        <div id="map">
            
        </div>
        <div class="map-options-toggler">
            <span class="fa fa-gears"></span><span class="text">What are your preferences?</span>
            <div class="tt">
                <div class="tt-close"><div class="fa fa-close"></div></div>
                <p>Here you can select which qualities are imporant for you and the map will change accordingly.</p>

            </div>
        </div>
    </div>
    <div class="filter-modal">
        <div class="modal-hold">
            <h3>
                Select importance of following qualities
                <div class="fa fa-close"></div>
            </h3>
            <div class="holder" id="dfs">
                <div class="name">Distance from schools</div>
                <div class="input">
                    <input id="dfs-h" type="radio" name="dfs" value="2">
                    <label for="dfs-h">
                        <div class="check"></div>
                        <div class="input-label">High</div>
                    </label>
                </div>
                <div class="input">
                    <input id="dfs-m" type="radio" name="dfs" value="1">
                    <label for="dfs-m">
                        <div class="check"></div>
                        <div class="input-label">Medium</div>
                    </label>
                </div>
                <div class="input">
                    <input id="dfs-l" type="radio" name="dfs"  value="0">
                    <label for="dfs-l">
                        <div class="check"></div>
                        <div class="input-label">Low</div>
                    </label>
                </div>
            </div>
            <div class="holder" id="dfp">
                <div class="name">Distance from parks</div>
                <div class="input">
                    <input id="dfp-h" type="radio" name="dfp"  value="2">
                    <label for="dfp-h">
                        <div class="check"></div>
                        <div class="input-label">High</div>
                    </label>
                </div>
                <div class="input">
                    <input id="dfp-m" type="radio" name="dfp"  value="1">
                    <label for="dfp-m">
                        <div class="check"></div>
                        <div class="input-label">Medium</div>
                    </label>
                </div>
                <div class="input">
                    <input id="dfp-l" type="radio" name="dfp"  value="0">
                    <label for="dfp-l">
                        <div class="check"></div>
                        <div class="input-label">Low</div>
                    </label>
                </div>
            </div>
            <div class="modal-submit">
                <div class="button">Apply</div>
            </div>
        </div>
    </div>
    <div class="container-overlays">
        <div id="info" class="content-overlay">
            
        </div>
        <div id="about" class="content-overlay">
            <div class="language-select en">
                <h2>About this project</h2>
                <p>
                    Project Best2Live is here to give you visualised information about areas in Prague that are most suitable for living.
                </p>
                <p>
                    We are gathering information from multiple data sources which are
                </p>
                <ul>
                    <li>Crime maps</li>
                    <li>Network speeds</li>
                    <li>Noise maps</li>
                    <li>Pollution in area</li>
                    <li>and more...</li>
                </ul>
                <p>
                    Using these information we light up the map so you can easily view areas that have high rankings in those areas as well as those that are lacking.
                </p>
            </div>
        </div>
    </div>
    <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyDlvXX4W8lnEZb7GFb-zVCQ-BryPwuu50k"></script>
    <script src="/js/app.min.js" async defer></script>
</body>
</html>