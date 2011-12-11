function random(max) {
    return Math.floor( Math.random() * max )
}

var GRID_SIZE = 8;

function init() {
    // clear data

    grid.clickCount = 0;
    grid.correctCount = 0;
    grid.card1 = grid.card2 = ''

    time.counter = 0;

    var cards = []

    for( var i = 0; i < grid.children.length; i++) {
        grid.children[i].destroy()
    }

    // select (random) images
    // todo: add randomness

    for(var i = 0; i < GRID_SIZE; i++) {

        var rdm = random( gallery.count )
        var url = gallery.get( rdm ).url

        var card1 = Qt.createComponent( "MemoryCard.qml" );
        var card2 = Qt.createComponent( "MemoryCard.qml" );

        card1 = card1.createObject( container );
        card2 = card2.createObject( container );

        card1.source = url;
        card2.source = url;

        cards.push( card1 );
        cards.push( card2 );

    }

    // randomize!
    // todo: clean me!
    cards.sort( function(a, b) { return Math.random() > 0.5 ? 1 : -1; } )

    cards.forEach( function(element) {
         element.parent = grid;
    } );

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
            a.x = b.x = a.hideX * appWindow.height;
            a.y = b.y = a.hideY * appWindow.width;
            resultDisplay.source = a.source
            resultDisplayAnimation.running = true;

            grid.correctCount++;

        } else {
            // hide stuff!
            a.flipped = b.flipped = false
        }
    }

}
