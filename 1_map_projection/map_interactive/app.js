var exifData;
var markers = [];
var markerCtr = 0;

var rotateInterval;

// RESET FILES NAMES !!!
var am1FileName = "";
var am2FileName = "";
var am3FileName = "";

var am1Marker;
var am2Marker;
var am3Marker;

L.mapbox.accessToken = 'pk.eyJ1IjoibGlzYWphbWhvdXJ5IiwiYSI6ImNpZzV4NHgzcTRrdHp0d2x2cHRvdjVhY3gifQ.ftTsm2W5PxBCE83mpl0w6Q';
// Construct a bounding box for this map that the user cannot
// move out of
var southWest = L.latLng(40.643516, -74.076719),
  northEast = L.latLng(40.811597, -73.890536),
  bounds = L.latLngBounds(southWest, northEast);

var map = L.mapbox.map('map', 'lisajamhoury.15f0ade8', {
  // set that bounding box as maxBounds to restrict moving the map
  // see full maxBounds documentation:
  // http://leafletjs.com/reference.html#map-maxbounds
  //maxBounds: bounds,
  // maxZoom: 13,
  // minZoom: 13
});

// zoom the map to that bounding box
map.fitBounds(bounds);

$.getJSON("../../0_exif_data/exif.json", function(json) {
  exifData = json;
  createMarkers(exifData);
});

window.addEventListener('load', init);

function init() {
  document.addEventListener("keypress", onKeyPress);
}

function onKeyPress(e) {
  e.preventDefault();

  if (e.key == '1') {
    rotateMarkers();
  }

  if (e.key == '2') {
    clearInterval(rotateInterval);
    am1Marker.openPopup();
  }

  if (e.key == '3') {
    clearInterval(rotateInterval);
    am2Marker.openPopup();
  }

  if (e.key == '4') {
    clearInterval(rotateInterval);
    am3Marker.openPopup();
  }

}


function createMarkers(data) {
  for (var key in data) {
    //console.log('key', data[key]);


    if (data[key].lat) {
      var marker = L.marker([data[key].lat, data[key].long]).addTo(map);
      var popUpText = "Latitude: " + String(data[key].lat) + "</br>" + "Longitude: " + String(data[key].long) + "</br>" + "Altitude: " + String(data[key].alt);
      marker.bindPopup(popUpText).openPopup();
      marker.filename = data[key].filename;
      markers.push(marker);

      if (data[key].filename == am1FileName) {
        am1Marker = marker;
      }

      if (data[key].filename == am2FileName) {
        am2Marker = marker;
      }

      if (data[key].filename == am3FileName) {
        am3Marker = marker;
      }

    } else { //catch not catching undefined
      console.log("no lat", data[key].filename);
    }
  }
  // console.log(markers);
}


function rotateMarkers() {
  rotateInterval = window.setInterval(function() {
    markers[markerCtr].openPopup();

    if (markerCtr >= markers.length - 1) {
      markerCtr = 0;
    } else {
      markerCtr++;
    }
  }, 2000);
}