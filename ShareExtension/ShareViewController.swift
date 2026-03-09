import UIKit
import SwiftUI

class ShareViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard
            let extensionItem = extensionContext?.inputItems.first as? NSExtensionItem,
            let itemProvider = extensionItem.attachments?.first else {
            self.close()
            return
        }
        
        if itemProvider.hasItemConformingToTypeIdentifier("public.url") {
            itemProvider.loadItem(forTypeIdentifier: "public.url", options: nil) { (url, error) in
                if error != nil {
                    self.close()
                    return
                }
                
                if let sharedUrl = url as? URL {
                    DispatchQueue.main.async {
                        let contentView = UIHostingController(rootView: ShareView(urlFromShareViewSeet: "\(sharedUrl)"))
                        self.addChild(contentView)
                        self.view.addSubview(contentView.view)
                        
                        contentView.view.translatesAutoresizingMaskIntoConstraints = false
                        contentView.view.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
                        contentView.view.bottomAnchor.constraint (equalTo: self.view.bottomAnchor).isActive = true
                        contentView.view.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
                        contentView.view.rightAnchor.constraint (equalTo: self.view.rightAnchor).isActive = true
                    }
                } else {
                    self.close()
                    return
                }
            }
        } else {
            close()
            return
        }
        
        NotificationCenter.default.addObserver(forName: NSNotification.Name("Close"), object: nil, queue: nil) { _ in
            DispatchQueue.main.async {
                self.close()
            }
        }
    }
    
    func close() {
        self.extensionContext?.completeRequest(returningItems: [], completionHandler: nil)
    }
}
