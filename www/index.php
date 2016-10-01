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
        <div id="info-toggler" class="fa fa-info"></div>
        <div id="lang-toggler">
            <div class="lang en" data-lang="en">EN</div>
            <div class="lang cs" data-lang="cs">CZ</div>
        </div>
        <nav class="site-nav main-nav">
            <div class="hamburger">
                <div class="hamico"></div>
            </div>
            <div class="menu-holder">
                <ul class="main-menu">
                    <li><a href="#map"><span class="fa fa-map"></span><span id="lang-map">Map</span></a></li>
                    <li><a href="#about"><span class="fa fa-info"></span><span id="lang-about">About</span></a></li>
                </ul>
            </div>
        </nav>
    </header>
    <div class="container">
        <div id="map">
            
        </div>
        <div class="map-options-toggler">
            <span class="fa fa-gears"></span><span class="text" id="lang-preferences">What are your preferences?</span>
            <div class="tt">
                <div class="tt-close"><div class="fa fa-close"></div></div>
                <p id="tooltip-a">Here you can select which qualities are imporant for you and the map will change accordingly.</p>

            </div>
        </div>
    </div>
    <div id="loader" class="loader">
        <div class="spinner spinner__1"></div>
    </div>
    <div class="legend-modal modal">
        <div class="modal-hold">
            <h3><span id="howtoread">How to read this map?</span>
            <div class="fa fa-close"></div>
            </h3>
            <p id="lang-simple">Simplest thing in the world...</p>
            <div class="infograph">
                <div class="pure-g">
                    <div class="pure-u-1-2">
                        <div class="good"><div class="fa 
                            fa-smile-o"></div> <span id="lang-good">Good</span></div>
                    </div>
                    <div class="pure-u-1-2">
                        <div class="bad"><span id="lang-bad">Bad</span> <div class="fa fa-frown-o"></div></div>
                    </div>
                </div>
                <div class="grad-line"></div>
            </div>
        </div>
    </div>
    <div class="filter-modal modal">
        <div class="modal-hold">
            <h3>
                <span id="lang-selectqualities">Select importance of following qualities</span>
                <div class="fa fa-close"></div>
            </h3>
            <div class="holder" id="dfs">
                <div class="name" id="lang-distancefromscrools">Distance from schools</div>
                <div class="input">
                    <input id="dfs-h" type="radio" name="dfs" value="2">
                    <label for="dfs-h">
                        <div class="check"></div>
                        <div class="input-label"><span class="lang-high">High</span></div>
                    </label>
                </div>
                <div class="input">
                    <input id="dfs-m" type="radio" name="dfs" value="1">
                    <label for="dfs-m">
                        <div class="check"></div>
                        <div class="input-label lang-mid">Medium</div>
                    </label>
                </div>
                <div class="input">
                    <input id="dfs-l" type="radio" name="dfs"  value="0">
                    <label for="dfs-l">
                        <div class="check"></div>
                        <div class="input-label lang-low">Low</div>
                    </label>
                </div>
            </div>
            <div class="holder" id="dfp">
                <div class="name" id="lang-distancefromparks">Distance from parks</div>
                <div class="input">
                    <input id="dfp-h" type="radio" name="dfp"  value="2">
                    <label for="dfp-h">
                        <div class="check"></div>
                        <div class="input-label"><span class="lang-high">High</span></div>
                    </label>
                </div>
                <div class="input">
                    <input id="dfp-m" type="radio" name="dfp"  value="1">
                    <label for="dfp-m">
                        <div class="check"></div>
                        <div class="input-label lang-mid">Medium</div>
                    </label>
                </div>
                <div class="input">
                    <input id="dfp-l" type="radio" name="dfp"  value="0">
                    <label for="dfp-l">
                        <div class="check"></div>
                        <div class="input-label lang-low">Low</div>
                    </label>
                </div>
            </div>
            <div class="modal-submit">
                <div class="button" id="apply">Apply</div>
            </div>
        </div>
    </div>
    <div class="container-overlays">
        <div id="info" class="content-overlay">
            
        </div>
        <div id="about" class="content-overlay">
            <div class="language-select en" id="lang-about">
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