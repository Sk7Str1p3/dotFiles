import { execAsync, Variable } from "astal";
import { App, Astal, Gdk, Gtk } from "astal/gtk3";
import PowerConfirm from "./PowerConfirm";

function PowerHide() {
  App.get_window("power")!.destroy();
}

export default function PowerMenu() {
  // TODO: Make the box (not window) blurry
  return (
    <window
      name="power"
      anchor={Astal.WindowAnchor.TOP | Astal.WindowAnchor.BOTTOM}
      exclusivity={Astal.Exclusivity.IGNORE}
      keymode={Astal.Keymode.ON_DEMAND}
      application={App}
      onKeyPressEvent={function (self, event: Gdk.Event) {
        if (event.get_keyval()[1] === Gdk.KEY_Escape) self.destroy();
      }}
    >
      <box>
        <eventbox widthRequest={4000} expand onClick={PowerHide} />
        <box hexpand={false} vertical>
          <eventbox heightRequest={100} onClick={PowerHide} />
          <box
            marginLeft={1800}
            widthRequest={50}
            className="PowerMenu"
            vertical
          >
            <button
              className="PowerButton"
              onClick={() => {
                PowerHide(), PowerConfirm("shutdown", "shutdown now");
              }}
            >
              󰐥
            </button>
            <button
              className="PowerButton"
              onClick={() => {
                PowerHide(), PowerConfirm("reboot", "reboot");
              }}
            >
              󰜉
            </button>
            <button
              className="PowerButton"
              onClick={() => {
                PowerHide(), PowerConfirm("suspend", "systemctl suspend");
              }}
            >
              󰒲
            </button>
            <button
              className="PowerButton"
              onClick={() => {
                PowerHide(), PowerConfirm("hibernate ", "systemctl hibernate");
              }}
            >
              󰋊
            </button>
            <button
              className="PowerButton"
              onClick={() => {
                PowerHide(), PowerConfirm("logout", "hyprctl dispatch exit");
              }}
            >
              󰍃
            </button>
            <button
              className="PowerButton"
              onClick={() => {
                PowerHide(), PowerConfirm("lock", "loginctl lock-session");
              }}
            >
              󰌾
            </button>
          </box>
          <eventbox expand onClick={PowerHide} />
        </box>
        <eventbox widthRequest={4000} expand onClick={PowerHide} />
      </box>
    </window>
  );
}
