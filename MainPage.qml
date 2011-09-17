import QtQuick 1.1
import com.meego 1.0

import QtMobility.gallery 1.1

import 'memorygame.js' as MemoryGame

Page {
    id: mainPage

    Button {

        width: 50
        height: 50

        text: 'Press me'

        anchors.centerIn: parent

        onClicked: MemoryGame.foo(gallery, grid);

    }

    DocumentGalleryModel {
        id: gallery
        rootType: DocumentGallery.Image
        properties: [ "url" ]

        Component.onCompleted: {
            MemoryGame.foo(gallery, grid)
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
