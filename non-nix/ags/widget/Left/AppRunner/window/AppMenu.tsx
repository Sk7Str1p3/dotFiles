import { App, Astal, Gdk, Gtk } from "astal/gtk3"
import { Variable } from "astal"
import Apps from "gi://AstalApps"

import AppButton from "./AppButton"

const MAX_ITEMS = 8
export function AppHide() {
    App.get_window("launcher")!.destroy()
}

export default function AppLauncher() {
    const { CENTER } = Gtk.Align
    const apps = new Apps.Apps()

    const text = Variable("")
    const list = text(text => apps.fuzzy_query(text).slice(0, MAX_ITEMS))
    const onEnter = () => {
        apps.fuzzy_query(text.get())?.[0].launch()
        AppHide()
    }

    return <window
        name="launcher"
        anchor={Astal.WindowAnchor.TOP | Astal.WindowAnchor.BOTTOM}
        exclusivity={Astal.Exclusivity.IGNORE}
        keymode={Astal.Keymode.ON_DEMAND}
        application={App}
        onShow={() => text.set("")}
        onKeyPressEvent={function (self, event: Gdk.Event) {
            if (event.get_keyval()[1] === Gdk.KEY_Escape)
                self.destroy()
        }}>
        <box>
            <eventbox widthRequest={4000} expand onClick={AppHide} />
            <box hexpand={false} vertical>
                <eventbox heightRequest={100} onClick={AppHide} />
                <box widthRequest={500} className="Applauncher" vertical>
                    <entry
                        placeholderText="Search"
                        text={text()}
                        onChanged={self => text.set(self.text)}
                        onActivate={onEnter}
                    />
                    <box spacing={6} vertical>
                        {list.as(list => list.map(app => (
                            <AppButton app={app} />
                        )))}
                    </box>
                    <box
                        halign={CENTER}
                        className="not-found"
                        vertical
                        visible={list.as(l => l.length === 0)}>
                        <icon icon="system-search-symbolic" />
                        <label label="No match found" />
                    </box>
                </box>
                <eventbox expand onClick={AppHide} />
            </box>
            <eventbox widthRequest={4000} expand onClick={AppHide} />
        </box>
    </window>
}