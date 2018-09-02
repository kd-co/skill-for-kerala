import superagent from 'superagent';

export function onFacebookLogin(response) {
  FB.getLoginStatus(function({authResponse}) {
    if(authResponse) {
       superagent
         .get('/users/auth/facebook/callback')
         .set('Accept', 'application/json')
         .then(res => {
            alert('yay got ' + JSON.stringify(res.body));
         });
    }
  });
}
