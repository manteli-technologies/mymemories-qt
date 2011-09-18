import QtQuick 1.1
import com.meego 1.0

import QtMobility.gallery 1.1

import 'memorygame.js' as MemoryGame

Page {
    id: mainPage

    BusyIndicator {

        id : progressBar

        // TODO: harcoded shit
        implicitWidth: 96

        anchors.centerIn: parent

        running: true
        visible: gallery.progress < 1

    }

    DocumentGalleryModel {
        id: gallery
        rootType: DocumentGallery.Image
        properties: [ "url" ]

        onProgressChanged: {
            if( progress == 1 ) {
                MemoryGame.init()
            }
        }


    }

    Item {

        id : container

        visible: false

    }

    Grid {

        id: grid

        spacing: 10

        property int clickCount: 0
        property variant card1 : ''
        property variant card2 : ''

        anchors.centerIn: parent
    }

}
