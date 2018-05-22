<#import "/spring.ftl" as spring />

<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">

    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.1/css/bootstrap.min.css"
          integrity="sha384-WskhaSGFgHYWDcbwN70/dfYBj47jz9qbsMId/iRN3ewGhXQFZCSftd1LZCfmhktB" crossorigin="anonymous">
    <link rel="stylesheet" href="/css/style.css">
    <title>Cafes</title>
</head>
<body>

<div id="map"></div>

<!-- Modal -->
<div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel"
     aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <form action="/create" method="POST">
                <div class="modal-body">
                    <p>You are about to create a cafe on this very spot.</p>
                    <div class="modal-line"><span class="modal-title">Title:</span> <input type="text" name="title">
                    </div>
                    <div class="modal-line"><span class="modal-title">Phone:</span> <input type="text" name="phone">
                    </div>
                    <div class="modal-line"><span class="modal-title">Site: </span> <input type="text" name="site">
                    </div>
                    <div class="modal-line"><span class="modal-title">Schedule: </span> <input type="text"
                                                                                               name="schedule"></div>
                    <input type="hidden" id="latitude" name="latitude"/>
                    <input type="hidden" id="longitude" name="longitude"/>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                    <button type="submit" class="btn btn-primary">Create</button>
                </div>
            </form>
        </div>
    </div>
</div>

<div class="modal fade" id="exampleModal2" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel"
     aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <form action="/edit" method="POST">
                <div class="modal-body">
                    <p>About the cafe:</p>
                    <input type="hidden" id="editId" name="id"/>
                    <div class="modal-line"><span class="modal-title">Title:</span> <input type="text" name="title"
                                                                                           id="editTitle"></div>
                    <div class="modal-line"><span class="modal-title">Phone:</span> <input type="text" name="phone"
                                                                                           id="editPhone"></div>
                    <div class="modal-line"><span class="modal-title">Site: </span> <input type="text" name="site"
                                                                                           id="editSite"></div>
                    <div class="modal-line"><span class="modal-title">Schedule: </span> <input type="text"
                                                                                               name="schedule"
                                                                                               id="editSchedule"></div>
                    <input type="hidden" id="editLatitude" name="latitude"/>
                    <input type="hidden" id="editLongitude" name="longitude"/>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                    <button type="submit" class="btn btn-primary">Edit</button>
                    <button type="submit" class="btn btn-primary" onclick="remove()" form="remForm">Remove</button>
                </div>
            </form>
        </div>
    </div>
</div>

<form action="/remove" method="POST" id="remForm" name="remForm">
    <input type="hidden" id="removeId" name="id"/>
</form>

<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"
        integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo"
        crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"
        integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49"
        crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.1/js/bootstrap.min.js"
        integrity="sha384-smHYKdLADwkXOn1EmN1qk/HfnUcbVRZyYmZ4qpPea6sjB/pTJ0euyQp0Mk8ck+5T"
        crossorigin="anonymous"></script>
<script async defer
        src="https://maps.googleapis.com/maps/api/js?key=AIzaSyBWVJ3mB7V93bGMP5ozS6R59zOC0qTY6BQ&callback=initialise">
</script>

<script>
    function remove() {
        document.getElementById("remForm").submit();
        //document.forms["remForm"].submit();
    }
    function createInfoWindowForCafe(cafe) {
        return new google.maps.InfoWindow({
            content: "<h1>" + cafe.title + "</h1><div>" + cafe.phone + "</div><div class ></div><button>Edit</button><button>Remove</button>"
        });
    }

    function initialise() {
        var cafes = ${model.cafes};

        var uluru = new google.maps.LatLng(cafes.length == 0 ? 0 : cafes[0].latitude, cafes.length == 0 ? 0 : cafes[0].longitude);
        var map = new google.maps.Map(document.getElementById('map'), {
            zoom: 4,
            center: uluru
        });

        cafes.forEach(function (cafe) {
            addMarker(cafe, map);
        });

        google.maps.event.addListener(map, 'click', function (event) {
            document.getElementById('latitude').value = event.latLng.lat();
            console.log("la = ", document.getElementById('latitude'), "v = ", event.latLng.lat())
            document.getElementById('longitude').value = event.latLng.lng();
            console.log("la = ", document.getElementById('longitude'), "v = ", event.latLng.lat())
            $('#exampleModal').modal();
            //createInfoWindowForCafe(cafe).open(map, marker);
            //emptyWindow(event.latLng);
        });
    }

    function addMarker(cafe, map) {
        var marker = new google.maps.Marker({
            position: new google.maps.LatLng(cafe.latitude, cafe.longitude),
            map: map,
            title: cafe.title
        });


        marker.addListener('click', function () {
            document.getElementById('editTitle').value = cafe.title;
            document.getElementById('editPhone').value = cafe.phone;
            document.getElementById('editSite').value = cafe.site;
            document.getElementById('editSchedule').value = cafe.schedule;
            document.getElementById('editLatitude').value = cafe.latitude;
            document.getElementById('editLongitude').value = cafe.longitude;
            document.getElementById('editId').value = cafe.id;
            document.getElementById('removeId').value = cafe.id;
            $('#exampleModal2').modal();
        });

        return marker;
    }
</script>
</body>
</html>