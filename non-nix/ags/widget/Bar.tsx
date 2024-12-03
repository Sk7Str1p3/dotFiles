import { App, Astal, Gtk, Gdk } from "astal/gtk3"
import { Variable } from "astal"

import { Runner } from "./Runner.tsx"

const time = Variable("").poll(1000, "date")

export default function Bar(gdkmonitor: Gdk.Monitor) {
    return <window
        className="Bar"
        gdkmonitor={gdkmonitor}
        exclusivity={Astal.Exclusivity.EXCLUSIVE}
        anchor={Astal.WindowAnchor.TOP
            | Astal.WindowAnchor.LEFT
            | Astal.WindowAnchor.RIGHT}
        application={App}>
        <box>
            <Runner />
            <box />
            <button
                onClick={() => print("hi")}
                halign={Gtk.Align.CENTER} >
                <label label={time()} />
            </button>
        </box>
    </window>
}
