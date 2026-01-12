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
    property string errorMessage: "Failed to load data: " + endpointUrl
    property int threshold1: plasmoid.configuration.threshold1
    property int threshold2: plasmoid.configuration.threshold2

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

        if (ppm >= threshold1) {
            displayTimer.interval = 300
            if (ppm > threshold2) {
                icon = mode ? "❌" : ""
            } else {
                icon = mode ? "🟧" : ""
            }
        } else {
            displayTimer.interval = 1000
            icon = mode ? "." : " "
        }

        displayText = icon + ppm + " ppm, " + humidity + "%, " + temperature + "℃"
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
        interval: 10000
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
    }

    Component.onCompleted: {
        fetchData()
        updateToolTip()
        updateDisplay()
    }
}
