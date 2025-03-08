import AppLauncher from "./window/AppMenu"

export default function AppRunner() {
    return <button 
        className="AppRunner"
        onClick={() => AppLauncher()} >
            
    </button>
    // TODO: Replace rofi with custom widget // DONE
}