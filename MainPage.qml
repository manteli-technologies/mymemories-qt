import QtQuick 1.1
import com.meego 1.0

import QtMobility.gallery 1.1

import 'memorygame.js' as MemoryGame

Page {
    id: mainPage

    Text {
        id : time

        property int counter: 0

        onCounterChanged: {
            text = counter
        }
    }

    Timer {
        running: true
        interval: 1000
        repeat: true
        onTriggered: {
            time.counter++;
        }
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

    Image {
        id : resultDisplay

        fillMode: Image.PreserveAspectFit

        width: 1

        visible: width > 10

        property int maxWidth: parent.width - 50

        anchors.centerIn: parent

    }

    SequentialAnimation {
        id: resultDisplayAnimation
        NumberAnimation { target: resultDisplay; property: "width"; to: resultDisplay.maxWidth; duration: 1000 }
        NumberAnimation { target: resultDisplay; property: "width"; to: 1; duration: 1000 }
    }

}
