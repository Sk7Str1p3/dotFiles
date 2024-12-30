import { App, Astal, Gdk } from "astal/gtk3";

function PowerHide() {
    App.get_window("power")!.destroy()
}

export default function PowerMenu() {
    return <window 
        name = "power"
        anchor={Astal.WindowAnchor.TOP | Astal.WindowAnchor.BOTTOM}
        exclusivity={Astal.Exclusivity.IGNORE}
        keymode={Astal.Keymode.ON_DEMAND}
        application={App}
        onKeyPressEvent={function (self, event: Gdk.Event) {
            if (event.get_keyval()[1] === Gdk.KEY_Escape)
                self.hide()
        }}>
        <box>
            <eventbox widthRequest={4000} expand onClick={PowerHide} />
            <box hexpand={false} vertical>
                <eventbox heightRequest={100} onClick={PowerHide} />
                <box widthRequest={50} className="Power" vertical>
                    <box spacing={6} vertical>
                        <button
                        onClick={() => /*PowerSlider(Shutdown)*/ print("нахуй иди")} >
                            ⏻
                        </button>
                        <button
                        onClick={() => /*PowerSlider(Sleep)*/ print("нахуй иди")} >
                            
                        </button>
                        <button
                        onClick={() => /*PowerSlider(Lock)*/ print("нахуй иди")} >
                            
                        </button>
                        <button
                        onClick={() => /*PowerSlider(Hibernate)*/ print("нахуй иди")} >
                            ⏻
                        </button>
                        <button
                        onClick={() => /*PowerSlider(Reboot)*/ print("нахуй иди")} >
                            ⏻
                        </button>
                    </box>
                </box>
                <eventbox expand onClick={PowerHide} />
            </box>
            <eventbox widthRequest={4000} expand onClick={PowerHide} />
        </box>
    </window>
}