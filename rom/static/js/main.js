var currentVolume = null;
var currentSong = null;

function init() {
    var control = $('.vol-container');
    var info = $('.info');

    control.hide();
    info.hide();

    getStatus();
    setInterval(getStatus, 2500);
}


function updateMetadata() {
    $.ajax('/api/info/metadata').done(function(metadata) {
        var blur = $('#blur');
        var albumCover = $('#album-cover');

        //Temporary fix until better error checking is added server side
        if (metadata.track_uri === '') {
            albumCover.css("background-color", "#1ed760");
            return;
        }

        albumCover.show();

        blur.css("background-image", "url(/api/info/image_url/"+ metadata.cover_uri+")");
        albumCover.css("background-color", "transparent");
        albumCover.css("background-image", "url(/api/info/image_url/"+ metadata.cover_uri+")");
    
        changeVolume(metadata.volume / 655.35)
        changeSongData(metadata);

    }).fail(function(jqXHR, textStatus, error) {
        console.log("Request failed: " + error);
    });
}
function changeSongData(metadata) {
    var info = $('.info');
    var track = $('#trackInfo');
    var artist = $('#artistInfo');
    
    track.attr('data-id', metadata.track_uri);
    track.text(metadata.track_name);

    artist.attr('data-id', metadata.artist_uri);
    artist.text(metadata.artist_name);
    
    if (currentSong === null) {
        currentSong = metadata.track_uri
    } else if (currentSong !== metadata.track_uri) {
        currentSong = metadata.track_uri
        info.fadeIn(1000).delay(5000).fadeOut(1000);
    } else {
        //info.fadeOut(1000)
    }

}
function changeVolume(volume) {
    var control = $('.vol-container');
    var off = $('.vol-container .fa-volume-off');
    var low = $('.vol-container .fa-volume-down');
    var high = $('.vol-container .fa-volume-up');
    var active = $('#vol .active');

    off.hide();
    low.hide();
    high.hide();
    if (currentVolume === null) {
        currentVolume = volume;
    } else if (currentVolume !== volume) {
        currentVolume = volume;
        if (volume === 0) {
            off.show()
        } else if (volume <= 25) {
            low.show()
        } else {
            high.show()
        }
        control.fadeIn(1000,function() {
            active.css("width", volume+"%");
        })
    } else {
        control.fadeOut();
    }
}
function getStatus() {
    $.ajax('/api/info/status').done(function(data) {
        if (data.logged_in) {
            updateMetadata();
        } else if (!data.logged_in) {

        }
    }).fail(function(jqXHR, textStatus, error) {
        console.log("Request failed: " + error);
    });
}

init()