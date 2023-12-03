// bomberfish
// fancywebviewApp.swift – fancywebview
// created on 2023-12-03

import SwiftUI

@main
struct fancywebviewApp: App {
    var body: some Scene {
        WindowGroup {
            FancyWebView(url: .init(string: "https://google.com")!)
        }
    }
}
