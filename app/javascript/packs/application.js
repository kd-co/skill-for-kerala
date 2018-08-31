/* eslint no-console:0 */
// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.
//
// To reference this file, add <%= javascript_pack_tag 'application' %> to the appropriate
// layout file, like app/views/layouts/application.html.erb

import '../stylesheets/application.css';

global.loadFacebookSDK = function loadFacebookSDK(appId) {
  global.fbAsyncInit = function() {
    global.FB.init({
      appId      : appId,
      cookie     : true,
      xfbml      : true,
      version    : 'v3.0'
    });

    global.FB.AppEvents.logPageView();
  };

  (function(d, s, id){
     var js, fjs = d.getElementsByTagName(s)[0];
     if (d.getElementById(id)) {return;}
     js = d.createElement(s); js.id = id;
     js.src = "https://connect.facebook.net/en_US/sdk.js";
     fjs.parentNode.insertBefore(js, fjs);
   }(global.document, 'script', 'facebook-jssdk'));
}

global.onFacebookLogin = function onFacebookLogin(response) {
  FB.getLoginStatus(function(response) {
      console.log(response);
    });
}
