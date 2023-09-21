
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
    var PACKAGE_NAME = 'character.data';
    var REMOTE_PACKAGE_BASE = 'character.data';
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
Module['FS_createPath']('/', 'packages', true, true);
Module['FS_createPath']('/packages', 'models', true, true);
Module['FS_createPath']('/packages/models', 'vwep', true, true);
Module['FS_createPath']('/packages/models/vwep', 'chaing', true, true);
Module['FS_createPath']('/packages/models/vwep', 'gl', true, true);
Module['FS_createPath']('/packages/models/vwep', 'rifle', true, true);
Module['FS_createPath']('/packages/models/vwep', 'rocket', true, true);
Module['FS_createPath']('/packages/models/vwep', 'shotg', true, true);
Module['FS_createPath']('/packages/models', 'snoutx10k', true, true);
Module['FS_createPath']('/packages/models/snoutx10k', 'hudguns', true, true);
Module['FS_createPath']('/packages/models/snoutx10k/hudguns', 'chaing', true, true);
Module['FS_createPath']('/packages/models/snoutx10k/hudguns', 'gl', true, true);
Module['FS_createPath']('/packages/models/snoutx10k/hudguns', 'rifle', true, true);
Module['FS_createPath']('/packages/models/snoutx10k/hudguns', 'rocket', true, true);
Module['FS_createPath']('/packages/models/snoutx10k/hudguns', 'shotg', true, true);
Module['FS_createPath']('/packages/models', 'hudguns', true, true);
Module['FS_createPath']('/packages/models/hudguns', 'chaing', true, true);
Module['FS_createPath']('/packages/models/hudguns', 'gl', true, true);
Module['FS_createPath']('/packages/models/hudguns', 'rifle', true, true);
Module['FS_createPath']('/packages/models/hudguns', 'rocket', true, true);
Module['FS_createPath']('/packages/models/hudguns', 'shotg', true, true);

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
              Module['removeRunDependency']('datafile_character.data');

    };
    Module['addRunDependency']('datafile_character.data');
  
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
 loadPackage({"files": [{"start": 0, "audio": 0, "end": 94, "filename": "/packages/models/vwep/readme.txt"}, {"start": 94, "audio": 0, "end": 276, "filename": "/packages/models/vwep/chaing/iqm.cfg"}, {"start": 276, "audio": 0, "end": 111196, "filename": "/packages/models/vwep/chaing/minigun_vwep.iqm"}, {"start": 111196, "audio": 0, "end": 194796, "filename": "/packages/models/vwep/gl/gl_vwep.iqm"}, {"start": 194796, "audio": 0, "end": 194968, "filename": "/packages/models/vwep/gl/iqm.cfg"}, {"start": 194968, "audio": 0, "end": 195168, "filename": "/packages/models/vwep/rifle/iqm.cfg"}, {"start": 195168, "audio": 0, "end": 297248, "filename": "/packages/models/vwep/rifle/sniper_vwep.iqm"}, {"start": 297248, "audio": 0, "end": 297402, "filename": "/packages/models/vwep/rocket/iqm.cfg"}, {"start": 297402, "audio": 0, "end": 378290, "filename": "/packages/models/vwep/rocket/rl_vwep.iqm"}, {"start": 378290, "audio": 0, "end": 378493, "filename": "/packages/models/vwep/shotg/iqm.cfg"}, {"start": 378493, "audio": 0, "end": 474277, "filename": "/packages/models/vwep/shotg/shotgun_vwep.iqm"}, {"start": 474277, "audio": 0, "end": 481033, "filename": "/packages/models/snoutx10k/lag.md5anim.iqm"}, {"start": 481033, "audio": 0, "end": 484062, "filename": "/packages/models/snoutx10k/anims.cfg"}, {"start": 484062, "audio": 0, "end": 542766, "filename": "/packages/models/snoutx10k/backward.md5anim.iqm"}, {"start": 542766, "audio": 0, "end": 553734, "filename": "/packages/models/snoutx10k/chainsaw_attack.md5anim.iqm"}, {"start": 553734, "audio": 0, "end": 560498, "filename": "/packages/models/snoutx10k/chainsaw_idle.md5anim.iqm"}, {"start": 560498, "audio": 0, "end": 567254, "filename": "/packages/models/snoutx10k/dead.md5anim.iqm"}, {"start": 567254, "audio": 0, "end": 574010, "filename": "/packages/models/snoutx10k/dead2.md5anim.iqm"}, {"start": 574010, "audio": 0, "end": 598082, "filename": "/packages/models/snoutx10k/dying.md5anim.iqm"}, {"start": 598082, "audio": 0, "end": 620730, "filename": "/packages/models/snoutx10k/dying2.md5anim.iqm"}, {"start": 620730, "audio": 0, "end": 627486, "filename": "/packages/models/snoutx10k/edit.md5anim.iqm"}, {"start": 627486, "audio": 0, "end": 689778, "filename": "/packages/models/snoutx10k/forward.md5anim.iqm"}, {"start": 689778, "audio": 0, "end": 696534, "filename": "/packages/models/snoutx10k/gl_idle.md5anim.iqm"}, {"start": 696534, "audio": 0, "end": 707450, "filename": "/packages/models/snoutx10k/gl_shoot.md5anim.iqm"}, {"start": 707450, "audio": 0, "end": 781474, "filename": "/packages/models/snoutx10k/idle.md5anim.iqm"}, {"start": 781474, "audio": 0, "end": 781856, "filename": "/packages/models/snoutx10k/iqm.cfg"}, {"start": 781856, "audio": 0, "end": 788612, "filename": "/packages/models/snoutx10k/jump.md5anim.iqm"}, {"start": 788612, "audio": 0, "end": 850904, "filename": "/packages/models/snoutx10k/left.md5anim.iqm"}, {"start": 850904, "audio": 0, "end": 867140, "filename": "/packages/models/snoutx10k/lose.md5anim.iqm"}, {"start": 867140, "audio": 0, "end": 925542, "filename": "/packages/models/snoutx10k/lower.jpg"}, {"start": 925542, "audio": 0, "end": 963964, "filename": "/packages/models/snoutx10k/lower_mask.jpg"}, {"start": 963964, "audio": 0, "end": 1032421, "filename": "/packages/models/snoutx10k/lower_normals.jpg"}, {"start": 1032421, "audio": 0, "end": 1039185, "filename": "/packages/models/snoutx10k/minigun_idle.md5anim.iqm"}, {"start": 1039185, "audio": 0, "end": 1050241, "filename": "/packages/models/snoutx10k/minigun_shoot.md5anim.iqm"}, {"start": 1050241, "audio": 0, "end": 1068157, "filename": "/packages/models/snoutx10k/pain.md5anim.iqm"}, {"start": 1068157, "audio": 0, "end": 1085233, "filename": "/packages/models/snoutx10k/pain2.md5anim.iqm"}, {"start": 1085233, "audio": 0, "end": 1108681, "filename": "/packages/models/snoutx10k/punch.md5anim.iqm"}, {"start": 1108681, "audio": 0, "end": 1112325, "filename": "/packages/models/snoutx10k/ragdoll.cfg"}, {"start": 1112325, "audio": 0, "end": 1112419, "filename": "/packages/models/snoutx10k/readme.txt"}, {"start": 1112419, "audio": 0, "end": 1172527, "filename": "/packages/models/snoutx10k/right.md5anim.iqm"}, {"start": 1172527, "audio": 0, "end": 1179283, "filename": "/packages/models/snoutx10k/rl_idle.md5anim.iqm"}, {"start": 1179283, "audio": 0, "end": 1190155, "filename": "/packages/models/snoutx10k/rl_shoot.md5anim.iqm"}, {"start": 1190155, "audio": 0, "end": 1201551, "filename": "/packages/models/snoutx10k/shoot.md5anim.iqm"}, {"start": 1201551, "audio": 0, "end": 1208315, "filename": "/packages/models/snoutx10k/shotgun_idle.md5anim.iqm"}, {"start": 1208315, "audio": 0, "end": 1219259, "filename": "/packages/models/snoutx10k/shotgun_shoot.md5anim.iqm"}, {"start": 1219259, "audio": 0, "end": 1234455, "filename": "/packages/models/snoutx10k/sink.md5anim.iqm"}, {"start": 1234455, "audio": 0, "end": 1241219, "filename": "/packages/models/snoutx10k/sniper_idle.md5anim.iqm"}, {"start": 1241219, "audio": 0, "end": 1252275, "filename": "/packages/models/snoutx10k/sniper_shoot.md5anim.iqm"}, {"start": 1252275, "audio": 0, "end": 1478835, "filename": "/packages/models/snoutx10k/snoutx10k.iqm"}, {"start": 1478835, "audio": 0, "end": 1496991, "filename": "/packages/models/snoutx10k/swim.md5anim.iqm"}, {"start": 1496991, "audio": 0, "end": 1525347, "filename": "/packages/models/snoutx10k/taunt.md5anim.iqm"}, {"start": 1525347, "audio": 0, "end": 1586012, "filename": "/packages/models/snoutx10k/upper.jpg"}, {"start": 1586012, "audio": 0, "end": 1625004, "filename": "/packages/models/snoutx10k/upper_mask.jpg"}, {"start": 1625004, "audio": 0, "end": 1681281, "filename": "/packages/models/snoutx10k/upper_normals.jpg"}, {"start": 1681281, "audio": 0, "end": 1698677, "filename": "/packages/models/snoutx10k/win.md5anim.iqm"}, {"start": 1698677, "audio": 0, "end": 1699159, "filename": "/packages/models/snoutx10k/hudguns/iqm.cfg"}, {"start": 1699159, "audio": 0, "end": 1836663, "filename": "/packages/models/snoutx10k/hudguns/snout_hands.iqm"}, {"start": 1836663, "audio": 0, "end": 1942460, "filename": "/packages/models/snoutx10k/hudguns/snout_hands.jpg"}, {"start": 1942460, "audio": 0, "end": 1962717, "filename": "/packages/models/snoutx10k/hudguns/snout_hands_mask.jpg"}, {"start": 1962717, "audio": 0, "end": 2023800, "filename": "/packages/models/snoutx10k/hudguns/snout_hands_normals.jpg"}, {"start": 2023800, "audio": 0, "end": 2023929, "filename": "/packages/models/snoutx10k/hudguns/chaing/iqm.cfg"}, {"start": 2023929, "audio": 0, "end": 2024054, "filename": "/packages/models/snoutx10k/hudguns/gl/iqm.cfg"}, {"start": 2024054, "audio": 0, "end": 2024182, "filename": "/packages/models/snoutx10k/hudguns/rifle/iqm.cfg"}, {"start": 2024182, "audio": 0, "end": 2024311, "filename": "/packages/models/snoutx10k/hudguns/rocket/iqm.cfg"}, {"start": 2024311, "audio": 0, "end": 2024439, "filename": "/packages/models/snoutx10k/hudguns/shotg/iqm.cfg"}, {"start": 2024439, "audio": 0, "end": 2024533, "filename": "/packages/models/hudguns/readme.txt"}, {"start": 2024533, "audio": 0, "end": 2115157, "filename": "/packages/models/hudguns/chaing/chaing.iqm"}, {"start": 2115157, "audio": 0, "end": 2115585, "filename": "/packages/models/hudguns/chaing/chaing_idle.iqm"}, {"start": 2115585, "audio": 0, "end": 2116057, "filename": "/packages/models/hudguns/chaing/chaing_shoot.iqm"}, {"start": 2116057, "audio": 0, "end": 2119125, "filename": "/packages/models/hudguns/chaing/hands_mg_idle.iqm"}, {"start": 2119125, "audio": 0, "end": 2122525, "filename": "/packages/models/hudguns/chaing/hands_mg_shoot.iqm"}, {"start": 2122525, "audio": 0, "end": 2123092, "filename": "/packages/models/hudguns/chaing/iqm.cfg"}, {"start": 2123092, "audio": 0, "end": 2271155, "filename": "/packages/models/hudguns/chaing/m134.jpg"}, {"start": 2271155, "audio": 0, "end": 2302744, "filename": "/packages/models/hudguns/chaing/m134_mask.jpg"}, {"start": 2302744, "audio": 0, "end": 2338811, "filename": "/packages/models/hudguns/chaing/m134_normals.jpg"}, {"start": 2338811, "audio": 0, "end": 2493683, "filename": "/packages/models/hudguns/gl/gl.iqm"}, {"start": 2493683, "audio": 0, "end": 2557621, "filename": "/packages/models/hudguns/gl/gl.jpg"}, {"start": 2557621, "audio": 0, "end": 2558129, "filename": "/packages/models/hudguns/gl/gl_idle.md5anim.iqm"}, {"start": 2558129, "audio": 0, "end": 2575939, "filename": "/packages/models/hudguns/gl/gl_mask.jpg"}, {"start": 2575939, "audio": 0, "end": 2611642, "filename": "/packages/models/hudguns/gl/gl_normals.jpg"}, {"start": 2611642, "audio": 0, "end": 2612234, "filename": "/packages/models/hudguns/gl/gl_shoot.md5anim.iqm"}, {"start": 2612234, "audio": 0, "end": 2615302, "filename": "/packages/models/hudguns/gl/hands_gl_idle.md5anim.iqm"}, {"start": 2615302, "audio": 0, "end": 2620050, "filename": "/packages/models/hudguns/gl/hands_gl_shoot.md5anim.iqm"}, {"start": 2620050, "audio": 0, "end": 2620533, "filename": "/packages/models/hudguns/gl/iqm.cfg"}, {"start": 2620533, "audio": 0, "end": 2623601, "filename": "/packages/models/hudguns/rifle/hands_rifle_idle.md5anim.iqm"}, {"start": 2623601, "audio": 0, "end": 2641429, "filename": "/packages/models/hudguns/rifle/hands_rifle_shoot.md5anim.iqm"}, {"start": 2641429, "audio": 0, "end": 2642024, "filename": "/packages/models/hudguns/rifle/iqm.cfg"}, {"start": 2642024, "audio": 0, "end": 2831728, "filename": "/packages/models/hudguns/rifle/rifle.iqm"}, {"start": 2831728, "audio": 0, "end": 2832324, "filename": "/packages/models/hudguns/rifle/rifle_idle.md5anim.iqm"}, {"start": 2832324, "audio": 0, "end": 2833468, "filename": "/packages/models/hudguns/rifle/rifle_shoot.md5anim.iqm"}, {"start": 2833468, "audio": 0, "end": 2931026, "filename": "/packages/models/hudguns/rifle/sniper.jpg"}, {"start": 2931026, "audio": 0, "end": 2959488, "filename": "/packages/models/hudguns/rifle/sniper_mask.jpg"}, {"start": 2959488, "audio": 0, "end": 3004969, "filename": "/packages/models/hudguns/rifle/sniper_normals.jpg"}, {"start": 3004969, "audio": 0, "end": 3008037, "filename": "/packages/models/hudguns/rocket/hands_rl_idle.md5anim.iqm"}, {"start": 3008037, "audio": 0, "end": 3011777, "filename": "/packages/models/hudguns/rocket/hands_rl_shoot.md5anim.iqm"}, {"start": 3011777, "audio": 0, "end": 3012436, "filename": "/packages/models/hudguns/rocket/iqm.cfg"}, {"start": 3012436, "audio": 0, "end": 3119148, "filename": "/packages/models/hudguns/rocket/rl.iqm"}, {"start": 3119148, "audio": 0, "end": 3224462, "filename": "/packages/models/hudguns/rocket/rl.jpg"}, {"start": 3224462, "audio": 0, "end": 3224970, "filename": "/packages/models/hudguns/rocket/rl_idle.md5anim.iqm"}, {"start": 3224970, "audio": 0, "end": 3250670, "filename": "/packages/models/hudguns/rocket/rl_mask.jpg"}, {"start": 3250670, "audio": 0, "end": 3293738, "filename": "/packages/models/hudguns/rocket/rl_normals.jpg"}, {"start": 3293738, "audio": 0, "end": 3294374, "filename": "/packages/models/hudguns/rocket/rl_shoot.md5anim.iqm"}, {"start": 3294374, "audio": 0, "end": 3297442, "filename": "/packages/models/hudguns/shotg/hands_shotgun_idle.md5anim.iqm"}, {"start": 3297442, "audio": 0, "end": 3308918, "filename": "/packages/models/hudguns/shotg/hands_shotgun_shoot.md5anim.iqm"}, {"start": 3308918, "audio": 0, "end": 3309660, "filename": "/packages/models/hudguns/shotg/iqm.cfg"}, {"start": 3309660, "audio": 0, "end": 3434252, "filename": "/packages/models/hudguns/shotg/shotgun.iqm"}, {"start": 3434252, "audio": 0, "end": 3536981, "filename": "/packages/models/hudguns/shotg/shotgun.jpg"}, {"start": 3536981, "audio": 0, "end": 3540701, "filename": "/packages/models/hudguns/shotg/shotgun_attack.md5anim.iqm"}, {"start": 3540701, "audio": 0, "end": 3541481, "filename": "/packages/models/hudguns/shotg/shotgun_idle.md5anim.iqm"}, {"start": 3541481, "audio": 0, "end": 3573257, "filename": "/packages/models/hudguns/shotg/shotgun_mask.jpg"}, {"start": 3573257, "audio": 0, "end": 3620360, "filename": "/packages/models/hudguns/shotg/shotgun_normals.jpg"}, {"start": 3620360, "audio": 0, "end": 3626058, "filename": "/packages/models/hudguns/shotg/shotgun_shell.jpg"}, {"start": 3626058, "audio": 0, "end": 3627968, "filename": "/packages/models/hudguns/shotg/shotgun_shell_mask.jpg"}, {"start": 3627968, "audio": 0, "end": 3629792, "filename": "/packages/models/hudguns/shotg/shotgun_shell_normals.jpg"}], "remote_package_size": 3629792, "package_uuid": "333e5e34-799f-4adf-b0d7-1971567dec5a"});

})();

