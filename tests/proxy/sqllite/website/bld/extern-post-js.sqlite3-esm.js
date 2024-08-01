
/* ^^^^ ACHTUNG: blank line at the start is necessary because
   Emscripten will not add a newline in some cases and we need
   a blank line for a sed-based kludge for the ES6 build. */
/* extern-post-js.js must be appended to the resulting sqlite3.js
   file. It gets its name from being used as the value for the
   --extern-post-js=... Emscripten flag. Note that this code, unlike
   most of the associated JS code, runs outside of the
   Emscripten-generated module init scope, in the current
   global scope. */
const toExportForESM =
(function(){
  /**
     In order to hide the sqlite3InitModule()'s resulting
     Emscripten module from downstream clients (and simplify our
     documentation by being able to elide those details), we hide that
     function and expose a hand-written sqlite3InitModule() to return
     the sqlite3 object (most of the time).

     Unfortunately, we cannot modify the module-loader/exporter-based
     impls which Emscripten installs at some point in the file above
     this.
  */
  const originalInit = sqlite3InitModule;
  if(!originalInit){
    throw new Error("Expecting globalThis.sqlite3InitModule to be defined by the Emscripten build.");
  }
  /**
     We need to add some state which our custom Module.locateFile()
     can see, but an Emscripten limitation currently prevents us from
     attaching it to the sqlite3InitModule function object:

     https://github.com/emscripten-core/emscripten/issues/18071

     The only(?) current workaround is to temporarily stash this state
     into the global scope and delete it when sqlite3InitModule()
     is called.
  */
  const initModuleState = globalThis.sqlite3InitModuleState = Object.assign(Object.create(null),{
    moduleScript: globalThis?.document?.currentScript,
    isWorker: ('undefined' !== typeof WorkerGlobalScope),
    location: globalThis.location,
    urlParams:  globalThis?.location?.href
      ? new URL(globalThis.location.href).searchParams
      : new URLSearchParams()
  });
  initModuleState.debugModule =
    initModuleState.urlParams.has('sqlite3.debugModule')
    ? (...args)=>console.warn('sqlite3.debugModule:',...args)
    : ()=>{};

  if(initModuleState.urlParams.has('sqlite3.dir')){
    initModuleState.sqlite3Dir = initModuleState.urlParams.get('sqlite3.dir') +'/';
  }else if(initModuleState.moduleScript){
    const li = initModuleState.moduleScript.src.split('/');
    li.pop();
    initModuleState.sqlite3Dir = li.join('/') + '/';
  }

  globalThis.sqlite3InitModule = function ff(...args){
    //console.warn("Using replaced sqlite3InitModule()",globalThis.location);
    return originalInit(...args).then((EmscriptenModule)=>{
      //console.warn("sqlite3InitModule() returning sqlite3 object.");
      const s = EmscriptenModule.sqlite3;
      s.scriptInfo = initModuleState;
      //console.warn("sqlite3.scriptInfo =",s.scriptInfo);
      if(ff.__isUnderTest) s.__isUnderTest = true;
      const f = s.asyncPostInit;
      delete s.asyncPostInit;
      return f();
    }).catch((e)=>{
      console.error("Exception loading sqlite3 module:",e);
      throw e;
    });
  };
  globalThis.sqlite3InitModule.ready = originalInit.ready;

  if(globalThis.sqlite3InitModuleState.moduleScript){
    const sim = globalThis.sqlite3InitModuleState;
    let src = sim.moduleScript.src.split('/');
    src.pop();
    sim.scriptDir = src.join('/') + '/';
  }
  initModuleState.debugModule('sqlite3InitModuleState =',initModuleState);
  if(0){
    console.warn("Replaced sqlite3InitModule()");
    console.warn("globalThis.location.href =",globalThis.location.href);
    if('undefined' !== typeof document){
      console.warn("document.currentScript.src =",
                   document?.currentScript?.src);
    }
  }
  return globalThis.sqlite3InitModule /* required for ESM */;
})();
sqlite3InitModule = toExportForESM;
export default sqlite3InitModule;
