# AppKit

## NSView
- Setting the value of `view.wantsLayer` property to true turns the view into a layer-backed view—that is, the view uses a CALayer object to manage its rendered content. Creating a layer-backed view implicitly causes the entire view hierarchy under that view to become layer-backed. Thus, the view and all of its subviews (including subviews of subviews) become layer-backed. The default value of this property is false.
- Overriding `NSView`'s `wantsUpdateLayer` method to return true enables you to change the layer's properties. If you do this though, AppKit will no longer call the view's `drawRect:`, instead, `updateLayer` will be called during the view update cycle, and this is where you can modify the layer (for example, change the background color of a view).
