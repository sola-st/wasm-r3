
var Module = typeof Module !== 'undefined' ? Module : {};

if (!Module.expectedDataFileDownloads) {
  Module.expectedDataFileDownloads = 0;
  Module.finishedDataFileDownloads = 0;
}
Module.expectedDataFileDownloads++;
(function() {
 var loadPackage = function(metadata) {

    var PACKAGE_PATH;
    if (typeof window === 'object') {
      PACKAGE_PATH = window['encodeURIComponent'](window.location.pathname.toString().substring(0, window.location.pathname.toString().lastIndexOf('/')) + '/');
    } else if (typeof location !== 'undefined') {
      // worker
      PACKAGE_PATH = encodeURIComponent(location.pathname.toString().substring(0, location.pathname.toString().lastIndexOf('/')) + '/');
    } else {
      throw 'using preloaded data can only be done on a web page or in a web worker';
    }
    var PACKAGE_NAME = 'base.data';
    var REMOTE_PACKAGE_BASE = 'base.data';
    if (typeof Module['locateFilePackage'] === 'function' && !Module['locateFile']) {
      Module['locateFile'] = Module['locateFilePackage'];
      err('warning: you defined Module.locateFilePackage, that has been renamed to Module.locateFile (using your locateFilePackage for now)');
    }
    var REMOTE_PACKAGE_NAME = Module['locateFile'] ? Module['locateFile'](REMOTE_PACKAGE_BASE, '') : REMOTE_PACKAGE_BASE;
  
    var REMOTE_PACKAGE_SIZE = metadata.remote_package_size;
    var PACKAGE_UUID = metadata.package_uuid;
  
    function fetchRemotePackage(packageName, packageSize, callback, errback) {
      var xhr = new XMLHttpRequest();
      xhr.open('GET', packageName, true);
      xhr.responseType = 'arraybuffer';
      xhr.onprogress = function(event) {
        var url = packageName;
        var size = packageSize;
        if (event.total) size = event.total;
        if (event.loaded) {
          if (!xhr.addedTotal) {
            xhr.addedTotal = true;
            if (!Module.dataFileDownloads) Module.dataFileDownloads = {};
            Module.dataFileDownloads[url] = {
              loaded: event.loaded,
              total: size
            };
          } else {
            Module.dataFileDownloads[url].loaded = event.loaded;
          }
          var total = 0;
          var loaded = 0;
          var num = 0;
          for (var download in Module.dataFileDownloads) {
          var data = Module.dataFileDownloads[download];
            total += data.total;
            loaded += data.loaded;
            num++;
          }
          total = Math.ceil(total * Module.expectedDataFileDownloads/num);
          if (Module['setStatus']) Module['setStatus']('Downloading data... (' + loaded + '/' + total + ')');
        } else if (!Module.dataFileDownloads) {
          if (Module['setStatus']) Module['setStatus']('Downloading data...');
        }
      };
      xhr.onerror = function(event) {
        throw new Error("NetworkError for: " + packageName);
      }
      xhr.onload = function(event) {
        if (xhr.status == 200 || xhr.status == 304 || xhr.status == 206 || (xhr.status == 0 && xhr.response)) { // file URLs can return 0
          var packageData = xhr.response;
          callback(packageData);
        } else {
          throw new Error(xhr.statusText + " : " + xhr.responseURL);
        }
      };
      xhr.send(null);
    };

    function handleError(error) {
      console.error('package error:', error);
    };
  
      var fetchedCallback = null;
      var fetched = Module['getPreloadedPackage'] ? Module['getPreloadedPackage'](REMOTE_PACKAGE_NAME, REMOTE_PACKAGE_SIZE) : null;

      if (!fetched) fetchRemotePackage(REMOTE_PACKAGE_NAME, REMOTE_PACKAGE_SIZE, function(data) {
        if (fetchedCallback) {
          fetchedCallback(data);
          fetchedCallback = null;
        } else {
          fetched = data;
        }
      }, handleError);
    
  function runWithFS() {

    function assert(check, msg) {
      if (!check) throw msg + new Error().stack;
    }
Module['FS_createPath']('/', 'data', true, true);
Module['FS_createPath']('/', 'packages', true, true);
Module['FS_createPath']('/packages', 'textures', true, true);
Module['FS_createPath']('/packages', 'fonts', true, true);
Module['FS_createPath']('/packages', 'icons', true, true);
Module['FS_createPath']('/packages', 'particles', true, true);
Module['FS_createPath']('/packages', 'sounds', true, true);
Module['FS_createPath']('/packages/sounds', 'aard', true, true);
Module['FS_createPath']('/packages/sounds', 'q009', true, true);
Module['FS_createPath']('/packages/sounds', 'yo_frankie', true, true);
Module['FS_createPath']('/packages', 'gk', true, true);
Module['FS_createPath']('/packages/gk', 'lava', true, true);
Module['FS_createPath']('/packages', 'caustics', true, true);
Module['FS_createPath']('/packages', 'models', true, true);
Module['FS_createPath']('/packages/models', 'debris', true, true);
Module['FS_createPath']('/packages/models', 'projectiles', true, true);
Module['FS_createPath']('/packages/models/projectiles', 'grenade', true, true);
Module['FS_createPath']('/packages/models/projectiles', 'rocket', true, true);
Module['FS_createPath']('/packages', 'brushes', true, true);
Module['FS_createPath']('/packages', 'hud', true, true);

    function DataRequest(start, end, audio) {
      this.start = start;
      this.end = end;
      this.audio = audio;
    }
    DataRequest.prototype = {
      requests: {},
      open: function(mode, name) {
        this.name = name;
        this.requests[name] = this;
        Module['addRunDependency']('fp ' + this.name);
      },
      send: function() {},
      onload: function() {
        var byteArray = this.byteArray.subarray(this.start, this.end);
        this.finish(byteArray);
      },
      finish: function(byteArray) {
        var that = this;

        Module['FS_createPreloadedFile'](this.name, null, byteArray, true, true, function() {
          Module['removeRunDependency']('fp ' + that.name);
        }, function() {
          if (that.audio) {
            Module['removeRunDependency']('fp ' + that.name); // workaround for chromium bug 124926 (still no audio with this, but at least we don't hang)
          } else {
            err('Preloading file ' + that.name + ' failed');
          }
        }, false, true); // canOwn this data in the filesystem, it is a slide into the heap that will never change

        this.requests[this.name] = null;
      }
    };

        var files = metadata.files;
        for (var i = 0; i < files.length; ++i) {
          new DataRequest(files[i].start, files[i].end, files[i].audio).open('GET', files[i].filename);
        }

  
    function processPackageData(arrayBuffer) {
      Module.finishedDataFileDownloads++;
      assert(arrayBuffer, 'Loading data file failed.');
      assert(arrayBuffer instanceof ArrayBuffer, 'bad input to processPackageData');
      var byteArray = new Uint8Array(arrayBuffer);
      var curr;
      
        // copy the entire loaded file into a spot in the heap. Files will refer to slices in that. They cannot be freed though
        // (we may be allocating before malloc is ready, during startup).
        var ptr = Module['getMemory'](byteArray.length);
        Module['HEAPU8'].set(byteArray, ptr);
        DataRequest.prototype.byteArray = Module['HEAPU8'].subarray(ptr, ptr+byteArray.length);
  
          var files = metadata.files;
          for (var i = 0; i < files.length; ++i) {
            DataRequest.prototype.requests[files[i].filename].onload();
          }
              Module['removeRunDependency']('datafile_base.data');

    };
    Module['addRunDependency']('datafile_base.data');
  
    if (!Module.preloadResults) Module.preloadResults = {};
  
      Module.preloadResults[PACKAGE_NAME] = {fromCache: false};
      if (fetched) {
        processPackageData(fetched);
        fetched = null;
      } else {
        fetchedCallback = processPackageData;
      }
    
  }
  if (Module['calledRun']) {
    runWithFS();
  } else {
    if (!Module['preRun']) Module['preRun'] = [];
    Module["preRun"].push(runWithFS); // FS is not initialized yet, wait for it
  }

 }
 loadPackage({"files": [{"start": 0, "audio": 0, "end": 17562, "filename": "/data/background.png"}, {"start": 17562, "audio": 0, "end": 31114, "filename": "/data/background_decal.png"}, {"start": 31114, "audio": 0, "end": 31273, "filename": "/data/background_detail.png"}, {"start": 31273, "audio": 0, "end": 36790, "filename": "/data/brush.cfg"}, {"start": 36790, "audio": 0, "end": 40073, "filename": "/data/crosshair.png"}, {"start": 40073, "audio": 0, "end": 47290, "filename": "/data/defaults.cfg"}, {"start": 47290, "audio": 0, "end": 47426, "filename": "/data/default_map_models.cfg"}, {"start": 47426, "audio": 0, "end": 48648, "filename": "/data/default_map_settings.cfg"}, {"start": 48648, "audio": 0, "end": 48720, "filename": "/data/font.cfg"}, {"start": 48720, "audio": 0, "end": 52486, "filename": "/data/game_fps.cfg"}, {"start": 52486, "audio": 0, "end": 60651, "filename": "/data/game_rpg.cfg"}, {"start": 60651, "audio": 0, "end": 145138, "filename": "/data/glsl.cfg"}, {"start": 145138, "audio": 0, "end": 149069, "filename": "/data/guicursor.png"}, {"start": 149069, "audio": 0, "end": 153953, "filename": "/data/guioverlay.png"}, {"start": 153953, "audio": 0, "end": 158199, "filename": "/data/guiskin.png"}, {"start": 158199, "audio": 0, "end": 161031, "filename": "/data/guislider.png"}, {"start": 161031, "audio": 0, "end": 164314, "filename": "/data/hit.png"}, {"start": 164314, "audio": 0, "end": 166721, "filename": "/data/keymap.cfg"}, {"start": 166721, "audio": 0, "end": 169704, "filename": "/data/loading_bar.png"}, {"start": 169704, "audio": 0, "end": 173385, "filename": "/data/loading_frame.png"}, {"start": 173385, "audio": 0, "end": 303591, "filename": "/data/logo.png"}, {"start": 303591, "audio": 0, "end": 308475, "filename": "/data/mapshot_frame.png"}, {"start": 308475, "audio": 0, "end": 356325, "filename": "/data/menus.cfg"}, {"start": 356325, "audio": 0, "end": 359232, "filename": "/data/sounds.cfg"}, {"start": 359232, "audio": 0, "end": 367736, "filename": "/data/stdedit.cfg"}, {"start": 367736, "audio": 0, "end": 368749, "filename": "/data/stdlib.cfg"}, {"start": 368749, "audio": 0, "end": 458379, "filename": "/data/stdshader.cfg"}, {"start": 458379, "audio": 0, "end": 461691, "filename": "/data/teammate.png"}, {"start": 461691, "audio": 0, "end": 463220, "filename": "/packages/textures/basic512.png"}, {"start": 463220, "audio": 0, "end": 466272, "filename": "/packages/textures/default.png"}, {"start": 466272, "audio": 0, "end": 860027, "filename": "/packages/textures/grass.png"}, {"start": 860027, "audio": 0, "end": 864752, "filename": "/packages/textures/notexture.png"}, {"start": 864752, "audio": 0, "end": 865423, "filename": "/packages/textures/readme.txt"}, {"start": 865423, "audio": 0, "end": 869234, "filename": "/packages/textures/sky.png"}, {"start": 869234, "audio": 0, "end": 1025237, "filename": "/packages/textures/water.jpg"}, {"start": 1025237, "audio": 0, "end": 1280410, "filename": "/packages/textures/waterdudv.jpg"}, {"start": 1280410, "audio": 0, "end": 1317604, "filename": "/packages/textures/waterfall.jpg"}, {"start": 1317604, "audio": 0, "end": 1559774, "filename": "/packages/textures/waterfalldudv.jpg"}, {"start": 1559774, "audio": 0, "end": 1737336, "filename": "/packages/textures/waterfalln.jpg"}, {"start": 1737336, "audio": 0, "end": 2087159, "filename": "/packages/textures/watern.jpg"}, {"start": 2087159, "audio": 0, "end": 2089401, "filename": "/packages/fonts/default.cfg"}, {"start": 2089401, "audio": 0, "end": 2175525, "filename": "/packages/fonts/font.png"}, {"start": 2175525, "audio": 0, "end": 2180250, "filename": "/packages/fonts/font_readme.txt"}, {"start": 2180250, "audio": 0, "end": 2198557, "filename": "/packages/icons/action.jpg"}, {"start": 2198557, "audio": 0, "end": 2210219, "filename": "/packages/icons/arrow_bw.jpg"}, {"start": 2210219, "audio": 0, "end": 2222329, "filename": "/packages/icons/arrow_fw.jpg"}, {"start": 2222329, "audio": 0, "end": 2235397, "filename": "/packages/icons/chat.jpg"}, {"start": 2235397, "audio": 0, "end": 2251837, "filename": "/packages/icons/checkbox_off.jpg"}, {"start": 2251837, "audio": 0, "end": 2270040, "filename": "/packages/icons/checkbox_on.jpg"}, {"start": 2270040, "audio": 0, "end": 2282935, "filename": "/packages/icons/cube.jpg"}, {"start": 2282935, "audio": 0, "end": 2295992, "filename": "/packages/icons/exit.jpg"}, {"start": 2295992, "audio": 0, "end": 2311126, "filename": "/packages/icons/frankie.jpg"}, {"start": 2311126, "audio": 0, "end": 2324630, "filename": "/packages/icons/hand.jpg"}, {"start": 2324630, "audio": 0, "end": 2338008, "filename": "/packages/icons/info.jpg"}, {"start": 2338008, "audio": 0, "end": 2356000, "filename": "/packages/icons/menu.jpg"}, {"start": 2356000, "audio": 0, "end": 2360089, "filename": "/packages/icons/menu.png"}, {"start": 2360089, "audio": 0, "end": 2378817, "filename": "/packages/icons/radio_off.jpg"}, {"start": 2378817, "audio": 0, "end": 2392097, "filename": "/packages/icons/radio_on.jpg"}, {"start": 2392097, "audio": 0, "end": 2392194, "filename": "/packages/icons/readme.txt"}, {"start": 2392194, "audio": 0, "end": 2410870, "filename": "/packages/icons/server.jpg"}, {"start": 2410870, "audio": 0, "end": 2424366, "filename": "/packages/icons/snoutx10k.jpg"}, {"start": 2424366, "audio": 0, "end": 2478298, "filename": "/packages/particles/ball1.png"}, {"start": 2478298, "audio": 0, "end": 2540450, "filename": "/packages/particles/ball2.png"}, {"start": 2540450, "audio": 0, "end": 2543348, "filename": "/packages/particles/base.png"}, {"start": 2543348, "audio": 0, "end": 2545615, "filename": "/packages/particles/blob.png"}, {"start": 2545615, "audio": 0, "end": 2561241, "filename": "/packages/particles/blood.png"}, {"start": 2561241, "audio": 0, "end": 2618405, "filename": "/packages/particles/bullet.png"}, {"start": 2618405, "audio": 0, "end": 2637910, "filename": "/packages/particles/circle.png"}, {"start": 2637910, "audio": 0, "end": 3371389, "filename": "/packages/particles/explosion.png"}, {"start": 3371389, "audio": 0, "end": 3441581, "filename": "/packages/particles/flames.png"}, {"start": 3441581, "audio": 0, "end": 3442442, "filename": "/packages/particles/flare.jpg"}, {"start": 3442442, "audio": 0, "end": 3768342, "filename": "/packages/particles/lensflares.png"}, {"start": 3768342, "audio": 0, "end": 3826204, "filename": "/packages/particles/lightning.jpg"}, {"start": 3826204, "audio": 0, "end": 3846105, "filename": "/packages/particles/muzzleflash1.jpg"}, {"start": 3846105, "audio": 0, "end": 3865127, "filename": "/packages/particles/muzzleflash2.jpg"}, {"start": 3865127, "audio": 0, "end": 3885265, "filename": "/packages/particles/muzzleflash3.jpg"}, {"start": 3885265, "audio": 0, "end": 3885509, "filename": "/packages/particles/readme.txt"}, {"start": 3885509, "audio": 0, "end": 3885754, "filename": "/packages/particles/readme.txt~"}, {"start": 3885754, "audio": 0, "end": 3925590, "filename": "/packages/particles/scorch.png"}, {"start": 3925590, "audio": 0, "end": 3930102, "filename": "/packages/particles/smoke.png"}, {"start": 3930102, "audio": 0, "end": 3931907, "filename": "/packages/particles/spark.png"}, {"start": 3931907, "audio": 0, "end": 3939322, "filename": "/packages/particles/steam.png"}, {"start": 3939322, "audio": 1, "end": 3951184, "filename": "/packages/sounds/aard/bang.wav"}, {"start": 3951184, "audio": 1, "end": 3960898, "filename": "/packages/sounds/aard/die1.wav"}, {"start": 3960898, "audio": 1, "end": 3971550, "filename": "/packages/sounds/aard/die2.wav"}, {"start": 3971550, "audio": 1, "end": 3982956, "filename": "/packages/sounds/aard/grunt1.wav"}, {"start": 3982956, "audio": 1, "end": 3986650, "filename": "/packages/sounds/aard/grunt2.wav"}, {"start": 3986650, "audio": 1, "end": 3998964, "filename": "/packages/sounds/aard/itempick.wav"}, {"start": 3998964, "audio": 1, "end": 4003096, "filename": "/packages/sounds/aard/jump.wav"}, {"start": 4003096, "audio": 1, "end": 4014458, "filename": "/packages/sounds/aard/land.wav"}, {"start": 4014458, "audio": 1, "end": 4018516, "filename": "/packages/sounds/aard/outofammo.wav"}, {"start": 4018516, "audio": 1, "end": 4043986, "filename": "/packages/sounds/aard/pain1.wav"}, {"start": 4043986, "audio": 1, "end": 4053396, "filename": "/packages/sounds/aard/pain2.wav"}, {"start": 4053396, "audio": 1, "end": 4062746, "filename": "/packages/sounds/aard/pain3.wav"}, {"start": 4062746, "audio": 1, "end": 4070726, "filename": "/packages/sounds/aard/pain4.wav"}, {"start": 4070726, "audio": 1, "end": 4078686, "filename": "/packages/sounds/aard/pain5.wav"}, {"start": 4078686, "audio": 1, "end": 4086352, "filename": "/packages/sounds/aard/pain6.wav"}, {"start": 4086352, "audio": 1, "end": 4088056, "filename": "/packages/sounds/aard/tak.wav"}, {"start": 4088056, "audio": 1, "end": 4094702, "filename": "/packages/sounds/aard/weapload.wav"}, {"start": 4094702, "audio": 1, "end": 4124684, "filename": "/packages/sounds/q009/explosion.ogg"}, {"start": 4124684, "audio": 1, "end": 4158371, "filename": "/packages/sounds/q009/glauncher.ogg"}, {"start": 4158371, "audio": 1, "end": 4193813, "filename": "/packages/sounds/q009/glauncher2.ogg"}, {"start": 4193813, "audio": 1, "end": 4227041, "filename": "/packages/sounds/q009/glauncher3.ogg"}, {"start": 4227041, "audio": 1, "end": 4245932, "filename": "/packages/sounds/q009/jumppad.ogg"}, {"start": 4245932, "audio": 0, "end": 4265372, "filename": "/packages/sounds/q009/license.txt"}, {"start": 4265372, "audio": 1, "end": 4293259, "filename": "/packages/sounds/q009/minigun.ogg"}, {"start": 4293259, "audio": 1, "end": 4316587, "filename": "/packages/sounds/q009/minigun2.ogg"}, {"start": 4316587, "audio": 1, "end": 4342843, "filename": "/packages/sounds/q009/minigun3.ogg"}, {"start": 4342843, "audio": 1, "end": 4360718, "filename": "/packages/sounds/q009/outofammo.ogg"}, {"start": 4360718, "audio": 1, "end": 4389112, "filename": "/packages/sounds/q009/pistol.ogg"}, {"start": 4389112, "audio": 1, "end": 4417494, "filename": "/packages/sounds/q009/pistol2.ogg"}, {"start": 4417494, "audio": 1, "end": 4444394, "filename": "/packages/sounds/q009/pistol3.ogg"}, {"start": 4444394, "audio": 1, "end": 4477016, "filename": "/packages/sounds/q009/quaddamage_out.ogg"}, {"start": 4477016, "audio": 1, "end": 4504724, "filename": "/packages/sounds/q009/quaddamage_shoot.ogg"}, {"start": 4504724, "audio": 0, "end": 4506040, "filename": "/packages/sounds/q009/readme.txt"}, {"start": 4506040, "audio": 1, "end": 4639826, "filename": "/packages/sounds/q009/ren.ogg"}, {"start": 4639826, "audio": 1, "end": 4742892, "filename": "/packages/sounds/q009/ren2.ogg"}, {"start": 4742892, "audio": 1, "end": 4859331, "filename": "/packages/sounds/q009/ren3.ogg"}, {"start": 4859331, "audio": 1, "end": 4988368, "filename": "/packages/sounds/q009/rifle.ogg"}, {"start": 4988368, "audio": 1, "end": 5112588, "filename": "/packages/sounds/q009/rifle2.ogg"}, {"start": 5112588, "audio": 1, "end": 5235271, "filename": "/packages/sounds/q009/rifle3.ogg"}, {"start": 5235271, "audio": 1, "end": 5293208, "filename": "/packages/sounds/q009/rlauncher.ogg"}, {"start": 5293208, "audio": 1, "end": 5351907, "filename": "/packages/sounds/q009/rlauncher2.ogg"}, {"start": 5351907, "audio": 1, "end": 5409552, "filename": "/packages/sounds/q009/rlauncher3.ogg"}, {"start": 5409552, "audio": 1, "end": 5534632, "filename": "/packages/sounds/q009/shotgun.ogg"}, {"start": 5534632, "audio": 1, "end": 5660734, "filename": "/packages/sounds/q009/shotgun2.ogg"}, {"start": 5660734, "audio": 1, "end": 5785132, "filename": "/packages/sounds/q009/shotgun3.ogg"}, {"start": 5785132, "audio": 1, "end": 5811305, "filename": "/packages/sounds/q009/teleport.ogg"}, {"start": 5811305, "audio": 1, "end": 5831748, "filename": "/packages/sounds/q009/weapswitch.ogg"}, {"start": 5831748, "audio": 1, "end": 5851357, "filename": "/packages/sounds/yo_frankie/amb_waterdrip_2.ogg"}, {"start": 5851357, "audio": 0, "end": 5851987, "filename": "/packages/sounds/yo_frankie/readme.txt"}, {"start": 5851987, "audio": 1, "end": 5859400, "filename": "/packages/sounds/yo_frankie/sfx_interact.ogg"}, {"start": 5859400, "audio": 1, "end": 5883305, "filename": "/packages/sounds/yo_frankie/watersplash2.ogg"}, {"start": 5883305, "audio": 0, "end": 6058209, "filename": "/packages/gk/lava/lava_cc.dds"}, {"start": 6058209, "audio": 0, "end": 6407889, "filename": "/packages/gk/lava/lava_nm.dds"}, {"start": 6407889, "audio": 0, "end": 6432408, "filename": "/packages/caustics/caust00.png"}, {"start": 6432408, "audio": 0, "end": 6456900, "filename": "/packages/caustics/caust01.png"}, {"start": 6456900, "audio": 0, "end": 6481016, "filename": "/packages/caustics/caust02.png"}, {"start": 6481016, "audio": 0, "end": 6504591, "filename": "/packages/caustics/caust03.png"}, {"start": 6504591, "audio": 0, "end": 6527789, "filename": "/packages/caustics/caust04.png"}, {"start": 6527789, "audio": 0, "end": 6550659, "filename": "/packages/caustics/caust05.png"}, {"start": 6550659, "audio": 0, "end": 6573983, "filename": "/packages/caustics/caust06.png"}, {"start": 6573983, "audio": 0, "end": 6597850, "filename": "/packages/caustics/caust07.png"}, {"start": 6597850, "audio": 0, "end": 6622012, "filename": "/packages/caustics/caust08.png"}, {"start": 6622012, "audio": 0, "end": 6645895, "filename": "/packages/caustics/caust09.png"}, {"start": 6645895, "audio": 0, "end": 6669720, "filename": "/packages/caustics/caust10.png"}, {"start": 6669720, "audio": 0, "end": 6693884, "filename": "/packages/caustics/caust11.png"}, {"start": 6693884, "audio": 0, "end": 6718625, "filename": "/packages/caustics/caust12.png"}, {"start": 6718625, "audio": 0, "end": 6743811, "filename": "/packages/caustics/caust13.png"}, {"start": 6743811, "audio": 0, "end": 6768863, "filename": "/packages/caustics/caust14.png"}, {"start": 6768863, "audio": 0, "end": 6793312, "filename": "/packages/caustics/caust15.png"}, {"start": 6793312, "audio": 0, "end": 6817669, "filename": "/packages/caustics/caust16.png"}, {"start": 6817669, "audio": 0, "end": 6842148, "filename": "/packages/caustics/caust17.png"}, {"start": 6842148, "audio": 0, "end": 6866689, "filename": "/packages/caustics/caust18.png"}, {"start": 6866689, "audio": 0, "end": 6890868, "filename": "/packages/caustics/caust19.png"}, {"start": 6890868, "audio": 0, "end": 6914974, "filename": "/packages/caustics/caust20.png"}, {"start": 6914974, "audio": 0, "end": 6938612, "filename": "/packages/caustics/caust21.png"}, {"start": 6938612, "audio": 0, "end": 6962056, "filename": "/packages/caustics/caust22.png"}, {"start": 6962056, "audio": 0, "end": 6985331, "filename": "/packages/caustics/caust23.png"}, {"start": 6985331, "audio": 0, "end": 7008500, "filename": "/packages/caustics/caust24.png"}, {"start": 7008500, "audio": 0, "end": 7031706, "filename": "/packages/caustics/caust25.png"}, {"start": 7031706, "audio": 0, "end": 7055260, "filename": "/packages/caustics/caust26.png"}, {"start": 7055260, "audio": 0, "end": 7078904, "filename": "/packages/caustics/caust27.png"}, {"start": 7078904, "audio": 0, "end": 7102405, "filename": "/packages/caustics/caust28.png"}, {"start": 7102405, "audio": 0, "end": 7126155, "filename": "/packages/caustics/caust29.png"}, {"start": 7126155, "audio": 0, "end": 7150409, "filename": "/packages/caustics/caust30.png"}, {"start": 7150409, "audio": 0, "end": 7174952, "filename": "/packages/caustics/caust31.png"}, {"start": 7174952, "audio": 0, "end": 7175010, "filename": "/packages/caustics/readme.txt"}, {"start": 7175010, "audio": 0, "end": 7175253, "filename": "/packages/models/debris/md2.cfg"}, {"start": 7175253, "audio": 0, "end": 7367079, "filename": "/packages/models/debris/skin.png"}, {"start": 7367079, "audio": 0, "end": 7381855, "filename": "/packages/models/debris/tris.md2"}, {"start": 7381855, "audio": 0, "end": 7381993, "filename": "/packages/models/projectiles/grenade/iqm.cfg"}, {"start": 7381993, "audio": 0, "end": 7382149, "filename": "/packages/models/projectiles/rocket/iqm.cfg"}, {"start": 7382149, "audio": 0, "end": 7402917, "filename": "/packages/models/projectiles/rocket/mask.jpg"}, {"start": 7402917, "audio": 0, "end": 7410636, "filename": "/packages/models/projectiles/rocket/normal.jpg"}, {"start": 7410636, "audio": 0, "end": 7411296, "filename": "/packages/models/projectiles/rocket/readme.txt"}, {"start": 7411296, "audio": 0, "end": 7414432, "filename": "/packages/models/projectiles/rocket/rocket.iqm"}, {"start": 7414432, "audio": 0, "end": 7427669, "filename": "/packages/models/projectiles/rocket/skin.jpg"}, {"start": 7427669, "audio": 0, "end": 7431757, "filename": "/packages/brushes/circle_128_hard.png"}, {"start": 7431757, "audio": 0, "end": 7435234, "filename": "/packages/brushes/circle_128_soft.png"}, {"start": 7435234, "audio": 0, "end": 7437598, "filename": "/packages/brushes/circle_128_solid.png"}, {"start": 7437598, "audio": 0, "end": 7438720, "filename": "/packages/brushes/circle_16_hard.png"}, {"start": 7438720, "audio": 0, "end": 7439811, "filename": "/packages/brushes/circle_16_soft.png"}, {"start": 7439811, "audio": 0, "end": 7440924, "filename": "/packages/brushes/circle_16_solid.png"}, {"start": 7440924, "audio": 0, "end": 7444484, "filename": "/packages/brushes/circle_32_hard.png"}, {"start": 7444484, "audio": 0, "end": 7445769, "filename": "/packages/brushes/circle_32_soft.png"}, {"start": 7445769, "audio": 0, "end": 7447007, "filename": "/packages/brushes/circle_32_solid.png"}, {"start": 7447007, "audio": 0, "end": 7451339, "filename": "/packages/brushes/circle_64_hard.png"}, {"start": 7451339, "audio": 0, "end": 7453153, "filename": "/packages/brushes/circle_64_soft.png"}, {"start": 7453153, "audio": 0, "end": 7454737, "filename": "/packages/brushes/circle_64_solid.png"}, {"start": 7454737, "audio": 0, "end": 7455733, "filename": "/packages/brushes/circle_8_hard.png"}, {"start": 7455733, "audio": 0, "end": 7456725, "filename": "/packages/brushes/circle_8_soft.png"}, {"start": 7456725, "audio": 0, "end": 7457720, "filename": "/packages/brushes/circle_8_solid.png"}, {"start": 7457720, "audio": 0, "end": 7457857, "filename": "/packages/brushes/gradient_128.png"}, {"start": 7457857, "audio": 0, "end": 7457960, "filename": "/packages/brushes/gradient_16.png"}, {"start": 7457960, "audio": 0, "end": 7458080, "filename": "/packages/brushes/gradient_32.png"}, {"start": 7458080, "audio": 0, "end": 7458209, "filename": "/packages/brushes/gradient_64.png"}, {"start": 7458209, "audio": 0, "end": 7467844, "filename": "/packages/brushes/noise_128.png"}, {"start": 7467844, "audio": 0, "end": 7470134, "filename": "/packages/brushes/noise_64.png"}, {"start": 7470134, "audio": 0, "end": 7470193, "filename": "/packages/brushes/readme.txt"}, {"start": 7470193, "audio": 0, "end": 7471275, "filename": "/packages/brushes/square_16_hard.png"}, {"start": 7471275, "audio": 0, "end": 7472248, "filename": "/packages/brushes/square_16_solid.png"}, {"start": 7472248, "audio": 0, "end": 7473431, "filename": "/packages/brushes/square_32_hard.png"}, {"start": 7473431, "audio": 0, "end": 7474412, "filename": "/packages/brushes/square_32_solid.png"}, {"start": 7474412, "audio": 0, "end": 7475619, "filename": "/packages/brushes/square_64_hard.png"}, {"start": 7475619, "audio": 0, "end": 7476625, "filename": "/packages/brushes/square_64_solid.png"}, {"start": 7476625, "audio": 0, "end": 7620369, "filename": "/packages/hud/damage.png"}, {"start": 7620369, "audio": 0, "end": 7725770, "filename": "/packages/hud/items.png"}, {"start": 7725770, "audio": 0, "end": 7747075, "filename": "/packages/hud/js.png"}, {"start": 7747075, "audio": 0, "end": 7747146, "filename": "/packages/hud/readme.txt"}, {"start": 7747146, "audio": 0, "end": 7768467, "filename": "/packages/hud/wasm.png"}], "remote_package_size": 7768467, "package_uuid": "202fa559-3202-44ad-b11a-4695b98ed59f"});

})();

