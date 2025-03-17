use hyprland::{dispatch::{ Dispatch, DispatchType, Position, WindowIdentifier }, event_listener::EventListener};

fn main() -> hyprland::Result<()> {
    let mut event_listener = EventListener::new();
    event_listener.add_window_title_changed_handler(|data| {
        if data.title == "Extension: (Bitwarden Password Manager) - Bitwarden — Firefox Developer Edition" {
            let window = WindowIdentifier::Address(data.address.clone());
            Dispatch::call(DispatchType::ToggleFloating(Some(window.clone()))).expect("Failed to float a Window");
            Dispatch::call(DispatchType::FocusWindow(window.clone())).expect("Failed to focus the window");
            Dispatch::call(DispatchType::ResizeWindowPixel(Position::Exact(960, 600), window)).expect("Failed to resize window");
// This seems decent way to "Center it"
            Dispatch::call(DispatchType::Custom("centerwindow", "")).expect("Failed to center window"); 
        }
    });
    event_listener.start_listener()?;

    Ok(())
}
