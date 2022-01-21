# AppKit

## NSView
- Setting the value of `view.wantsLayer` property to true turns the view into a layer-backed view—that is, the view uses a CALayer object to manage its rendered content. Creating a layer-backed view implicitly causes the entire view hierarchy under that view to become layer-backed. Thus, the view and all of its subviews (including subviews of subviews) become layer-backed. The default value of this property is false.
- It is very important to note that you set `wantsLayer` AFTER you've set your custom layer.
- Overriding `NSView`'s `wantsUpdateLayer` method to return true enables you to change the layer's properties. If you do this though, AppKit will no longer call the view's `drawRect:`, instead, `updateLayer` will be called during the view update cycle, and this is where you can modify the layer (for example, change the background color of a view).
- Opting into layer-backed views will increase the amount of memory needed (each layer has its own backing store, probably overlapping with other views' backing stores) and introduce a potentially costly compositing step of all the layers. 
- You are able to tell AppKit to coalesce the contents of a view tree into one common backing layer by using the `canDrawSubviewsIntoLayer`property. This can be a good option if you know that you will not need to animate subviews individually.
- As AppKit views don't have background color properties that you can set to `NSColor.clear` in order to let the background shine through, many `NSView` subclasses have a `drawsBackground` property that you have to set to `false` if you want the view to be transparent.


- AppKit contols have been traditionally backed by NSCell subclasses. These should not be confused with the `UITableViewCell` or `UICollectionViewCell` in UIKit. AppKit originally made the distinction between views and cells in order to save resources - views would delegate all their drawing to a more lightweight cell object that could be reused for all views of the same type.
