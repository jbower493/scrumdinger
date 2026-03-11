import SwiftUI

struct ShareExtensionView: View {
    let text: String
    let onOpenApp: () -> Void
    
//    init(text: String) {
//        self.text = text
//    }
    
    var body: some View {
        NavigationStack{
            VStack(spacing: 20){
                Text("Shared text:")
                Text(text)

                Button("Open Scrumdinger") {
                    onOpenApp()
                }
                
                Spacer()
            }
            .padding()
            .navigationTitle("Share Extension")
            .toolbar {
                Button("Cancel") {
                    close()
                }
            }
        }
    }

    func close() {
        NotificationCenter.default.post(name: NSNotification.Name("close"), object: nil)
    }
}
