function foo(gallery, grid) {

    var imgs = []

    for(var i = 0; i < gallery.count; i++) {

        var url = gallery.get(i).url

        var u1 = Qt.createComponent( "MemoryCard.qml" );
        var u2 = Qt.createComponent( "MemoryCard.qml" );

        u1 = u1.createObject( container );
        u2 = u2.createObject( container );

        u1.source = url;
        u2.source = url;

        imgs.push( u1 );
        imgs.push( u2 );

        console.log( imgs.lengtha s )

    }

    // randomize!
    imgs.sort( function(a, b) { return Math.random() > 0.5 ? 1 : -1; } )

    for(var j = 0; j < imgs.length; j++ ) {
        var a = imgs[j];
        a.parent = grid;
    }

}

function openCard( card ) {

    if( grid.clickCount % 2 == 0 ) {
        grid.card1 = card;
    } else {
        grid.card2 = card;
    }

    // add number of clicks!
    grid.clickCount++;
    grid.clickCount = grid.clickCount % 2;

    if( grid.clickCount == 0 ) {

        var a = grid.card1;
        var b = grid.card2;

        if( a.source == b.source ) {
            // move objects
            a.x = a.hideX * appWindow.height;
            a.y = a.hideY * appWindow.width;
            b.x = b.hideX * appWindow.height;
            b.y = b.hideY * appWindow.height;
        } else {
            // hide stuff!
            a.flipped = b.flipped = false
        }
    }

}
