/ begin GS JavaScript
function getQueryParams(qs) {
    qs = qs.split("+").join(" ");
    var params = {}, tokens,
        re = /[?&]?([^=]+)=([^&]*)/g;
    while (tokens = re.exec(qs)) {
        params[decodeURIComponent(tokens[1])]
            = decodeURIComponent(tokens[2]);
    }
    return params;
}



var geneIdFileUrl = getQueryParams(window.location.search)['geneIdentifierUrl'];

if (geneIdFileUrl != null){
    var pathStartIdx = geneIdFileUrl.indexOf('datamanager/file');
    if (pathStartIdx > -1){
        var path = geneIdFileUrl.substring(pathStartIdx + 16);
        geneIdFileUrl = "https://gsui.genomespace.org/jsui/preview/file" + path;
    }
    var client = new XMLHttpRequest();
    client.withCredentials = true;
    client.open('GET', geneIdFileUrl, true );
    client.setRequestHeader("Content-Type", "text/plain");
    client.onreadystatechange = function() {
        document.getElementById('geneList').value = client.responseText;
    }
    client.send();
}


// end of GS JavaScript
