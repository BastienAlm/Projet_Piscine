if(!self.define){let e,s={};const t=(t,n)=>(t=new URL(t+".js",n).href,s[t]||new Promise((s=>{if("document"in self){const e=document.createElement("script");e.src=t,e.onload=s,document.head.appendChild(e)}else e=t,importScripts(t),s()})).then((()=>{let e=s[t];if(!e)throw new Error(`Module ${t} didn’t register its module`);return e})));self.define=(n,i)=>{const o=e||("document"in self?document.currentScript.src:"")||location.href;if(s[o])return;let r={};const c=e=>t(e,o),l={module:{uri:o},exports:r,require:c};s[o]=Promise.all(n.map((e=>l[e]||c(e)))).then((e=>(i(...e),r)))}}define(["./workbox-a50b03cf"],(function(e){"use strict";self.skipWaiting(),e.clientsClaim(),e.precacheAndRoute([{url:"registerSW.js",revision:"3ca0b8505b4bec776b69afdba2768812"},{url:"index.html",revision:"0.q1mo2hh4uc8"}],{}),e.cleanupOutdatedCaches(),e.registerRoute(new e.NavigationRoute(e.createHandlerBoundToURL("index.html"),{allowlist:[/^\/$/]})),e.registerRoute(/^https:\/\/fonts.(?:googleapis|gstatic).com\/(.*)/,new e.CacheFirst({cacheName:"google-fonts",plugins:[new e.ExpirationPlugin({maxEntries:30}),new e.CacheableResponsePlugin({statuses:[0,200]})]}),"GET"),e.registerRoute(/\.(?:png|gif|jpg|jpeg|svg)$/,new e.CacheFirst({cacheName:"images",plugins:[new e.ExpirationPlugin({maxEntries:60})]}),"GET"),e.registerRoute(/\.(?:js|css)$/,new e.StaleWhileRevalidate({cacheName:"static-resources",plugins:[new e.ExpirationPlugin({maxEntries:60})]}),"GET"),e.registerRoute(/^http:\/\/localhost:4000\/api\/workingtimes\/1/,new e.NetworkFirst({cacheName:"api",plugins:[new e.ExpirationPlugin({maxEntries:60}),new e.CacheableResponsePlugin({statuses:[0,200]})]}),"GET")}));
