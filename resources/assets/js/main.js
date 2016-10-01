/* Tento soubor je kompilován po coffee scriptu */
$(function(){
	$(document).ready(function() {
	});
});
(function($){var lingua__path;var lingua__name;var lingua__lang;var lingua__data={};var lingua__eids={};$.lingua=function(key){if(lingua__data[key])return lingua__data[key];}
$.linguaInit=function(path,name){if(typeof path!='string'||typeof name!='string'){$.error('Invalid or missing parameter calling jQuery.lingua init method.');}
else{lingua__path=path;lingua__name=name;lingua__lang=normalizeLang(navigator.language||navigator.userLanguage);}}
$.linguaGetLanguage=function(){return lingua__lang;}
$.linguaLoad=function(language){return doLoad(language)}
function doLoad(language){if(typeof lingua__path!='string'||typeof lingua__name!='string'){$.error('jQuery.lingua load method called prior to initialization.');}
else{var lang=normalizeLang(language);var opts={async:false,cache:false,dataType:'text',timeout:500};var query;var file="";if(lang.length>=5){query=$.ajax($.extend(opts,{url:lingua__path+lingua__name+'-'+lang.substring(0,5)+'.txt'}));if(query.status==200)file=query.responseText;}
if(file.length==0&&lang.length>=2){query=$.ajax($.extend(opts,{url:lingua__path+lingua__name+'-'+lang.substring(0,2)+'.txt'}));if(query.status==200)file=query.responseText;}
if(file.length==0){query=$.ajax($.extend(opts,{url:lingua__path+lingua__name+'.txt'}));if(query.status==200)file=query.responseText;}
var rawText=$.trim(file).split("\n");lingua__data={};lingua__eids={};for(var i=0;i<rawText.length;i++){var row=$.trim(rawText[i]);var sep=row.indexOf("\t");if(sep==-1)sep=row.indexOf(" ");if(sep>=0){var datkey=$.trim(row.slice(0,sep));if(datkey.substring(0,2)!="//"&&datkey.substring(0,3)!="﻿"){if(datkey.charAt(0)=="#")
lingua__eids[datkey]=$.trim(row.slice(sep+1));else
lingua__data[datkey]=$.trim(row.slice(sep+1));}}}}}
$.linguaUpdateElements=function(){return doUpdateElements()}
function doUpdateElements(){$.each(lingua__eids,function(key,value){$(key).html(value);});}
$.linguaLoadAutoUpdate=function(language){var dat=doLoad(language);doUpdateElements();}
function normalizeLang(lang){lang=lang.replace(/_/,'-').toLowerCase();if(lang.length>3)lang=lang.substring(0,3)+lang.substring(3).toUpperCase();return lang;}})(jQuery);


	
// http://localhost/jquery/lingua/demo.htm

// wait until everything is done starting up...
$(document).ready(function () {
	console.log("wut?")
    // initialization establishes path and the base filename
    $.linguaInit('/data/', 'lang');

    // try to change our drop-down to the browser language
    $("#lang-toggler").addClass($.linguaGetLanguage());

    // try loading the default browser language
    $.linguaLoad($.linguaGetLanguage());
    updatePage();
    $.linguaUpdateElements(); // manual updating of controls by ID
    $(".lang").each(function(){
		$(this).on("click touch", function (){
	    	var newlanguage = $(this).data("lang")
	    	$(this).parent().removeClass("en").removeClass("cs").addClass(newlanguage)
	    	console.log(newlanguage)
	    	$.linguaLoadAutoUpdate(newlanguage); // this will also update controls by ID
			updatePage();
		})
    })
	function updatePage()
	{
		$(".lang-high").html($.lingua("lang-high"));
		$(".lang-mid").html($.lingua("lang-mid"));
		$(".lang-low").html($.lingua("lang-low"));
	}
});


