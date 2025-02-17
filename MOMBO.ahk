#Include XInput.ahk  ; Certifique-se de que XInput.ahk está na mesma pasta do script

SetTimer(CheckMomboState, 10)  ; Verifica o estado do jogo a cada 10ms

global vibrateDuration := 200  ; Duração da vibração (em milissegundos)
global vibrateStrength := 1.0  ; Intensidade da vibração (0 a 1.0)

global lastXState := false
global lastRBState := false

CheckMomboState() {
    global lastXState
    global lastRBState

    state := XInput.GetState(0)
    if (state) {
        ; Verifica se o botão X do controle foi pressionado
        currentXState := NumGet(state, 4, "UShort") & 0x4000
        if (currentXState && !lastXState) {
            Sleep 50  ; Adiciona um pequeno delay
            VibrateController(vibrateStrength, vibrateDuration)
        }
        lastXState := currentXState

        ; Verifica se o botão RB do controle foi pressionado
        currentRBState := NumGet(state, 4, "UShort") & 0x0200
        if (currentRBState && !lastRBState) {
            VibrateController(vibrateStrength, vibrateDuration)
        }
        lastRBState := currentRBState
    }
}

VibrateController(strength, duration) {
    XInput.SetRumble(0, strength, strength)  ; Ativa a vibração
    Sleep duration
    XInput.SetRumble(0, 0, 0)  ; Desativa a vibração
}
