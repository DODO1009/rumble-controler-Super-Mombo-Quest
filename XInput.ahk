class XInput {
    static Load() {
        static hModule := DllCall("LoadLibrary", "Str", "xinput1_3.dll", "Ptr")
        return hModule
    }

    static SetRumble(controller := 0, left := 1.0, right := 1.0) {
        this.Load()
        left := Round(65535 * left)
        right := Round(65535 * right)
        buf := Buffer(4)
        NumPut("UShort", left, buf, 0)
        NumPut("UShort", right, buf, 2)
        return DllCall("xinput1_3\XInputSetState", "UInt", controller, "Ptr", buf)
    }

    static GetState(controller := 0) {
        this.Load()
        state := Buffer(16)
        if (DllCall("xinput1_3\XInputGetState", "UInt", controller, "Ptr", state) = 0) {
            return state
        } else {
            return 0
        }
    }
}
