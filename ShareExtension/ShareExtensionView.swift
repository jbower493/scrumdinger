import SwiftUI

struct ShareExtensionView: View {
    let text: String
    let onOpenApp: () -> Void
    let onCancel: () -> Void
    
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
                    onCancel()
                }
            }
        }
    }
}
