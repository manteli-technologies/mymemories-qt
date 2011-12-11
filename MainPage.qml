import QtQuick 1.1
import com.meego 1.0

import QtMobility.gallery 1.1

import 'memorygame.js' as MemoryGame

Page {
    id: mainPage

    orientationLock: PageOrientation.LockPortrait

    Label {
        text : 'My Memories'
        anchors.top: parent.top
        anchors.topMargin: 10

        anchors.horizontalCenter: parent.horizontalCenter
    }

    /*Button {

        text : 'Again'

        anchors.centerIn: parent

        visible: grid.correctCount == grid.children.length / 2

        onClicked: MemoryGame.init()

    }*/

    BusyIndicator {
        id: loading
        running: grid.children.length / 2 < MemoryGame.GRID_SIZE
        visible: running
        implicitWidth: 96
        anchors.centerIn: parent
    }

    Label {
        id : time

        property int counter: 0

        anchors.bottom: grid.top
        anchors.horizontalCenter: grid.horizontalCenter

        text: '0:00'

        visible: ! loading.visible

        onCounterChanged: {
            // calc sec mins represntation
            var mins = parseInt( counter / 60 )
            var secs = counter - 60 * mins
            if( secs < 10 ) secs = '0' + secs
            text = mins + ':' + secs
        }
    }

    Timer {
        running: grid.correctCount < grid.children.length / 2
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

        anchors.centerIn: parent

        property int clickCount: 0
        property int correctCount: 0

        property variant card1 : ''
        property variant card2 : ''
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
