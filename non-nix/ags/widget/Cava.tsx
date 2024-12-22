import Cava from "gi://AstalCava"
import { Gdk } from "astal/gtk3"
import Gsk from "gi://Gsk?version=4.0"

const cava = Cava.get_default()

const bars = 10
const barHeight = 100
const align = "end"
const vertical = false
const smooth = true

export function CavaRender() {
    return <drawingarea className="CavaRender">
        
    </drawingarea>
}
