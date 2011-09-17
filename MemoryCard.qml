import QtQuick 1.0

import 'memorygame.js' as MemoryGame

Item {

    id: container

    width: 100
    height: 100

    property alias source : image.source
    property alias flipped : flick.flipped

    property int hideX : Math.random() > 0.5 ? 1 : -1
    property int hideY : Math.random() > 0.5 ? 1 : -1

    Behavior on x {
        NumberAnimation { duration: 1500 }
    }

    Behavior on y {
        NumberAnimation { duration: 1500 }
    }

    Timer {
        id: delayTimer
        onTriggered: {
            MemoryGame.openCard( parent );
        }
    }

    MouseArea {
        anchors.fill: parent
        onClicked: {
            parent.flipped = true;
            delayTimer.running = true;
        }
    }

    Flipable {

        id : flick

        property bool flipped: false

        width: parent.width
        height: parent.height

        back : Image {

            id : image

            width: parent.width
            height: parent.height

            scale: Image.PreserveAspectFit

        }

        front: Rectangle {

            color: 'pink'

            width: parent.width
            height: parent.height
        }

        transform: Rotation {
            id: rotation
            origin.x: flick.width/2
            origin.y: flick.height/2
            axis.x: 0; axis.y: 1; axis.z: 0
            angle: 0
        }

        states: State {
            name: "back"
            PropertyChanges { target: rotation; angle: 180 }
            when: flick.flipped
        }

        transitions: Transition {
            NumberAnimation { target: rotation; property: "angle"; duration: 750 }
        }

    }




}
