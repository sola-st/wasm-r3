
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
    var PACKAGE_NAME = 'low.data';
    var REMOTE_PACKAGE_BASE = 'low.data';
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
Module['FS_createPath']('/packages', 'base', true, true);
Module['FS_createPath']('/packages', 'models', true, true);
Module['FS_createPath']('/packages/models', 'ffflag', true, true);
Module['FS_createPath']('/packages/models', 'ffpit', true, true);
Module['FS_createPath']('/packages', 'gk', true, true);
Module['FS_createPath']('/packages/gk', 'fantasy', true, true);
Module['FS_createPath']('/packages/gk/fantasy', 'skyfantasyJPG', true, true);
Module['FS_createPath']('/packages/gk/fantasy', 'castell_plaster_gk_v01', true, true);
Module['FS_createPath']('/packages/gk/fantasy', 'castell_wall_gk_v01', true, true);
Module['FS_createPath']('/packages/gk/fantasy', 'castell_wall_gk_v02', true, true);
Module['FS_createPath']('/packages/gk/fantasy', 'castell_wall_gk_v03', true, true);
Module['FS_createPath']('/packages/gk/fantasy', 'castell_wall_trim_gk_v01', true, true);
Module['FS_createPath']('/packages/gk/fantasy', 'iron_intersection_gk_v01', true, true);
Module['FS_createPath']('/packages/gk/fantasy', 'iron_plates_gk_v01', true, true);
Module['FS_createPath']('/packages/gk/fantasy', 'iron_trim_gk_v01', true, true);
Module['FS_createPath']('/packages/gk/fantasy', 'rock_formation_gk_v01', true, true);
Module['FS_createPath']('/packages/gk/fantasy', 'rock_formation_gk_v02', true, true);
Module['FS_createPath']('/packages/gk/fantasy', 'stone_ground_gk_v01', true, true);
Module['FS_createPath']('/packages/gk/fantasy', 'stone_ground_tiles_gk_v01', true, true);
Module['FS_createPath']('/packages/gk/fantasy', 'wooden_planks_gk_v01', true, true);
Module['FS_createPath']('/packages/gk/fantasy', 'wooden_roof_tiles_gk_v01', true, true);

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
              Module['removeRunDependency']('datafile_low.data');

    };
    Module['addRunDependency']('datafile_low.data');
  
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
 loadPackage({"files": [{"start": 0, "audio": 0, "end": 554042, "filename": "/packages/base/colos.ogz"}, {"start": 554042, "audio": 0, "end": 555197, "filename": "/packages/base/colos.cfg"}, {"start": 555197, "audio": 0, "end": 566661, "filename": "/packages/base/colos.wpt"}, {"start": 566661, "audio": 0, "end": 566913, "filename": "/packages/models/ffflag/md5.cfg"}, {"start": 566913, "audio": 0, "end": 1965169, "filename": "/packages/models/ffflag/ffflag_cc.dds"}, {"start": 1965169, "audio": 0, "end": 3363425, "filename": "/packages/models/ffflag/ffflag_nm.dds"}, {"start": 3363425, "audio": 0, "end": 4761681, "filename": "/packages/models/ffflag/ffflag_sc.dds"}, {"start": 4761681, "audio": 0, "end": 4785102, "filename": "/packages/models/ffflag/ffflag.md5mesh"}, {"start": 4785102, "audio": 0, "end": 4876857, "filename": "/packages/models/ffflag/ffflag.md5anim"}, {"start": 4876857, "audio": 0, "end": 4877137, "filename": "/packages/models/ffpit/md5.cfg"}, {"start": 4877137, "audio": 0, "end": 5226817, "filename": "/packages/models/ffpit/ffpit_01_gk_cc.dds"}, {"start": 5226817, "audio": 0, "end": 5576497, "filename": "/packages/models/ffpit/ffpit_01_gk_nm.dds"}, {"start": 5576497, "audio": 0, "end": 5926177, "filename": "/packages/models/ffpit/ffpit_01_gk_sc.dds"}, {"start": 5926177, "audio": 0, "end": 5971374, "filename": "/packages/models/ffpit/ffpit.md5mesh"}, {"start": 5971374, "audio": 0, "end": 6127820, "filename": "/packages/gk/fantasy/skyfantasyJPG/skyfantasy_bk.jpg"}, {"start": 6127820, "audio": 0, "end": 6313271, "filename": "/packages/gk/fantasy/skyfantasyJPG/skyfantasy_dn.jpg"}, {"start": 6313271, "audio": 0, "end": 6467106, "filename": "/packages/gk/fantasy/skyfantasyJPG/skyfantasy_ft.jpg"}, {"start": 6467106, "audio": 0, "end": 6616168, "filename": "/packages/gk/fantasy/skyfantasyJPG/skyfantasy_lf.jpg"}, {"start": 6616168, "audio": 0, "end": 6765607, "filename": "/packages/gk/fantasy/skyfantasyJPG/skyfantasy_rt.jpg"}, {"start": 6765607, "audio": 0, "end": 6848448, "filename": "/packages/gk/fantasy/skyfantasyJPG/skyfantasy_up.jpg"}, {"start": 6848448, "audio": 0, "end": 6848895, "filename": "/packages/gk/fantasy/castell_plaster_gk_v01/package.cfg"}, {"start": 6848895, "audio": 0, "end": 6849614, "filename": "/packages/gk/fantasy/castell_wall_gk_v01/package.cfg"}, {"start": 6849614, "audio": 0, "end": 6850333, "filename": "/packages/gk/fantasy/castell_wall_gk_v02/package.cfg"}, {"start": 6850333, "audio": 0, "end": 6851052, "filename": "/packages/gk/fantasy/castell_wall_gk_v03/package.cfg"}, {"start": 6851052, "audio": 0, "end": 6851851, "filename": "/packages/gk/fantasy/castell_wall_trim_gk_v01/package.cfg"}, {"start": 6851851, "audio": 0, "end": 6852310, "filename": "/packages/gk/fantasy/iron_intersection_gk_v01/package.cfg"}, {"start": 6852310, "audio": 0, "end": 6853012, "filename": "/packages/gk/fantasy/iron_plates_gk_v01/package.cfg"}, {"start": 6853012, "audio": 0, "end": 6853684, "filename": "/packages/gk/fantasy/iron_trim_gk_v01/package.cfg"}, {"start": 6853684, "audio": 0, "end": 6854108, "filename": "/packages/gk/fantasy/package.cfg"}, {"start": 6854108, "audio": 0, "end": 6854547, "filename": "/packages/gk/fantasy/rock_formation_gk_v01/package.cfg"}, {"start": 6854547, "audio": 0, "end": 6854986, "filename": "/packages/gk/fantasy/rock_formation_gk_v02/package.cfg"}, {"start": 6854986, "audio": 0, "end": 6855409, "filename": "/packages/gk/fantasy/stone_ground_gk_v01/package.cfg"}, {"start": 6855409, "audio": 0, "end": 6855880, "filename": "/packages/gk/fantasy/stone_ground_tiles_gk_v01/package.cfg"}, {"start": 6855880, "audio": 0, "end": 6856614, "filename": "/packages/gk/fantasy/wooden_planks_gk_v01/package.cfg"}, {"start": 6856614, "audio": 0, "end": 6857412, "filename": "/packages/gk/fantasy/wooden_roof_tiles_gk_v01/package.cfg"}, {"start": 6857412, "audio": 0, "end": 7207092, "filename": "/packages/gk/fantasy/rock_formation_gk_v01/rock_formation_gk_v01_cc.dds"}, {"start": 7207092, "audio": 0, "end": 7294628, "filename": "/packages/gk/fantasy/rock_formation_gk_v01/rock_formation_gk_v01_nm.dds"}, {"start": 7294628, "audio": 0, "end": 7382164, "filename": "/packages/gk/fantasy/castell_wall_gk_v01/castell_wall_gk_v01_cc.dds"}, {"start": 7382164, "audio": 0, "end": 7469700, "filename": "/packages/gk/fantasy/castell_wall_gk_v01/castell_wall_gk_v01_nm.dds"}, {"start": 7469700, "audio": 0, "end": 7557236, "filename": "/packages/gk/fantasy/castell_wall_gk_v02/castell_wall_gk_v02_cc.dds"}, {"start": 7557236, "audio": 0, "end": 7644772, "filename": "/packages/gk/fantasy/castell_wall_gk_v02/castell_wall_gk_v02_nm.dds"}, {"start": 7644772, "audio": 0, "end": 7688692, "filename": "/packages/gk/fantasy/castell_wall_trim_gk_v01/castell_wall_trim_gk_v01_cc.dds"}, {"start": 7688692, "audio": 0, "end": 7732612, "filename": "/packages/gk/fantasy/castell_wall_trim_gk_v01/castell_wall_trim_gk_v01_nm.dds"}, {"start": 7732612, "audio": 0, "end": 8082292, "filename": "/packages/gk/fantasy/stone_ground_tiles_gk_v01/stone_ground_tiles_gk_v01_cc.dds"}, {"start": 8082292, "audio": 0, "end": 8169828, "filename": "/packages/gk/fantasy/stone_ground_tiles_gk_v01/stone_ground_tiles_gk_v01_nm.dds"}, {"start": 8169828, "audio": 0, "end": 8257364, "filename": "/packages/gk/fantasy/wooden_planks_gk_v01/wooden_planks_gk_v01_cc.dds"}, {"start": 8257364, "audio": 0, "end": 8344900, "filename": "/packages/gk/fantasy/wooden_planks_gk_v01/wooden_planks_gk_v01_nm.dds"}, {"start": 8344900, "audio": 0, "end": 8432436, "filename": "/packages/gk/fantasy/castell_plaster_gk_v01/castell_plaster_gk_v01_cc.dds"}, {"start": 8432436, "audio": 0, "end": 8519972, "filename": "/packages/gk/fantasy/castell_plaster_gk_v01/castell_plaster_gk_v01_nm.dds"}, {"start": 8519972, "audio": 0, "end": 8694900, "filename": "/packages/gk/fantasy/iron_plates_gk_v01/iron_plates_gk_v01_cc.dds"}, {"start": 8694900, "audio": 0, "end": 8869828, "filename": "/packages/gk/fantasy/iron_plates_gk_v01/iron_plates_gk_v01_nm.dds"}, {"start": 8869828, "audio": 0, "end": 8913748, "filename": "/packages/gk/fantasy/iron_trim_gk_v01/iron_trim_gk_v01_cc.dds"}, {"start": 8913748, "audio": 0, "end": 8957668, "filename": "/packages/gk/fantasy/iron_trim_gk_v01/iron_trim_gk_v01_nm.dds"}, {"start": 8957668, "audio": 0, "end": 8979668, "filename": "/packages/gk/fantasy/iron_intersection_gk_v01/iron_intersection_gk_v01_cc.dds"}, {"start": 8979668, "audio": 0, "end": 9067204, "filename": "/packages/gk/fantasy/iron_intersection_gk_v01/iron_intersection_gk_v01_nm.dds"}], "remote_package_size": 9067204, "package_uuid": "80f23f1f-5c52-48a6-9bed-a94eeee61266"});

})();

