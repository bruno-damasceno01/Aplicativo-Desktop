import QtQuick
import QtQuick.Controls
Rectangle{
    id: mainWindow
    width: 1200
    height: 478
    color: "#282A36"
    radius: 10
    border.color: "#44475A"
    border.width: 2
    // Posição atual do carrossel
    property int currentIndex: 0
    property int totalCartoes: usuarios.count
    // Função para decrementar o currentIndex
    function decrementCurrentIndex() {
        currentIndex = (currentIndex - 1 + 12) % 12
        console.log("Índice decrementado:", currentIndex)
    }
    // Função para incrementar o currentIndex
    function incrementCurrentIndex() {
        currentIndex = (currentIndex + 1) % 12
    }
    PathView {
        id: pathView
        anchors.centerIn: parent.centerIn
        model: 12 // Número de cartões
        preferredHighlightBegin: 0.5
        preferredHighlightEnd: 0.5
        snapMode: PathView.SnapOneItem
        focus: true
        path: Path {
            startX: -5000; startY: 238
            PathLine { x: 600; y: 238 }
            PathLine { x: 6200; y: 238 }
        }
        delegate: Rectangle {
            width: 250
            height: 200
            color: "#44475A"
            radius: 20
            border.width: 1.5
            border.color: "#F8F8F2"
            MouseArea{
                id: areacartao
                property bool isClicked: false
                anchors.fill: parent
                z: 0
                onWheel: {
                    if (wheel.angleDelta.y > 0) {
                        pathView.decrementCurrentIndex()
                        cartaoinfo.opacity = 0
                    }
                    else {
                        pathView.incrementCurrentIndex()
                        cartaoinfo.opacity = 0
                    }
                }  
                onClicked: {
                    isClicked = !isClicked
                    if (isClicked) {
                        abrircartao.start()
                    } else {
                        fecharcartao.start()
                    }
                }  
            }
            SequentialAnimation{
                id: abrircartao
                running: false
                ScriptAction {
                    script: {
                        areacartao.enabled = false
                    }
                }
                OpacityAnimator{
                    target: cartaoinfo
                    from: 0
                    to: 1
                    duration: 10
                }
                NumberAnimation{
                    target: cartaoinfo
                    property: "x"
                    from: cartaoinfo.x
                    to: 680
                    duration: 1000
                    easing.type: Easing.InOutQuad
                }
                ScriptAction {
                    script: {
                        areacartao.enabled = true
                    }
                }
            }
            SequentialAnimation{
                id: fecharcartao
                running: false
                ScriptAction {
                    script: {
                        areacartao.enabled = false
                    }
                }
                NumberAnimation{
                    target: cartaoinfo
                    property: "x"
                    from: cartaoinfo.x
                    to: 485
                    duration: 1000
                    easing.type: Easing.InOutQuad
                }
                OpacityAnimator{
                    target: cartaoinfo
                    from: 1
                    to: 0
                    duration: 10
                }
                ScriptAction {
                    script: {
                        areacartao.enabled = true
                    }
                }
            }
        Rectangle{
            x: 505
            y: 145
            id: cartaoinfo
            width: 240
            height: 190
            color: "#44475A"
            radius: 15
            opacity: 0
            }
        }
    }
}
