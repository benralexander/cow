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
<script>
    function success(data){
        var obj = JSON.parse(data);
        console.log('hi, '+obj["displayName"]+'.');
    }
    function signinCallback(authResult) {
        if (authResult['status']['signed_in']) {
            // Update the app to reflect a signed in user
            // Hide the sign-in button now that the user is authorized, for example:
            document.getElementById('signinButton').setAttribute('style', 'display: none');
            $.ajax( {url:"https://www.googleapis.com/plus/v1/people/me?access_token="+authResult['access_token'],
                data:null,
                success:success} );
        } else {
            // Update the app to reflect a signed out user
            // Possible error values:
            //   "user_signed_out" - User is signed-out
            //   "access_denied" - User denied access to your app
            //   "immediate_failed" - Could not automatically log in the user
            console.log('Sign-in state: ' + authResult['error']);
        }
    }
</script>

<span id="signinButton">
    <span
            class="g-signin"
            data-callback="signinCallback"
            data-clientid="975413760331-d2nr5vq7sbbppjfog0cp9j4agesbeovt.apps.googleusercontent.com"
            data-cookiepolicy="single_host_origin"
            data-requestvisibleactions="http://schema.org/AddAction"
            data-scope="https://www.googleapis.com/auth/plus.login">
    </span>
</span>



<oauth:connect provider="google" id="google-connect-link">Google</oauth:connect>
%{--<a href="/locker2/oauth/google/authenticate?provider=google&redirectUrl=" provider="google">Google</a>--}%
Logged with google?
<s2o:ifLoggedInWith provider="google">yes</s2o:ifLoggedInWith>
<s2o:ifNotLoggedInWith provider="google">no</s2o:ifNotLoggedInWith>

</body>
</html>