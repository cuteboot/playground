/*
 * Copyright (c) 2015, Robin Burchell <robin@viroteck.net>
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are met:
 *
 * * Redistributions of source code must retain the above copyright notice, this
 *   list of conditions and the following disclaimer.
 *
 * * Redistributions in binary form must reproduce the above copyright notice,
 *   this list of conditions and the following disclaimer in the documentation
 *   and/or other materials provided with the distribution.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
 * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
 * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
 * DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
 * FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
 * DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
 * SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
 * CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
 * OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
 * OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

import QtQuick 2.6

Rectangle {
    width: 1080
    height: 1920
    color: color50

    // TODO: some singleton or other
    property string color50:  "#e1f5fe" // black
    property string color100: "#b3e5fc" // black
    property string color200: "#81d4fa" // black
    property string color300: "#4fc3f7" // black
    property string color400: "#29b6f6" // black
    property string color500: "#03a9f4" // black
    property string color600: "#039be5" // white
    property string color700: "#0288d1" // white
    property string color800: "#0277bd" // white
    property string color900: "#01579b" // white
    property string colorTextPrimary: "#000000"
    property string colorTextSecondary: "#ffffff"

    Column {
        id: header
        height: 230
        width: parent.width
        z: 1000

        Rectangle {
            height: 200
            width: parent.width
            color: color500

            Text {
                anchors.fill: parent
                anchors.leftMargin: 40
                text: "CuteBoot"
                color: colorTextPrimary
                font.family: "Roboto"
                font.pixelSize: 100
                verticalAlignment: Text.AlignVCenter
            }
        }

        Rectangle {
            id: headerShadow
            height: 20
            width: parent.width

            gradient: Gradient {
                GradientStop { position: 0; color: Qt.rgba(0.2, 0.2, 0.2, 0.4); }
                GradientStop { position: 1; color: "transparent" }
            }
        }
    }

    ListView {
        id: view
        anchors.top: header.bottom
        anchors.topMargin: -(headerShadow.height + rowSeparatorHeight) * 1.5
        maximumFlickVelocity: height * 3
        flickDeceleration: height * 4
        width: parent.width
        anchors.bottom: parent.bottom

        property int rowSeparatorHeight: 3

        model: 100
        delegate: Rectangle {
            height: 150
            width: ListView.view.width
            color: delegateMouseArea.pressed ? color500 : color50

            MouseArea {
                id: delegateMouseArea
                anchors.fill: parent
            }

            Rectangle {
                width: parent.width
                color: color600
                height: view.rowSeparatorHeight
            }

            Text {
                anchors.centerIn: parent
                text: "Hello, world"
                color: colorTextPrimary
                font.family: "Roboto"
                font.pixelSize: 60
            }
        }
    }
}

