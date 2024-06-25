import SwiftUI

struct ColorGrid: View {
    var selectedColor: Binding<Color>

    // swiftlint: disable: closure_body_length
    var body: some View {
        VStack {
            LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: .zero), count: .colorGridColumnCount)) {
                ForEach(.zero..<Int.colorGridColumnCount, id: \.self) { column in
                    VStack(spacing: .zero) {
                        ForEach(.zero..<Int.colorGridRowCount, id: \.self) { row in
                            let color = Color.basePickerColorGrid[column][row]
                            let isSelected = CIColor(color: UIColor(color)) == CIColor(color: UIColor(selectedColor.wrappedValue))
                            let isTopLeading = column == .zero && row == .zero
                            let isTopTrailing = column == .colorGridMaxX && row == .zero
                            let isBottomLeading = column == .zero && row == .colorGridMaxY
                            let isBottomTrailing = column == .colorGridMaxX && row == .colorGridMaxY
                            UnevenRoundedRectangle(
                                cornerRadii: RectangleCornerRadii(
                                    topLeading: isTopLeading ? .colorGridCornerRadius : .zero,
                                    bottomLeading: isBottomLeading ? .colorGridCornerRadius : .zero,
                                    bottomTrailing: isBottomTrailing ? .colorGridCornerRadius : .zero,
                                    topTrailing: isTopTrailing ? .colorGridCornerRadius : .zero
                                )
                            )
                            .aspectRatio(.one, contentMode: .fit)
                            .foregroundStyle(color)
                            .overlay {
                                UnevenRoundedRectangle(
                                    cornerRadii: RectangleCornerRadii(
                                        topLeading: isTopLeading ? .colorGridCornerRadius : .baseLineWidth,
                                        bottomLeading: isBottomLeading ? .colorGridCornerRadius : .baseLineWidth,
                                        bottomTrailing: isBottomTrailing ? .colorGridCornerRadius : .baseLineWidth,
                                        topTrailing: isTopTrailing ? .colorGridCornerRadius : .baseLineWidth
                                    )
                                )
                                .strokeBorder(.white, lineWidth: isSelected ? .baseLineWidth : .zero)
                                .shadow(color: .gray, radius: .baseLineWidth)
                            }
                            .onTapGesture {
                                selectedColor.wrappedValue = color
                            }
                        }
                    }
                }
            }
        }
    }
    // swiftlint: enable: closure_body_length
}

#Preview {
    @State var color = Color.blue
    return ColorGrid(selectedColor: $color)
}
