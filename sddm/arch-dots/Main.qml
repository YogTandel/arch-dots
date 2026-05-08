import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import QtQuick.Window 2.15

Rectangle {
    id: root

    width: Screen.width
    height: Screen.height

    readonly property color background: "#12140e"
    readonly property color surface: "#12140e"
    readonly property color surfaceContainer: "#1e2019"
    readonly property color surfaceContainerHigh: "#292b23"
    readonly property color primary: "#b5d086"
    readonly property color primaryContainer: "#384d12"
    readonly property color onPrimaryContainer: "#d1eca0"
    readonly property color secondaryContainer: "#414a32"
    readonly property color onSurface: "#e3e3d8"
    readonly property color onSurfaceVariant: "#c5c8b9"
    readonly property color outline: "#8f9285"
    readonly property color outlineVariant: "#45483d"
    readonly property color tertiary: "#a0d0c9"
    readonly property color tertiaryContainer: "#1f4e4a"
    readonly property color error: "#ffb4ab"

    property string userName: userNameField.text
    property string passwordText: passwordField.text
    property int sessionIndex: sessionBox.currentIndex >= 0 ? sessionBox.currentIndex : 0
    property string statusText: ""

    color: background

    function submitLogin() {
        if (userName.length === 0) {
            statusText = "Enter username";
            userNameField.focusInput();
            return;
        }

        statusText = "Checking credentials";
        sddm.login(userName, passwordText, sessionIndex);
    }

    Connections {
        target: sddm

        function onLoginSucceeded() {
            statusText = "Starting session";
        }

        function onLoginFailed() {
            passwordField.text = "";
            statusText = "Login failed";
            passwordField.focusInput();
        }
    }

    Timer {
        id: clockTimer
        interval: 1000
        running: true
        repeat: true
        onTriggered: {
            timeText.text = Qt.formatDateTime(new Date(), "hh:mm");
            dateText.text = Qt.formatDateTime(new Date(), "dddd, dd MMMM yyyy");
        }
    }

    LinearGradientRect {
        anchors.fill: parent
        startColor: "#0d0f09"
        midColor: "#12140e"
        endColor: "#1f4e4a"
    }

    Rectangle {
        width: parent.width * 0.72
        height: parent.height * 0.6
        x: parent.width * -0.14
        y: parent.height * -0.18
        radius: width
        color: Qt.rgba(primaryContainer.r, primaryContainer.g, primaryContainer.b, 0.18)
    }

    Rectangle {
        width: parent.width * 0.56
        height: parent.height * 0.5
        x: parent.width * 0.63
        y: parent.height * 0.62
        radius: width
        color: Qt.rgba(tertiaryContainer.r, tertiaryContainer.g, tertiaryContainer.b, 0.28)
    }

    Rectangle {
        anchors.fill: parent
        color: Qt.rgba(0, 0, 0, 0.18)
    }

    RowLayout {
        anchors {
            fill: parent
            leftMargin: Math.max(56, root.width * 0.07)
            rightMargin: Math.max(56, root.width * 0.07)
            topMargin: Math.max(42, root.height * 0.06)
            bottomMargin: Math.max(42, root.height * 0.06)
        }
        spacing: Math.max(48, root.width * 0.05)

        Item {
            Layout.fillWidth: true
            Layout.fillHeight: true
            Layout.minimumWidth: 420

            Column {
                anchors {
                    left: parent.left
                    verticalCenter: parent.verticalCenter
                }
                spacing: 22

                Text {
                    id: timeText
                    text: Qt.formatDateTime(new Date(), "hh:mm")
                    color: onSurface
                    font.family: "JetBrainsMono Nerd Font"
                    font.pixelSize: Math.min(132, Math.max(72, root.width * 0.068))
                    font.weight: Font.DemiBold
                }

                Text {
                    id: dateText
                    text: Qt.formatDateTime(new Date(), "dddd, dd MMMM yyyy")
                    color: Qt.rgba(onSurfaceVariant.r, onSurfaceVariant.g, onSurfaceVariant.b, 0.82)
                    font.family: "JetBrainsMono Nerd Font"
                    font.pixelSize: 18
                }

                Rectangle {
                    width: Math.min(430, root.width * 0.28)
                    height: 42
                    radius: 12
                    color: Qt.rgba(surfaceContainer.r, surfaceContainer.g, surfaceContainer.b, 0.7)
                    border.width: 1
                    border.color: Qt.rgba(outlineVariant.r, outlineVariant.g, outlineVariant.b, 0.45)

                    Row {
                        anchors {
                            fill: parent
                            leftMargin: 14
                            rightMargin: 14
                        }
                        spacing: 10

                        Text {
                            anchors.verticalCenter: parent.verticalCenter
                            text: "󰍹"
                            color: primary
                            font.family: "JetBrainsMono Nerd Font"
                            font.pixelSize: 15
                        }

                        Text {
                            anchors.verticalCenter: parent.verticalCenter
                            text: "Hyprland desktop"
                            color: onSurfaceVariant
                            font.family: "JetBrainsMono Nerd Font"
                            font.pixelSize: 12
                        }
                    }
                }
            }
        }

        Rectangle {
            Layout.preferredWidth: Math.min(430, Math.max(360, root.width * 0.25))
            Layout.maximumWidth: 460
            Layout.alignment: Qt.AlignVCenter
            implicitHeight: loginColumn.implicitHeight + 56
            radius: 18
            color: Qt.rgba(surfaceContainer.r, surfaceContainer.g, surfaceContainer.b, 0.86)
            border.width: 1
            border.color: Qt.rgba(outlineVariant.r, outlineVariant.g, outlineVariant.b, 0.65)

            Rectangle {
                anchors {
                    left: parent.left
                    right: parent.right
                    top: parent.top
                }
                height: 1
                color: Qt.rgba(1, 1, 1, 0.28)
            }

            ColumnLayout {
                id: loginColumn
                anchors {
                    left: parent.left
                    right: parent.right
                    top: parent.top
                    margins: 28
                }
                spacing: 16

                RowLayout {
                    Layout.fillWidth: true
                    spacing: 12

                    Rectangle {
                        Layout.preferredWidth: 48
                        Layout.preferredHeight: 48
                        radius: 14
                        color: primaryContainer

                        Text {
                            anchors.centerIn: parent
                            text: ""
                            color: onPrimaryContainer
                            font.family: "JetBrainsMono Nerd Font"
                            font.pixelSize: 24
                        }
                    }

                    ColumnLayout {
                        Layout.fillWidth: true
                        spacing: 2

                        Text {
                            text: "arch-dots"
                            color: onSurface
                            font.family: "JetBrainsMono Nerd Font"
                            font.pixelSize: 18
                            font.weight: Font.DemiBold
                        }

                        Text {
                            text: "Sign in"
                            color: onSurfaceVariant
                            font.family: "JetBrainsMono Nerd Font"
                            font.pixelSize: 11
                        }
                    }
                }

                LoginField {
                    id: userNameField
                    Layout.fillWidth: true
                    label: "User"
                    icon: ""
                    text: userModel.lastUser || ""
                    placeholder: "username"
                    echoMode: TextInput.Normal
                    KeyNavigation.tab: passwordField.inputItem
                    onAccepted: passwordField.focusInput()
                }

                LoginField {
                    id: passwordField
                    Layout.fillWidth: true
                    label: "Password"
                    icon: ""
                    placeholder: "password"
                    echoMode: TextInput.Password
                    KeyNavigation.tab: sessionBox
                    onAccepted: submitLogin()
                }

                ComboBox {
                    id: sessionBox
                    Layout.fillWidth: true
                    model: sessionModel
                    textRole: "name"
                    currentIndex: sessionModel.lastIndex >= 0 ? sessionModel.lastIndex : 0
                    font.family: "JetBrainsMono Nerd Font"
                    font.pixelSize: 11

                    background: Rectangle {
                        implicitHeight: 42
                        radius: 12
                        color: Qt.rgba(surfaceContainerHigh.r, surfaceContainerHigh.g, surfaceContainerHigh.b, 0.72)
                        border.width: 1
                        border.color: sessionBox.activeFocus ? Qt.rgba(primary.r, primary.g, primary.b, 0.75) : Qt.rgba(outlineVariant.r, outlineVariant.g, outlineVariant.b, 0.5)
                    }

                    contentItem: Text {
                        leftPadding: 14
                        rightPadding: 34
                        verticalAlignment: Text.AlignVCenter
                        text: sessionBox.displayText
                        color: onSurface
                        elide: Text.ElideRight
                        font: sessionBox.font
                    }

                    indicator: Text {
                        x: sessionBox.width - width - 14
                        y: sessionBox.topPadding + (sessionBox.availableHeight - height) / 2
                        text: "⌄"
                        color: primary
                        font.family: "JetBrainsMono Nerd Font"
                        font.pixelSize: 15
                    }

                    popup: Popup {
                        y: sessionBox.height + 6
                        width: sessionBox.width
                        implicitHeight: contentItem.implicitHeight
                        padding: 4

                        background: Rectangle {
                            radius: 12
                            color: surfaceContainer
                            border.width: 1
                            border.color: outlineVariant
                        }

                        contentItem: ListView {
                            clip: true
                            implicitHeight: contentHeight
                            model: sessionBox.popup.visible ? sessionBox.delegateModel : null
                            currentIndex: sessionBox.highlightedIndex
                        }
                    }
                }

                Button {
                    id: loginButton
                    Layout.fillWidth: true
                    implicitHeight: 44
                    text: "Login"
                    onClicked: submitLogin()

                    contentItem: Text {
                        text: loginButton.text
                        color: "#233600"
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        font.family: "JetBrainsMono Nerd Font"
                        font.pixelSize: 13
                        font.weight: Font.DemiBold
                    }

                    background: Rectangle {
                        radius: 12
                        color: loginButton.down ? Qt.darker(primary, 1.12) : primary
                    }
                }

                Text {
                    Layout.fillWidth: true
                    text: statusText
                    visible: statusText.length > 0
                    color: statusText === "Login failed" ? error : onSurfaceVariant
                    horizontalAlignment: Text.AlignHCenter
                    font.family: "JetBrainsMono Nerd Font"
                    font.pixelSize: 11
                }

                RowLayout {
                    Layout.fillWidth: true
                    Layout.topMargin: 4
                    spacing: 8

                    PowerButton {
                        label: "Sleep"
                        icon: ""
                        onClicked: sddm.suspend()
                    }

                    PowerButton {
                        label: "Restart"
                        icon: ""
                        onClicked: sddm.reboot()
                    }

                    PowerButton {
                        label: "Power"
                        icon: ""
                        onClicked: sddm.powerOff()
                    }
                }
            }
        }
    }

    Text {
        anchors {
            left: parent.left
            leftMargin: 24
            bottom: parent.bottom
            bottomMargin: 18
        }
        text: sddm.hostName
        color: Qt.rgba(onSurfaceVariant.r, onSurfaceVariant.g, onSurfaceVariant.b, 0.55)
        font.family: "JetBrainsMono Nerd Font"
        font.pixelSize: 11
    }

    component LinearGradientRect: Item {
        property color startColor: "#000000"
        property color midColor: "#121212"
        property color endColor: "#222222"

        Rectangle {
            anchors.fill: parent
            gradient: Gradient {
                orientation: Gradient.Vertical
                GradientStop { position: 0.0; color: startColor }
                GradientStop { position: 0.55; color: midColor }
                GradientStop { position: 1.0; color: endColor }
            }
        }
    }

    component LoginField: Item {
        id: fieldRoot

        property alias text: input.text
        property alias echoMode: input.echoMode
        property alias inputItem: input
        property string label: ""
        property string icon: ""
        property string placeholder: ""
        signal accepted

        implicitHeight: 64

        Text {
            id: fieldLabel
            anchors {
                left: parent.left
                top: parent.top
            }
            text: fieldRoot.label
            color: onSurfaceVariant
            font.family: "JetBrainsMono Nerd Font"
            font.pixelSize: 10
        }

        Rectangle {
            anchors {
                left: parent.left
                right: parent.right
                bottom: parent.bottom
            }
            height: 42
            radius: 12
            color: Qt.rgba(surfaceContainerHigh.r, surfaceContainerHigh.g, surfaceContainerHigh.b, 0.72)
            border.width: 1
            border.color: input.activeFocus ? Qt.rgba(primary.r, primary.g, primary.b, 0.75) : Qt.rgba(outlineVariant.r, outlineVariant.g, outlineVariant.b, 0.5)

            Text {
                anchors {
                    left: parent.left
                    leftMargin: 13
                    verticalCenter: parent.verticalCenter
                }
                text: fieldRoot.icon
                color: input.activeFocus ? primary : onSurfaceVariant
                font.family: "JetBrainsMono Nerd Font"
                font.pixelSize: 13
            }

            TextInput {
                id: input
                anchors {
                    left: parent.left
                    leftMargin: 38
                    right: parent.right
                    rightMargin: 14
                    verticalCenter: parent.verticalCenter
                }
                height: 22
                color: onSurface
                selectionColor: primaryContainer
                selectedTextColor: onPrimaryContainer
                verticalAlignment: TextInput.AlignVCenter
                clip: true
                font.family: "JetBrainsMono Nerd Font"
                font.pixelSize: 12
                onAccepted: fieldRoot.accepted()

                Text {
                    anchors.fill: parent
                    visible: input.text.length === 0 && !input.activeFocus
                    text: fieldRoot.placeholder
                    color: Qt.rgba(onSurfaceVariant.r, onSurfaceVariant.g, onSurfaceVariant.b, 0.45)
                    verticalAlignment: Text.AlignVCenter
                    font: input.font
                }
            }
        }

        function focusInput() {
            input.forceActiveFocus();
        }
    }

    component PowerButton: Button {
        id: powerButton

        property string label: ""
        property string icon: ""

        Layout.fillWidth: true
        implicitHeight: 38

        contentItem: Row {
            spacing: 6
            anchors.centerIn: parent

            Text {
                text: powerButton.icon
                color: powerButton.down ? onPrimaryContainer : onSurfaceVariant
                font.family: "JetBrainsMono Nerd Font"
                font.pixelSize: 12
            }

            Text {
                text: powerButton.label
                color: powerButton.down ? onPrimaryContainer : onSurfaceVariant
                font.family: "JetBrainsMono Nerd Font"
                font.pixelSize: 10
            }
        }

        background: Rectangle {
            radius: 11
            color: powerButton.down ? primaryContainer : Qt.rgba(surfaceContainerHigh.r, surfaceContainerHigh.g, surfaceContainerHigh.b, 0.54)
            border.width: 1
            border.color: Qt.rgba(outlineVariant.r, outlineVariant.g, outlineVariant.b, 0.45)
        }
    }

    Component.onCompleted: {
        clockTimer.triggered();
        if (userNameField.text.length > 0)
            passwordField.focusInput();
        else
            userNameField.focusInput();
    }
}
