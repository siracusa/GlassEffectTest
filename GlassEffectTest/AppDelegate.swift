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
        window = NSWindow()
        window.isOpaque = false
        window.backgroundColor = .clear
        window.titleVisibility = .hidden
        window.titlebarSeparatorStyle = .none
        window.isMovableByWindowBackground = true
        window.styleMask = [ .titled, .resizable, .fullSizeContentView ]

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
        }
        .frame(width: 400, height: 300)
        .glassEffect(material, in: Rectangle())
    }
}
