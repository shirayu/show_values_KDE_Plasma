import QtQuick 2.15
import QtQuick.Layouts 1.15
import org.kde.plasma.components 3.0 as PlasmaComponents3
import org.kde.plasma.plasmoid 2.0

PlasmoidItem {
    id: root
    implicitWidth: label.implicitWidth
    implicitHeight: label.implicitHeight
    clip: true
    Layout.minimumWidth: label.implicitWidth + 16

    property var dataJson: null
    property bool mode: false
    property string displayText: "No data"
    property string endpointUrl: plasmoid.configuration.endpointUrl
    property int dataInterval: plasmoid.configuration.dataInterval
    property string errorMessage: "Failed to load data: " + endpointUrl
    property int blinkNormalInterval: plasmoid.configuration.blinkNormalInterval
    property int blinkWarningInterval: plasmoid.configuration.blinkWarningInterval
    property int threshold1: plasmoid.configuration.threshold1
    property int threshold2: plasmoid.configuration.threshold2
    property bool showIcon: plasmoid.configuration.showIcon
    property string displayFormat: plasmoid.configuration.displayFormat
    property string fontFamily: plasmoid.configuration.fontFamily
    property int fontPointSize: plasmoid.configuration.fontPointSize
    property string iconWarning: plasmoid.configuration.iconWarning
    property string iconAlert: plasmoid.configuration.iconAlert
    property string iconNormal: plasmoid.configuration.iconNormal

    onDisplayFormatChanged: updateDisplay()
    onShowIconChanged: updateDisplay()
    onThreshold1Changed: updateDisplay()
    onThreshold2Changed: updateDisplay()
    onBlinkNormalIntervalChanged: updateDisplay()
    onBlinkWarningIntervalChanged: updateDisplay()
    onIconWarningChanged: updateDisplay()
    onIconAlertChanged: updateDisplay()
    onIconNormalChanged: updateDisplay()

    function updateToolTip() {
        if (dataJson === null) {
            toolTipMainText = "No data"
            toolTipSubText = errorMessage
            return
        }

        var dateObj = new Date(dataJson.time * 1000)
        var header = "Last modified: " + dateObj.toLocaleDateString() + " " + dateObj.toLocaleTimeString()
        var body = "\n\n" + JSON.stringify(dataJson.stat, null, "\t")
        toolTipMainText = header
        toolTipSubText = body
    }

    function setFailure(message, useErrorPrefix) {
        dataJson = null
        displayText = "No data"
        errorMessage = useErrorPrefix ? ("Error: " + message) : ("Failed to load data: " + endpointUrl)
        updateToolTip()
    }

    function updateDisplay() {
        if (dataJson === null) {
            displayText = "No data"
            displayTimer.interval = 1000
            return
        }

        var ppm = dataJson.stat.co2ppm
        var humidity = Math.trunc(dataJson.stat.humidity)
        var temperature = Number(dataJson.stat.temperature).toFixed(1)
        var icon = ""
        var warningIcon = iconWarning && iconWarning.length > 0 ? iconWarning : "🟧"
        var alertIcon = iconAlert && iconAlert.length > 0 ? iconAlert : "❌"
        var normalIcon = iconNormal && iconNormal.length > 0 ? iconNormal : "."

        if (ppm >= threshold1) {
            displayTimer.interval = Math.max(100, blinkWarningInterval)
            if (ppm > threshold2) {
                icon = mode ? alertIcon : ""
            } else {
                icon = mode ? warningIcon : ""
            }
        } else {
            displayTimer.interval = Math.max(100, blinkNormalInterval)
            icon = mode ? normalIcon : " "
        }

        if (!showIcon) {
            icon = ""
        }

        displayText = formatDisplay(icon, ppm, humidity, temperature)
    }

    function formatDisplay(icon, ppm, humidity, temperature) {
        var fmt = displayFormat
        if (!fmt) {
            fmt = "{icon}{ppm} ppm, {humidity}%, {temperature}℃"
        }

        return fmt
            .replace("{icon}", icon)
            .replace("{ppm}", ppm)
            .replace("{humidity}", humidity)
            .replace("{temperature}", temperature)
    }

    function fetchData() {
        var url = endpointUrl
        var xhr = new XMLHttpRequest()

        xhr.onreadystatechange = function() {
            if (xhr.readyState !== XMLHttpRequest.DONE) {
                return
            }

            if (xhr.status === 200) {
                try {
                    dataJson = JSON.parse(xhr.responseText)
                    updateToolTip()
                    updateDisplay()
                } catch (err) {
                    console.warn("Failed to parse JSON:", err)
                    setFailure(err.toString(), true)
                }
            } else {
                console.warn("Failed to load data:", xhr.status, xhr.statusText)
                setFailure("", false)
            }
        }

        xhr.onerror = function() {
            console.warn("Network error while loading data")
            setFailure("Network error", true)
        }

        try {
            xhr.open("GET", url)
            xhr.send()
        } catch (err) {
            console.warn("Request error:", err)
            setFailure(err.toString(), true)
        }
    }

    Timer {
        id: dataTimer
        interval: Math.max(100, dataInterval)
        repeat: true
        running: true
        onTriggered: fetchData()
    }

    Timer {
        id: displayTimer
        interval: 1000
        repeat: true
        running: true
        onTriggered: {
            mode = !mode
            updateDisplay()
        }
    }

    PlasmaComponents3.Label {
        id: label
        anchors.fill: parent
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        elide: Text.ElideRight
        text: displayText
        font.family: fontFamily
        font.pointSize: Math.max(6, fontPointSize)
    }

    Component.onCompleted: {
        fetchData()
        updateToolTip()
        updateDisplay()
    }
}
