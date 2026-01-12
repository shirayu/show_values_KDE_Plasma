import QtQuick 2.15
import QtQuick.Layouts 1.15
import org.kde.kirigami 2.20 as Kirigami
import org.kde.plasma.components 3.0 as PlasmaComponents3

Kirigami.Page {
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

    Kirigami.FormLayout {
        anchors.fill: parent

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
    }
}
