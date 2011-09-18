import QtQuick 1.1
import com.meego 1.0

import QtMobility.gallery 1.1

import 'memorygame.js' as MemoryGame

Page {
    id: mainPage

    ProgressBar {

        id : progressBar

        indeterminate : true

        anchors.centerIn: parent

        visible: grid.children.width == 0

    }

    DocumentGalleryModel {
        id: gallery
        rootType: DocumentGallery.Image
        properties: [ "url" ]

        onProgressChanged: {
            console.log('Foobaa! ' + progress);
            if( progress == 1 ) {
                console.log("OK done!");
                MemoryGame.foo(gallery, grid);
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
