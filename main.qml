import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.12

Window {
    width: 640
    height: 480
    visible: true
    title: qsTr("Chat Client")

    Connections{
        target: client
        function onNewMessage(baMessage){
            listModelMessages.append({message: baMessage + ""})
        }
    }

    ColumnLayout{
        anchors.fill: parent    //Fill area of texts as wide as window panel
        RowLayout{
            TextField{
                id: textFieldIp
                placeholderText: qsTr("Server IP: ")
                Layout.fillWidth: true
                onAccepted: buttonSend.clicked()
            }
            TextField{
                id: textFieldPort
                placeholderText: qsTr("Server Port: ")
                Layout.fillWidth: true
                onAccepted: buttonConnect.clicked()
            }
            Button{
                id: buttonConnect
                text: qsTr("Connect")
                onClicked: {


                }
            }
        }
        ListView{               //List messages
            Layout.fillHeight: true
            Layout.fillWidth: true
            clip: true
            model: ListModel{
                id: listModelMessages
                ListElement{
                    message: "Welcome to the Client!"
                }
            }
            delegate: ItemDelegate{
                text: message
            }
            ScrollBar.vertical: ScrollBar{}
        }
        RowLayout{
            TextField{
                id: textFieldMessage
                placeholderText: qsTr("Enter a message...")
                Layout.fillWidth: true
                onAccepted: buttonSend.clicked()
            }
            Button{
                id: buttonSend
                text: qsTr("Send")
                onClicked: {
                    client.sendMessage(textFieldMessage.text)
                    textFieldMessage.clear()
                }
            }
        }
    }
}
