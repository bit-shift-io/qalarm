import QtQuick 2.11
import "JsonPath.js" as JSONPath

Item {
    property string source: ""
    property string json: ""
    property string query: ""

    property ListModel model : ListModel { id: jsonModel }
    property alias count: jsonModel.count

    Component.onCompleted: {
        console.log(json);
        console.log(count);
    }

    onSourceChanged: {
        var xhr = new XMLHttpRequest;
        xhr.open("GET", source);
        console.log(xhr)
        xhr.onreadystatechange = function() {
            if (xhr.readyState == XMLHttpRequest.DONE)
                json = xhr.responseText;
        }
        xhr.send();
    }

    onJsonChanged: updateJSONModel()
    onQueryChanged: updateJSONModel()

    function updateJSONModel() {
        console.log("update model")
        console.log(json)
        jsonModel.clear();

        if ( json === "" )
            return;

        var objectArray = parseJSONString(json, query);
        for ( var key in objectArray ) {
            var jo = objectArray[key];

            // support for arrays
            if( jo.toString() === "[object Object]"){
                jsonModel.append( jo );
            } else {
                //this is comma separated strings
                var str = jo.toString().split(",");
                for(var i = 0; i < str.length; i++){
                    jsonModel.append({ "item": str[i] } );
                }
                break;
            }
            // end support for arrays
            //jsonModel.append( jo );
        }
    }

    function parseJSONString(jsonString, jsonPathQuery) {
        var objectArray = JSON.parse(jsonString);
        if ( jsonPathQuery !== "" )
            objectArray = JSONPath.jsonPath(objectArray, jsonPathQuery);

        return objectArray;
    }
}
