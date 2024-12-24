{ ... }:
{
  system.defaults.dock = {
    # Minimize windows into application icon
    minimize-to-application = true;
  };

  system.defaults.finder = {
    # Search current folder
    FXDefaultSearchScope = "SCcf";
    # Prefer icon view
    FXPreferredViewStyle = "icnv";
    NewWindowTarget = "Home";
    # Keep folders on top when sorting by name
    _FXSortFoldersFirst = true;
  };

  system.defaults.trackpad = {
    # Tap to click
    Clicking = true;
    # Enable three finger drag
    TrackpadThreeFingerDrag = true;
    # Data lookup
    TrackpadThreeFingerTapGesture = 2;
  };

  system.keyboard = {
    enableKeyMapping = true;
    remapCapsLockToEscape = true;
  };
}
