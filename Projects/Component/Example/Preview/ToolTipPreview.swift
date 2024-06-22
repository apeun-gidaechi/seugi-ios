import SwiftUI
import Component

struct ToolTipPreview: View {
    var body: some View {
        VStack {
            ForEach(SeugiToolTipType.allCases, id: \.self) { type in
                ForEach(SeugiToolTipType.Size.allCases, id: \.self) { size in
                    ForEach(SeugiToolTipType.Direction.allCases, id: \.self) { direction in
                        SeugiToolTip(type: type, size: size, direction: direction, text: size == .large ? "가입 수락을 대기중이에요" : "답장")
                    }
                }
            }
        }
    }
}
