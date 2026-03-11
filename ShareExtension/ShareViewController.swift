import SwiftUI
import UIKit
import UniformTypeIdentifiers

class ShareViewController: UIViewController {
    let appGroup = "group.com.scrumdingerJbower"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        handleShare()
        
        print("kenny")
    }

    func handleShare() {
        print("handle share")
        
        guard
            let extensionItem = extensionContext?.inputItems.first as? NSExtensionItem,
            let attachments = extensionItem.attachments
        else {
            completeRequest()
            return
        }

        for provider in attachments {

            if provider.hasItemConformingToTypeIdentifier("public.url") {
                provider.loadItem(forTypeIdentifier: "public.url", options: nil) { item, _ in
                    if let url = item as? URL {
                        self.save(type: "url", value: url.absoluteString)
                        self.openHostApp()
                        self.completeRequest()
                    }
                }
                return
            }

            if provider.hasItemConformingToTypeIdentifier("public.text") {
                provider.loadItem(forTypeIdentifier: "public.text", options: nil) { item, _ in
                    if let text = item as? String {
                        self.save(type: "text", value: text)
//                        self.openHostApp()
//                        self.completeRequest()
                        
                        DispatchQueue.main.async {
                            // host the SwiftU view
                            let contentView = UIHostingController(rootView: ShareExtensionView(
                                text: text,
                                onOpenApp: { [weak self] in
                                    self?.openHostApp()
                                }
                            ))
                            self.addChild(contentView)
                            self.view.addSubview(contentView.view)
                            
                            // set up constraints
                            contentView.view.translatesAutoresizingMaskIntoConstraints = false
                            contentView.view.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
                            contentView.view.bottomAnchor.constraint (equalTo: self.view.bottomAnchor).isActive = true
                            contentView.view.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
                            contentView.view.rightAnchor.constraint (equalTo: self.view.rightAnchor).isActive = true
                        }
                    }
                }
                return
            }
        }

        self.completeRequest()
    }
    
    func save(type: String, value: String) {
        if let defaults = UserDefaults(suiteName: appGroup) {
            defaults.set(type, forKey: "shared_type")
            defaults.set(value, forKey: "shared_value")
        }
    }
    
//    internal func openHostApp() {
//        let urlScheme = "scrumdinger://share"
//        
//        let url = URL(string: urlScheme)
////        let selectorOpenURL = sel_registerName("openURL:")
////        var responder: UIResponder? = self
////        
////        while responder != nil {
////          if responder?.responds(to: selectorOpenURL) == true {
////            responder?.perform(selectorOpenURL, with: url)
////          }
////          responder = responder!.next
////        }
//        
////        completeRequest()
//        if (url != nil) {
//            self.extensionContext?.open(url!, completionHandler: nil)
//        }
//        
//    }
    
    func openHostApp() {
        guard let url = URL(string: "scrumdinger://share") else { return }

        extensionContext?.open(url)

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            self.extensionContext?.completeRequest(returningItems: nil)
        }
    }
      
  func completeRequest() {
    // Inform the host that we're done, so it un-blocks its UI. Note: Alternatively you could call super's -didSelectPost, which will similarly complete the extension context.
//    extensionContext!.completeRequest(returningItems: [], completionHandler: nil)
  }
}
