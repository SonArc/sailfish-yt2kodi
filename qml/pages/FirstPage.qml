/*
  Copyright (C) 2013 Jolla Ltd.
  Contact: Thomas Perl <thomas.perl@jollamobile.com>
  All rights reserved.

  You may use this file under the terms of BSD license as follows:

  Redistribution and use in source and binary forms, with or without
  modification, are permitted provided that the following conditions are met:
    * Redistributions of source code must retain the above copyright
      notice, this list of conditions and the following disclaimer.
    * Redistributions in binary form must reproduce the above copyright
      notice, this list of conditions and the following disclaimer in the
      documentation and/or other materials provided with the distribution.
    * Neither the name of the Jolla Ltd nor the
      names of its contributors may be used to endorse or promote products
      derived from this software without specific prior written permission.

  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
  ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
  WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
  DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDERS OR CONTRIBUTORS BE LIABLE FOR
  ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
  (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
  LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
  ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*/

import QtQuick 2.0
import Sailfish.Silica 1.0


Page {
    id: page

    function playData() {
        var xmlhttp = new XMLHttpRequest();
        var url = 'http://192.168.1.101:9090/jsonrpc';

        var ytUrl = yturl.text;
        var vidID = ytUrl.split( "=" );

        var jsonData = {"jsonrpc": "2.0", "params": {"item": {"file": "plugin://plugin.video.youtube/?action=play_video&videoid=" + vidID[1] + ""}}, "method": "Player.Open", "id": "libPlayer"}
        var jsonRequest = "request=" + JSON.stringify(jsonData);

  //      xmlhttp.onreadystatechange=function() {
  //          if (xmlhttp.readyState == XMLHttpRequest.DONE && xmlhttp.status == 200) {
  //              myFunction(xmlhttp.responseText);
  //          }
  //      }
        xmlhttp.open("POST", url, true);
        xmlhttp.setRequestHeader("Content-Type", "application/json");
        xmlhttp.send(jsonRequest);
        console.log("ok - ", jsonRequest);
    }



    // To enable PullDownMenu, place our content in a SilicaFlickable
    SilicaFlickable {
        anchors.fill: parent

        // PullDownMenu and PushUpMenu must be declared in SilicaFlickable, SilicaListView or SilicaGridView
        PullDownMenu {
            MenuItem {
                text: qsTr("Settings")
                onClicked: pageStack.push(Qt.resolvedUrl("Settings.qml"))
            }
                MenuItem {
                    text: qsTr("About")
                    onClicked: pageStack.push(Qt.resolvedUrl("About.qml"))
                }
                MenuItem {
                    text: qsTr("Youtube")
                    onClicked: pageStack.push(Qt.resolvedUrl("WebView.qml"))
                }
        }

        // Tell SilicaFlickable the height of its content.
        contentHeight: column.height

        // Place our content in a Column.  The PageHeader is always placed at the top
        // of the page, followed by our content.
        Column {
            id: column

            width: page.width
            spacing: Theme.paddingLarge
            PageHeader {
            title: qsTr("yt2kodi")
            }
            TextField {
                id: "yturl"
                focus: true
                label: "Youtube URL"
                placeholderText: label
                width: parent.width
      //         horizontalAlignment: textAlignment
      //         EnterKey.onClicked: passwordField.focus = true
            }
            Row {
                spacing: Theme.paddingLarge
                anchors.horizontalCenter: parent.horizontalCenter


                Button {
                    id: "play"
                    text: "Play"
                    onClicked: {playData(yturl.text);
                                yturl.text = "";
                               }
                }
                Button {
                    id: "queue"
                    text: "Queue"
             //       onClicked: queueData(yturl.text);
                }
            }
        }
    }
}
