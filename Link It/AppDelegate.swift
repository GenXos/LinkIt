//
//  AppDelegate.swift
//  Link It
//
//  Created by Todd Fields on 2017-05-10.
//  Copyright © 2017 SKULLGATE Studios. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    var item: NSStatusItem? = nil

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
        
        item = NSStatusBar.system().statusItem(withLength: NSVariableStatusItemLength)
        item?.image = NSImage(named: "link")
        
        let menu = NSMenu()
        menu.addItem(NSMenuItem(title: "Link It!", action: #selector(AppDelegate.linkIt), keyEquivalent: ""))
        menu.addItem(NSMenuItem(title: "Quit", action: #selector(AppDelegate.quit), keyEquivalent: ""))
        
        item?.menu = menu
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }

    func linkIt() {
    
        print("We Made It!")
        
        if let items = NSPasteboard.general().pasteboardItems {
            
            for item in items {
                
                for type in item.types {
                    
                    if type == "public.utf8-plain-text" {
                        
                        if let url = item.string(forType: type) {
                            
                            NSPasteboard.general().clearContents()
                            
                            var convertedURL = ""
                            
                            if url.hasPrefix("http://") || url.hasPrefix("https://") {
                                
                                convertedURL = url
                            } else {
                                
                                convertedURL = "http://\(url)"
                            }
                            
                            NSPasteboard.general().setString("<a href=\"\(convertedURL)\">\(url)</a>", forType: "public.html")
                            NSPasteboard.general().setString("\(convertedURL)", forType: "public.utf8-plain-text")
                        }
                    }
                }
            }
        }
        printPasteboard()
    }
    
    func printPasteboard() {
        
        if let items = NSPasteboard.general().pasteboardItems {
            
            for item in items {
                
                for type in item.types {
                    
                    print("Type: \(type)")
                    print("String: \(item.string(forType: type))")
                }
            }
        }
    }
    
    func quit() {
        
        NSApplication.shared().terminate(self)
    }
}

