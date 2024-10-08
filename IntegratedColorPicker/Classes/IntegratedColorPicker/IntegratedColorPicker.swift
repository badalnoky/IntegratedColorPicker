import SwiftUI

public struct IntegratedColorPicker<Content: View> {
    private enum ColorPickerTab: String, Hashable, CaseIterable {
        case grid = "Grid"
        case sliders = "Sliders"
    }

    var selectedColor: Binding<Color>
    private var isEditable = false
    @State private var activeTab: ColorPickerTab = .grid
    @State private var isActive = false
    let previewContent: () -> Content

    public init(selectedColor: Binding<Color>, isEditable: Bool, @ViewBuilder exampleContent: @escaping () -> Content) {
        self.selectedColor = selectedColor
        self.isEditable = isEditable
        self.previewContent = exampleContent
    }
}

extension IntegratedColorPicker: View {
    public var body: some View {
        Circle()
            .frame(
                width: isEditable ? .colorPickerEditingSize : .colorPickerBaseSize,
                height: isEditable ? .colorPickerEditingSize : .colorPickerBaseSize
            )
            .foregroundStyle(selectedColor.wrappedValue)
            .background {
                Circle()
                    .stroke(AngularGradient.colorPickerBorder, lineWidth: isEditable ? .colorPickerEditingWidth : .zero)
                    .frame(width: .colorPickerBaseSize, height: .colorPickerBaseSize)
            }
            .onTapGesture {
                if isEditable {
                    isActive = true
                }
            }
            .sheet(isPresented: $isActive, onDismiss: { activeTab = .grid }) {
                VStack {
                    Spacer()
                    previewContent()
                    Picker(String.colorPickerTitle, selection: $activeTab) {
                        ForEach(ColorPickerTab.allCases, id: \.self) { tab in
                            Text(tab.rawValue)
                        }
                    }
                    .pickerStyle(.segmented)
                    .padding(.vertical, .colorPickerVerticalPadding)
                    switch activeTab {
                    case .grid: ColorGrid(selectedColor: selectedColor)
                    case .sliders: ColorSlider(selectedColor: selectedColor)
                    }
                    Spacer()
                }
                .frame(minWidth: UIScreen.isPhone ? .zero : .iPadSheetWidth)
                .frame(minHeight: UIScreen.isPhone ? .zero : .iPadSheetHeight)
                .padding(.colorPickerHorizontalPadding)
                .presentationDetents(UIScreen.isPhone ? [.fraction(.colorPickerDetent)] : [.height(.iPadSheetHeight)])
            }
    }
}

#Preview {
    @State var color = Color(red: 1.0, green: 1.0, blue: 1.0)
    return IntegratedColorPicker(selectedColor: $color, isEditable: true) {
        Circle().frame(width: 50, height: 50).foregroundStyle(color)
    }
}
