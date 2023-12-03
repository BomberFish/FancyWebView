// bomberfish
// ContentView.swift – fancywebview
// created on 2023-12-03

import SwiftUI
import WebKit

struct BareWebView: UIViewRepresentable { // this is useless, just the base code
 
    var url: URL
 
    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }
 
    func updateUIView(_ webView: WKWebView, context: Context) {
        let request = URLRequest(url: url)
        webView.load(request)
    }
}

struct WebView: UIViewRepresentable {
 
    var url: URL
 
    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }
 
    func updateUIView(_ webView: WKWebView, context: Context) {
        let request = URLRequest(url: url)
        let script = """
        document.body.style.paddingTop = '50px';
        """ // fixup header
        webView.configuration.userContentController.addUserScript(WKUserScript( source: script, injectionTime: .atDocumentStart, forMainFrameOnly: false)) // https://stackoverflow.com/questions/75118702/how-do-i-inject-css-js-in-a-wkwebview-using-swiftui
        webView.load(request)
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            webView.evaluateJavaScript(script)
        }
    }
}

struct FancyWebView: View {
    public var url: URL
    var body: some View {
        ZStack {
            WebView(url: url)
                
            TitleBar(url: url)
        }
    }
    
    struct TitleBar: View {
        public var url: URL
        var body: some View {
            VStack {
                HStack(alignment: .center) {
                    let isHTTPS = url.scheme == "https"
                    Label(url.host() ?? url.absoluteString, systemImage: isHTTPS ? "lock" : "lock.slash")
                        .padding(.bottom, 10)
                        .foregroundColor(isHTTPS ? Color(UIColor.systemGreen) : Color(UIColor.systemRed))
                }
                .frame(maxWidth: .infinity)
                .background(.thinMaterial)
                Spacer()
                Rectangle()
                    .frame(width: .infinity, height: 0)
                    .ignoresSafeArea(.all)
                    .background(ignoresSafeAreaEdges: .all)
                    .opacity(0)
                    .background(.thinMaterial)
                    
            }
            
        }
    }
}

#Preview {
    FancyWebView(url: .init(string: "https://google.com")!)
}
