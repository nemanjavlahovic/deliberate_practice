# Common

## Notes for iOS Developers
- Lots of UIKit components have AppKit equivalents, such as NSButton, NSTableView, NSSegmentedControl. However, there are slight differences.
- Some things we take for granted in iOS do not exist on macOS, such as every view having an adjustable background color. 
The only way to change a background color of NSView is by doing 
```
    view.wantsLayer = true
    view.layer?.backgroundColor = NSColor.blue.cgColor
```
