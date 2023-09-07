var goappNav=function(){};var goappOnUpdate=function(){};var goappOnAppInstallChange=function(){};const goappEnv={"ADSENSE_CLIENT":"ca-pub-1013306768105236","BATTLENET_AUTHORIZE_URL":"https://us.battle.net/oauth/authorize?region=us\u0026response_type=code\u0026client_id=eccea8e5fed449eb9f897dd7e90dd03f\u0026redirect_uri=https://murlok.io/account/login/battlenet\u0026scope=wow.profile","ENVIRONMENT":"prod","GOAPP_INTERNAL_URLS":"[\"https://us.battle.net/oauth/authorize\",\"https://www.patreon.com/oauth2/authorize?response_type=code\\u0026client_id=0S6EOTIF-ISqJerbf3Q_PmEO-HoAEnURyLgY1K1_mnbNQx8cB-vrExNuPM2JCDei\\u0026redirect_uri=https://murlok.io/account/login/patreon\\u0026scope=identity+identity%5Bemail%5D\"]","GOAPP_ROOT_PREFIX":"","GOAPP_STATIC_RESOURCES_URL":"https://cdn.murlok.io/prod","GOAPP_VERSION":"v3.12.92","MURLOK_PUBLIC_KEY":"-----BEGIN PUBLIC KEY-----\nMIGeMA0GCSqGSIb3DQEBAQUAA4GMADCBiAKBgHNFdTjkXl1H7FExpOQFhGahLbsP\nLYIvHy0tsNAI+yAtC45O5tOlqKvaMDCSxezLMP+eqIGwHeZfH4TeRqycXc0XJNfA\nR7VLCEzXl/cdPQcGHoVSMuf+ORDjjdf4y5x0itTqmpnTWvX4JGiYrp3sxqsqP0o6\nD+wKXaUOcSWd9QMBAgMBAAE=\n-----END PUBLIC KEY-----\n","PATREON_AUTHORIZE_URL":"https://www.patreon.com/oauth2/authorize?response_type=code\u0026client_id=0S6EOTIF-ISqJerbf3Q_PmEO-HoAEnURyLgY1K1_mnbNQx8cB-vrExNuPM2JCDei\u0026redirect_uri=https://murlok.io/account/login/patreon\u0026scope=identity+identity%5Bemail%5D"};const goappLoadingLabel="Loading {progress}%";const goappWasmContentLengthHeader="X-Goog-Meta-Wasm-Content-Length";let goappServiceWorkerRegistration;let deferredPrompt=null;goappInitServiceWorker();goappWatchForUpdate();goappWatchForInstallable();goappInitWebAssembly();async function goappInitServiceWorker(){if("serviceWorker"in navigator){try{const registration=await navigator.serviceWorker.register("/app-worker.js");goappServiceWorkerRegistration=registration;goappSetupNotifyUpdate(registration);goappSetupAutoUpdate(registration);goappSetupPushNotification();}catch(err){console.error("goapp service worker registration failed",err);}}}
function goappWatchForUpdate(){window.addEventListener("beforeinstallprompt",(e)=>{e.preventDefault();deferredPrompt=e;goappOnAppInstallChange();});}
function goappSetupNotifyUpdate(registration){registration.addEventListener("updatefound",(event)=>{const newSW=registration.installing;newSW.addEventListener("statechange",(event)=>{if(!navigator.serviceWorker.controller){return;}
if(newSW.state!="installed"){return;}
goappOnUpdate();});});}
function goappSetupAutoUpdate(registration){const autoUpdateInterval="180000";if(autoUpdateInterval==0){return;}
window.setInterval(()=>{registration.update();},autoUpdateInterval);}
function goappWatchForInstallable(){window.addEventListener("appinstalled",()=>{deferredPrompt=null;goappOnAppInstallChange();});}
function goappIsAppInstallable(){return!goappIsAppInstalled()&&deferredPrompt!=null;}
function goappIsAppInstalled(){const isStandalone=window.matchMedia("(display-mode: standalone)").matches;return isStandalone||navigator.standalone;}
async function goappShowInstallPrompt(){deferredPrompt.prompt();await deferredPrompt.userChoice;deferredPrompt=null;}
function goappGetenv(k){return goappEnv[k];}
function goappSetupPushNotification(){navigator.serviceWorker.addEventListener("message",(event)=>{const msg=event.data.goapp;if(!msg){return;}
if(msg.type!=="notification"){return;}
goappNav(msg.path);});}
async function goappSubscribePushNotifications(vapIDpublicKey){try{const subscription=await goappServiceWorkerRegistration.pushManager.subscribe({userVisibleOnly:true,applicationServerKey:vapIDpublicKey,});return JSON.stringify(subscription);}catch(err){console.error(err);return "";}}
function goappNewNotification(jsonNotification){let notification=JSON.parse(jsonNotification);const title=notification.title;delete notification.title;let path=notification.path;if(!path){path="/";}
const webNotification=new Notification(title,notification);webNotification.onclick=()=>{goappNav(path);webNotification.close();};}
function goappKeepBodyClean(){const body=document.body;const bodyChildrenCount=body.children.length;const mutationObserver=new MutationObserver(function(mutationList){mutationList.forEach((mutation)=>{switch(mutation.type){case "childList":while(body.children.length>bodyChildrenCount){body.removeChild(body.lastChild);}
break;}});});mutationObserver.observe(document.body,{childList:true,});return()=>mutationObserver.disconnect();}
async function goappInitWebAssembly(){const loader=document.getElementById("app-wasm-loader");if(!goappCanLoadWebAssembly()){loader.remove();return;}
let instantiateStreaming=WebAssembly.instantiateStreaming;if(!instantiateStreaming){instantiateStreaming=async(resp,importObject)=>{const source=await(await resp).arrayBuffer();return await WebAssembly.instantiate(source,importObject);};}
const loaderIcon=document.getElementById("app-wasm-loader-icon");const loaderLabel=document.getElementById("app-wasm-loader-label");try{const showProgress=(progress)=>{loaderLabel.innerText=goappLoadingLabel.replace("{progress}",progress);};showProgress(0);const go=new Go();const wasm=await instantiateStreaming(fetchWithProgress("https://cdn.murlok.io/prod/web/app.wasm",showProgress),go.importObject);go.run(wasm.instance);loader.remove();}catch(err){loaderIcon.className="goapp-logo";loaderLabel.innerText=err;console.error("loading wasm failed: ",err);}}
function goappCanLoadWebAssembly(){if(/bot|googlebot|crawler|spider|robot|crawling/i.test(navigator.userAgent)){return false;}
const urlParams=new URLSearchParams(window.location.search);return urlParams.get("wasm")!=="false";}
async function fetchWithProgress(url,progess){const response=await fetch(url);let contentLength;try{contentLength=response.headers.get(goappWasmContentLengthHeader);}catch{}
if(!goappWasmContentLengthHeader||!contentLength){contentLength=response.headers.get("Content-Length");}
const total=parseInt(contentLength,10);let loaded=0;const progressHandler=function(loaded,total){progess(Math.round((loaded*100)/total));};var res=new Response(new ReadableStream({async start(controller){var reader=response.body.getReader();for(;;){var{done,value}=await reader.read();if(done){progressHandler(total,total);break;}
loaded+=value.byteLength;progressHandler(loaded,total);controller.enqueue(value);}
controller.close();},},{status:response.status,statusText:response.statusText,}));for(var pair of response.headers.entries()){res.headers.set(pair[0],pair[1]);}
return res;}