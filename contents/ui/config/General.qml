import QtQuick 2.15
import QtQuick.Layouts 1.15
import org.kde.kirigami 2.20 as Kirigami
import org.kde.plasma.components 3.0 as PlasmaComponents3

Kirigami.ScrollablePage {
    id: page
    title: "General"
    Kirigami.Theme.inherit: true
    Kirigami.Theme.colorSet: Kirigami.Theme.Window

    property alias cfg_endpointUrl: endpointUrlField.text
    property alias cfg_dataInterval: dataIntervalSpin.value
    property alias cfg_blinkNormalInterval: blinkNormalIntervalSpin.value
    property alias cfg_blinkWarningInterval: blinkWarningIntervalSpin.value
    property alias cfg_threshold1: threshold1Spin.value
    property alias cfg_threshold2: threshold2Spin.value
    property alias cfg_showIcon: showIconCheck.checked
    property alias cfg_displayFormat: displayFormatField.text
    property alias cfg_fontFamily: fontFamilyCombo.editText
    property alias cfg_fontPointSize: fontSizeSpin.value
    property alias cfg_iconWarning: iconWarningField.text
    property alias cfg_iconAlert: iconAlertField.text
    property alias cfg_iconNormal: iconNormalField.text

    Kirigami.FormLayout {
        width: page.width

        Kirigami.Heading {
            text: "Connection"
            level: 3
            font.bold: true
            Kirigami.FormData.isSection: true
            topPadding: Kirigami.Units.smallSpacing
            bottomPadding: Kirigami.Units.smallSpacing
        }

        PlasmaComponents3.TextField {
            id: endpointUrlField
            Kirigami.FormData.label: "Endpoint URL"
            placeholderText: "http://localhost:5605"
            Layout.fillWidth: true
            Layout.preferredWidth: Kirigami.Units.gridUnit * 24
            implicitHeight: Kirigami.Units.gridUnit * 2
            leftPadding: Kirigami.Units.smallSpacing
            rightPadding: Kirigami.Units.smallSpacing
            topPadding: Kirigami.Units.smallSpacing
            bottomPadding: Kirigami.Units.smallSpacing
            color: Kirigami.Theme.textColor
            background: Rectangle {
                color: Kirigami.Theme.backgroundColor
                border.color: Kirigami.Theme.disabledTextColor
                radius: 4
        }
            }

        Kirigami.Heading {
            text: "Timing"
            level: 3
            font.bold: true
            Kirigami.FormData.isSection: true
            topPadding: Kirigami.Units.smallSpacing
            bottomPadding: Kirigami.Units.smallSpacing
        }

        PlasmaComponents3.SpinBox {
            id: dataIntervalSpin
            Kirigami.FormData.label: "Update interval (ms)"
            from: 100
            to: 600000
            stepSize: 500
            Layout.fillWidth: true
            implicitHeight: Kirigami.Units.gridUnit * 2
            background: Rectangle {
                color: Kirigami.Theme.backgroundColor
                border.color: Kirigami.Theme.disabledTextColor
                radius: 4
        }
            }

        PlasmaComponents3.SpinBox {
            id: blinkNormalIntervalSpin
            Kirigami.FormData.label: "Blink interval normal (ms)"
            from: 100
            to: 10000
            stepSize: 50
            Layout.fillWidth: true
            implicitHeight: Kirigami.Units.gridUnit * 2
            background: Rectangle {
                color: Kirigami.Theme.backgroundColor
                border.color: Kirigami.Theme.disabledTextColor
                radius: 4
        }
            }

        PlasmaComponents3.SpinBox {
            id: blinkWarningIntervalSpin
            Kirigami.FormData.label: "Blink interval warning (ms)"
            from: 100
            to: 10000
            stepSize: 50
            Layout.fillWidth: true
            implicitHeight: Kirigami.Units.gridUnit * 2
            background: Rectangle {
                color: Kirigami.Theme.backgroundColor
                border.color: Kirigami.Theme.disabledTextColor
                radius: 4
        }
            }

        Kirigami.Heading {
            text: "Thresholds"
            level: 3
            font.bold: true
            Kirigami.FormData.isSection: true
            topPadding: Kirigami.Units.smallSpacing
            bottomPadding: Kirigami.Units.smallSpacing
        }

        PlasmaComponents3.SpinBox {
            id: threshold1Spin
            Kirigami.FormData.label: "Warning threshold (ppm)"
            from: 0
            to: 5000
            stepSize: 10
            Layout.fillWidth: true
            implicitHeight: Kirigami.Units.gridUnit * 2
            background: Rectangle {
                color: Kirigami.Theme.backgroundColor
                border.color: Kirigami.Theme.disabledTextColor
                radius: 4
        }
            }

        PlasmaComponents3.SpinBox {
            id: threshold2Spin
            Kirigami.FormData.label: "Alert threshold (ppm)"
            from: 0
            to: 5000
            stepSize: 10
            Layout.fillWidth: true
            implicitHeight: Kirigami.Units.gridUnit * 2
            background: Rectangle {
                color: Kirigami.Theme.backgroundColor
                border.color: Kirigami.Theme.disabledTextColor
                radius: 4
        }
            }

        Kirigami.Heading {
            text: "Display"
            level: 3
            font.bold: true
            Kirigami.FormData.isSection: true
            topPadding: Kirigami.Units.smallSpacing
            bottomPadding: Kirigami.Units.smallSpacing
        }

        PlasmaComponents3.CheckBox {
            id: showIconCheck
            Kirigami.FormData.label: "Show status icon"
            text: "Enable"
        }

        PlasmaComponents3.TextField {
            id: displayFormatField
            Kirigami.FormData.label: "Display format"
            placeholderText: "{icon}{ppm} ppm, {humidity}%, {temperature}℃"
            Layout.fillWidth: true
            Layout.preferredWidth: Kirigami.Units.gridUnit * 24
            implicitHeight: Kirigami.Units.gridUnit * 2
            leftPadding: Kirigami.Units.smallSpacing
            rightPadding: Kirigami.Units.smallSpacing
            topPadding: Kirigami.Units.smallSpacing
            bottomPadding: Kirigami.Units.smallSpacing
            color: Kirigami.Theme.textColor
            background: Rectangle {
                color: Kirigami.Theme.backgroundColor
                border.color: Kirigami.Theme.disabledTextColor
                radius: 4
        }
            }

        PlasmaComponents3.ComboBox {
            id: fontFamilyCombo
            Kirigami.FormData.label: "Font family"
            editable: true
            model: Qt.fontFamilies()
            Layout.fillWidth: true
            Layout.preferredWidth: Kirigami.Units.gridUnit * 24
            implicitHeight: Kirigami.Units.gridUnit * 2
            onActivated: {
                editText = currentText
            }
            onEditTextChanged: {
                var idx = model.indexOf(editText)
                if (idx >= 0 && idx !== currentIndex) {
                    currentIndex = idx
                }
            }
            contentItem: TextInput {
                text: fontFamilyCombo.editable ? fontFamilyCombo.editText : fontFamilyCombo.displayText
                color: Kirigami.Theme.textColor
                opacity: 1.0
                font.weight: Font.Medium
                readOnly: !fontFamilyCombo.editable
                inputMethodHints: fontFamilyCombo.inputMethodHints
                validator: fontFamilyCombo.validator
                selectByMouse: true
                verticalAlignment: Text.AlignVCenter
                leftPadding: Kirigami.Units.smallSpacing
                rightPadding: Kirigami.Units.smallSpacing
            }
            background: Rectangle {
                color: Kirigami.Theme.backgroundColor
                border.color: Kirigami.Theme.disabledTextColor
                radius: 4
            }
            Component.onCompleted: {
                var idx = model.indexOf(editText)
                if (idx >= 0) {
                    currentIndex = idx
                }
            }
        }

        PlasmaComponents3.SpinBox {
            id: fontSizeSpin
            Kirigami.FormData.label: "Font size (pt)"
            from: 6
            to: 48
            stepSize: 1
            Layout.fillWidth: true
            implicitHeight: Kirigami.Units.gridUnit * 2
            background: Rectangle {
                color: Kirigami.Theme.backgroundColor
                border.color: Kirigami.Theme.disabledTextColor
                radius: 4
        }
            }

        Kirigami.Heading {
            text: "Icons"
            level: 3
            font.bold: true
            Kirigami.FormData.isSection: true
            topPadding: Kirigami.Units.smallSpacing
            bottomPadding: Kirigami.Units.smallSpacing
        }

        PlasmaComponents3.TextField {
            id: iconWarningField
            Kirigami.FormData.label: "Warning icon"
            placeholderText: "🟧"
            Layout.fillWidth: true
            Layout.preferredWidth: Kirigami.Units.gridUnit * 12
            implicitHeight: Kirigami.Units.gridUnit * 2
            leftPadding: Kirigami.Units.smallSpacing
            rightPadding: Kirigami.Units.smallSpacing
            topPadding: Kirigami.Units.smallSpacing
            bottomPadding: Kirigami.Units.smallSpacing
            color: Kirigami.Theme.textColor
            background: Rectangle {
                color: Kirigami.Theme.backgroundColor
                border.color: Kirigami.Theme.disabledTextColor
                radius: 4
        }
            }

        PlasmaComponents3.TextField {
            id: iconAlertField
            Kirigami.FormData.label: "Alert icon"
            placeholderText: "❌"
            Layout.fillWidth: true
            Layout.preferredWidth: Kirigami.Units.gridUnit * 12
            implicitHeight: Kirigami.Units.gridUnit * 2
            leftPadding: Kirigami.Units.smallSpacing
            rightPadding: Kirigami.Units.smallSpacing
            topPadding: Kirigami.Units.smallSpacing
            bottomPadding: Kirigami.Units.smallSpacing
            color: Kirigami.Theme.textColor
            background: Rectangle {
                color: Kirigami.Theme.backgroundColor
                border.color: Kirigami.Theme.disabledTextColor
                radius: 4
        }
            }

        PlasmaComponents3.TextField {
            id: iconNormalField
            Kirigami.FormData.label: "Normal icon"
            placeholderText: "."
            Layout.fillWidth: true
            Layout.preferredWidth: Kirigami.Units.gridUnit * 12
            implicitHeight: Kirigami.Units.gridUnit * 2
            leftPadding: Kirigami.Units.smallSpacing
            rightPadding: Kirigami.Units.smallSpacing
            topPadding: Kirigami.Units.smallSpacing
            bottomPadding: Kirigami.Units.smallSpacing
            color: Kirigami.Theme.textColor
            background: Rectangle {
                color: Kirigami.Theme.backgroundColor
                border.color: Kirigami.Theme.disabledTextColor
                radius: 4
            }
        }
    }
}
