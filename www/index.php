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
        <link href="/css/main.css" rel="stylesheet">
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
            <h2 class="site-title">Best2Live</h2>
        </div>
        <nav class="site-nav main-nav">
            <ul>
                <li><a href="/">Map</a></li>
                <li><a href="/">About</a></li>
            </ul>
        </nav>
    </header>
    <div class="container">
        <div id="map">
            
        </div>
    </div>
    <footer class="site-footer">
        <div class="master-padding">
            <div class="copy">
                &copy; <?php echo date("Y"); ?> Best2Live
            </div>
        </div>
    </footer>
    <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyDlvXX4W8lnEZb7GFb-zVCQ-BryPwuu50k"
    async defer></script>
    <script src="/js/app.min.js" async defer></script>
</body>
</html>