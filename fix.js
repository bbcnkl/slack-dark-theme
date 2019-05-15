document.addEventListener("DOMContentLoaded", function() {
   let webviews = document.querySelectorAll(".TeamView webview");
   const cssPath = 'https://raw.githubusercontent.com/bbcnkl/slack-dark-theme/master/slack.css';
   let cssPromise = fetch(cssPath).then(response => response.text());

   let customCustomCSS = `
   :root {
      --primary: #CCC;
      --text: #999;
      --background: #222;
      --background-elevated: #444;
   }
   `
   cssPromise.then(css => {
      let s = document.createElement('style');
      s.type = 'text/css';
      s.innerHTML = css + customCustomCSS;
      document.head.appendChild(s);
   });

   webviews.forEach(webview => {
      webview.addEventListener('ipc-message', message => {
         if (message.channel == 'didFinishLoading')
            cssPromise.then(css => {
               let script = `
                     let s = document.createElement('style');
                     s.type = 'text/css';
                     s.id = 'slack-custom-css';
                     s.innerHTML = \`${css + customCustomCSS}\`;
                     document.head.appendChild(s);
                     `
               webview.executeJavaScript(script);
            })
      });
   });
});
