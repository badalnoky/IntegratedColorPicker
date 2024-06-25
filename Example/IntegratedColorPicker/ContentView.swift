import SwiftUI
import IntegratedColorPicker

struct ContentView: View {
    @State private var selectedColor = Color.blue
    var body: some View {
        VStack {
            IntegratedColorPicker(selectedColor: $selectedColor, isEditable: true) {
                Text("This is an example").foregroundStyle(selectedColor)
            }
        }
    }
}

#Preview {
    ContentView()
}
