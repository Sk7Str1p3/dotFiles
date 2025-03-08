import Hyprland from "gi://AstalHyprland"
import { Gtk } from "astal/gtk3"
import { bind } from "astal"

export function Workspaces() {
    const hypr = Hyprland.get_default()
    const ws: number = 7
    const focusWorkspace = (workspaceId: number) =>
        hypr.dispatch("workspace", workspaceId.toString());

    return <box className="Workspaces">
        {Array.from({length: ws},(_,i) => i + 1).map((i) => {
            return (
                <button
                    valign={Gtk.Align.CENTER}
                    className={bind(hypr, "focusedWorkspace").as(
                        (fw) => {
                            return i === fw.id
                                ? "ws-button focused"
                                : "ws-button";
                        },
                    )}
                    onClicked={() => focusWorkspace(i)}/>
            );
        })}
    </box>
}