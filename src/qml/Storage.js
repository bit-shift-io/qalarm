/**
 * https://askubuntu.com/questions/275953/saving-user-settings-in-qml-js
 * https://qmlbook.github.io/ch13-storage/storage.html
 * 
 * import QtQuick.LocalStorage 2.0
 * import "storage.js" as Settings
 * 
 * Settings.get("setting_name",8)
 * Settings.set("setting_name", itemid.property)
 * 
 **/

var config = {
    identifier: "alarm",
    version: "0.1",
    description: "alarm database",
    db_timeout: 100,
}

/*
query = {
    create_table: 'CREATE TABLE IF NOT EXISTS settings(key TEXT PRIMARY KEY, value TEXT);',
}
*/

/* create the necessary tables */
function init_database() {
    var db = get_database();
    db.transaction( 
        function(tx) {
            print('... create table')
            tx.executeSql('CREATE TABLE IF NOT EXISTS data(name TEXT, value TEXT)');
            tx.executeSql('CREATE TABLE IF NOT EXISTS configuration(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, value TEXT)');
    });
}


function get_database() {
    return LocalStorage.openDatabaseSync(config.identifier, config.version, config.description, config.db_timeout);
}

function set(setting, value) {
    var db = get_database();
    var res = "";
    db.transaction(function(tx) {
        tx.executeSql('CREATE TABLE IF NOT EXISTS settings(setting TEXT UNIQUE, value TEXT)');
        var rs = tx.executeSql('INSERT OR REPLACE INTO settings VALUES (?,?);', [setting,value]);
        if (rs.rowsAffected > 0) {
            res = "OK";
        } else {
            res = "Error";
        }
    }
    );
    return res;
}

function get(setting, default_value) {
    var db = get_database();
    var res= "";
    try {
        db.transaction(function(tx) {
            var rs = tx.executeSql('SELECT value FROM settings WHERE setting=?;', [setting]);
            if (rs.rows.length > 0) {
                res = rs.rows.item(0).value;
            } else {
                res = default_value;
            }
        })
    } catch (err) {
        //console.log("Database " + err);
        res = default_value;
    };
    return res
}