import Cava from "gi://AstalCava";
const cava = Cava.get_default()!;
import Gtk from "gi://Gtk?version=3.0";

export function CavaDraw() {
  return (
    <box className="Cava">
      <drawingarea
        widthRequest={100}
        onDraw={(self, cr) => {
          const h = self.get_allocated_height();
          const w = self.get_allocated_width();
          const bars = cava.get_bars();

          Gtk.render_background(self.get_style_context(), cr, 0, 0, w, h);
          const fg = self
            .get_style_context()
            .get_property("color", Gtk.StateFlags.NORMAL);
          cr.setSourceRGBA(fg.red, fg.green, fg.blue, fg.alpha);

          let lastX = 0;
          let lastY = h - h * cava.get_values()[0];
          cr.moveTo(lastX, lastY);
          for (let i = 1; i < cava.get_values().length; i++) {
            const height = h * cava.get_values()[i];
            let y = h - height - 2;
            cr.curveTo(
              lastX + w / (bars - 1) / 2,
              lastY,
              lastX + w / (bars - 1) / 2,
              y,
              i * (w / (bars - 1)),
              y,
            );
            lastX = i * (w / (bars - 1));
            lastY = y;
          }
          cr.lineTo(w, h);
          cr.lineTo(0, h);
          cr.fill();
        }}
      />
    </box>
  ).hook(cava, "notify::values", (self) => self.queue_draw());
}
