import AppKit
import ObjectiveC.runtime

@objc(FB21375029)
final class FB21375029: NSObject {

    /// I typically do my swizzling in Objective-C in the `load` method, but that's not available in Swift.
    static func install() {
#if !DISABLE_FB21375029_WORKAROUND
        let selector = NSSelectorFromString("_hasActiveAppearance")
        guard let original = class_getInstanceMethod(NSWindow.self, selector) else {
            assertionFailure("-[NSWindow _hasActiveAppearance] not found")
            return
        }
        guard let replacement = class_getInstanceMethod(FB21375029.self, #selector(swizzledHasActiveAppearance)) else {
            assertionFailure("-[FB21375029 swizzledHasActiveAppearance] not found")
            return
        }

        /// It would be best to limit this replacement to a specific NSWindow subclass to avoid unintended side effects on all app windows and panels.
        method_exchangeImplementations(original, replacement)
#endif
    }

    @objc func swizzledHasActiveAppearance() -> Bool {
        true
    }
}
