import { execAsync } from "astal";
import { App, Astal, Gdk, Gtk } from "astal/gtk3";

function PowerConfirmHide() {
    App.get_window("powerconfirm")!.destroy()
}

export default function PowerConfirm(act: string,cmd: string) {
    return <window
        name="powerconfirm"
        anchor={Astal.WindowAnchor.TOP | Astal.WindowAnchor.BOTTOM}
        exclusivity={Astal.Exclusivity.IGNORE}
        keymode={Astal.Keymode.ON_DEMAND}
        application={App}
        onKeyPressEvent={function (self, event: Gdk.Event) {
            if (event.get_keyval()[1] === Gdk.KEY_Escape)
                self.destroy()
        }}>
            <box>
                <eventbox widthRequest={4000} expand onClick={PowerConfirmHide} />
                <box hexpand={false} vertical>
                    <eventbox heightRequest={100} onClick={PowerConfirmHide} />
                    <box className={"PowerConfirm label"} valign={Gtk.Align.CENTER}>
                        <label label={`Are you sure you want to ${act}?`}/>
                    </box>
                    <box halign={Gtk.Align.CENTER} className="PowerConfirm buttons">
                        <button className="Yes" onClick={() => { PowerConfirmHide(), execAsync(`${cmd}`)}}>
                            Yes
                        </button>
                        <button className="No" onClick={() => PowerConfirmHide()}>
                            No
                        </button>
                    </box>
                    <eventbox expand onClick={PowerConfirmHide} />
                </box>
                <eventbox widthRequest={4000} expand onClick={PowerConfirmHide} />
            </box> 
        </window>
}