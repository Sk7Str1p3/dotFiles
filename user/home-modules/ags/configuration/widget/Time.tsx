import { Variable, GLib } from "astal";
import { CalendarSheet } from "./Calendar";

export function Time({ format = "%R, %b %d" }) {
  const time = Variable<string>("").poll(
    1000,
    () => GLib.DateTime.new_now_local().format(format)!,
  );

  return (
    <button className="Time" onClick={() => CalendarSheet()}>
      <label onDestroy={() => time.drop()} label={time()} />
    </button>
  );
}
