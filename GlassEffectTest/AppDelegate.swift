//
//  AppDelegate.swift
//  GlassEffectTest
//
//  Created by John Siracusa on 12/18/25.
//

import Cocoa
import SwiftUI

@main
class AppDelegate: NSObject, NSApplicationDelegate {
    var window : NSWindow!

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        FB21375029.install()
        
        window = NSWindow()
        window.isOpaque = false
        window.backgroundColor = .clear
        window.titleVisibility = .hidden
        window.titlebarSeparatorStyle = .none
        window.isMovableByWindowBackground = true
        window.styleMask = [ .titled, .resizable, .fullSizeContentView ]
        window.level = .floating

        let hostingView = NSHostingView(rootView: DemoView())
        window.contentView = hostingView

        window.center()
        window.makeKeyAndOrderFront(self)
    }

    func applicationSupportsSecureRestorableState(_ app: NSApplication) -> Bool {
        return true
    }
}

struct DemoView : View {
    @State private var material : Glass = .clear

    var body : some View {
        VStack {
            Text(material == .clear ? "Clear Glass" : "Regular Glass")
                .font(.headline)

            Button("Change Material") {
                material = (material == .clear) ? .regular : .clear
            }
            .padding(.bottom, 16)

            Text("""
                This is a floating window. Drag ANOTHER window BEHIND this window.

                Expected behavior: When dragging a window behind this one, the dragged window shows through this window as it moves around.

                Actual behavior: In macOS 26.2 and 26.3 Beta (25D5087f), the dragged window is NOT visible at all through this window.

                (In macOS 26.0 and 26.1, it works as expected, so this is a regression in macOS 26.2 and later.)
                """)
        }
        .padding()
        .frame(width: 400, height: 350)
        .glassEffect(material, in: Rectangle())
    }
}
