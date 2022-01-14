# Common

## Notes for iOS Developers
- Lots of UIKit components have AppKit equivalents, such as NSButton, NSTableView, NSSegmentedControl. However, there are slight differences.
- Some things we take for granted in iOS do not exist on macOS, such as every view having an adjustable background color. 
The only way to change a background color of NSView is by doing 
```
    view.wantsLayer = true
    view.layer?.backgroundColor = NSColor.blue.cgColor
```
- When macOS was created as OS X in 2001 frameworks like Core Animation didn't exist, so views didn't have layer property.
- As a result of CA late introduction, animation is significantly less seamless on macOS than it is on iOS.
- On iOS we have UIWindow, but it's mostly invisible; on macOS NSWindow is important because an app can have multiple windows, and each one can be resized by user.
- Some iOS views are separate entities on macOS; for example - UITextView is a single object in UIKit that includes scroll view, but if you drag and drop NSTextView into a storyboard, you'll get an NSScrollView that contains an NSClipView, which in turn contains an NSTextView.
- Cocoa is extremely focused on object-oriented programming, so the only way to adjust a setting a lot of the times is to create a subclass.
- Weirdly enough, paralell for UILabel is NSTextField.
- The Y axis starts at the bottom of the screen in macOS, whereas it's the top of the screen in iOS.


## Window Management

- In case you want to close the app when the close button is tapped on window, you should add this AppDelegate method
```
   func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
        return true
    }
```
