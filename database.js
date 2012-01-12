.pragma library

function init() {
    var db = openDatabaseSync("database", "1.0", "Application database", 1000000);
    return db;
}

function createTable( db, table ) {
    db.transaction( function(tx) {
         tx.executeSql('CREATE TABLE IF NOT EXISTS ' + table )
    } )
}

function select( db, table, callback ) {
    db.transaction( function(tx) {
         results = tx.executeSql('SELECT * FROM ' + table);
    } )
}

function insert( db , table, values ) {
    db.transaction( function(tx) {
                       joined = values.join( ',' );
                       joined = '(' + joined + ')';
                       tx.executeSql('INSERT INTO ' + table + ' VALUES ' + joined );
    } )
}
