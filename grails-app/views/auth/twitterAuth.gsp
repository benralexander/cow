<%--
  Created by IntelliJ IDEA.
  User: balexand
  Date: 1/14/2015
  Time: 7:40 AM
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title></title>
    <script src="https://apis.google.com/js/client:platform.js" async defer></script>
    <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.3/jquery.min.js"></script>
</head>

<body>
<hi>hello</hi>
<ol id="messageHolder"></ol>
<script>

    var searchTwitter = function(text) {
        var success = function (data){
            var domPtr = $('#messageHolder');
            var obj = JSON.parse(data);
            for ( var i = 0 ; i < obj["searchResults"].statuses.length ; i++ ){
                var individualObject= obj["searchResults"].statuses[i];
                domPtr.append('<li>'+individualObject.text+'</li>');
            }
        };
        var inputFieldText = $('#searchterms').val();
        // let's go query twitter
        $.ajax({
            cache: false,
            type: "post",
            url: "${createLink(controller:'SpringSecurityOAuth',action:'twitterLogin')}",
            data: {a: inputFieldText},
            async: true,
            success: function (data) {
                success ( data   );
            },
            error: function (jqXHR, exception) {
                console.log('error!');
            }
        });

    };



    var streamTwitter = function(text) {
        var success = function (data){
            var domPtr = $('#messageHolder');
            var obj = JSON.parse(data);
            for ( var i = 0 ; i < obj["searchResults"].statuses.length ; i++ ){
                var individualObject= obj["searchResults"].statuses[i];
                domPtr.append('<li>'+individualObject.text+'</li>');
            }
        };
        var inputFieldText = $('#searchterms').val();
        // let's go query twitter
        $.ajax({
            cache: false,
            type: "post",
            url: "${createLink(controller:'SpringSecurityOAuth',action:'twitterStream')}",
            data: {a: inputFieldText},
            async: true,
            success: function (data) {
                success ( data   );
            },
            error: function (jqXHR, exception) {
                console.log('error!');
            }
        });

    };

</script>

<button onclick="searchTwitter()">search twitter</button>
<span>search terms<input type="text" name="tosearch" id='searchterms' maxlength="50"/></span><br>


<button onclick="streamTwitter()" style="margin:20px">stream twitter (doesn't work yet)</button>

</body>
</html>