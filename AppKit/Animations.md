## Animations 

- As a conesequence of the differences in the view system, animations also work quite differently on the Mac. If your views are not layer-backed, then naturally, animations will be a CPU-intensive process, as every step of the animation has to be drawn accordingly in the window-backing store. 
- There are a few different ways you can trigger an animation on a view. First, you can use the animator proxy:
- ```
- view.animator.alphaValue = 0.5
- ```
- Behind the scenes, this will enable implicit animations on the backing layer, set the alpha value, and disable the implicit animations again. 
- You can also wrap this into an animation context in order to get a completion handler callback:
```
NSAnimationContext.runAnimationGroup({ context in
 view.animator.alpha = 0.5
 },completionHandler: { [weak self] in
  // ...
  })
```
- In order to influence the duration and the timing function, we have to set these values on the animation context:
```
NSAnimationContext.runAnimationGroup({ context in
 context.duration = 1
 context.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
 view.animator.alpha = 0.5
 },completionHandler: { [weak self] in
  // ...
  })
```
- If you don't need the completion handler, you can also use the shorthand form:
```
  NSAnimationContext.current.duration = 1
  view.animator.alpha = 1
```
- Lastly, you can also enable implicit animations, so that you don't have to explicitly use the animator proxy each time:
```
  NSAnimationContext.current.allowsImplicitAnimations = true
  view.alpha = 1
```
