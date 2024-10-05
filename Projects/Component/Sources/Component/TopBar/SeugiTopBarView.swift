import SwiftUI
import SwiftUIUtil

public struct SeugiTopBarView {
    @Environment(\.dismiss) private var dismiss
    @Namespace private var animation
    
    private let title: String?
    private let colors: Colors
    private let showShadow: Bool
    private let showBackButton: Bool
    private let buttons: [SeugiTopBarButton]
    private let subView: AnyView
    private let onBackAction: (() -> Void)?
    private let content: AnyView
    
    public init<SubView: View>(
        title: String?,
        colors: Colors,
        showShadow: Bool,
        showBackButton: Bool,
        buttons: [SeugiTopBarButton],
        @ViewBuilder subView: @escaping () -> SubView,
        onBackAction: (() -> Void)?,
        content: AnyView
    ) {
        self.title = title
        self.showShadow = showShadow
        self.showBackButton = showBackButton
        self.colors = colors
        self.subView = AnyView(subView())
        self.buttons = buttons
        self.onBackAction = onBackAction
        self.content = content
    }
}

extension SeugiTopBarView: View {
    public var body: some View {
        ZStack {
            colors.backgroundColor.ignoresSafeArea()
            VStack(spacing: 0) {
                topBarContent
                content
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            }
        }
    }
    
    private var topBarContent: some View {
        HStack(spacing: 0) {
            if showBackButton {
                SwiftUI.Button(action: backButtonAction) {
                    Image(icon: .expandLeftLine)
                        .resizable()
                        .renderingMode(.template)
                        .foregroundStyle(colors.tintColor)
                        .frame(width: 24, height: 24)
                }
                .applyAnimation()
                .matchedGeometryEffect(id: "backbutton", in: animation)
            }
            if let title {
                Text(title)
                    .font(showBackButton ? .subtitle(.s2) : .title(.t2))
                    .foregroundStyle(colors.tintColor)
                    .padding(.leading, showBackButton ? 12 : 8)
                    .matchedGeometryEffect(id: "title", in: animation)
            }
            Spacer()
            subView
            HStack(spacing: 16) {
                ForEach(buttons.indices, id: \.self) { idx in
                    let button = buttons[idx]
                    SwiftUI.Button(action: button.action) {
                        Image(icon: button.icon)
                            .resizable()
                            .renderingMode(.template)
                            .foregroundStyle(colors.tintColor)
                            .frame(width: 28, height: 28)
                    }
                }
            }
        }
        .frame(height: 54)
        .padding(.horizontal, 16)
        .if(showShadow) {
            $0.shadow(.evBlack(.ev1))
        }
    }
    
    func backButtonAction() {
        if let onBackAction {
            onBackAction()
        } else {
            dismiss()
        }
    }
    
    public func buttons(
        @SeugiTopBarButton.Builder buttons: () -> [SeugiTopBarButton]
    ) -> Self {
        SeugiTopBarView(
            title: title,
            colors: colors,
            showShadow: showShadow,
            showBackButton: showBackButton,
            buttons: buttons(),
            subView: { subView },
            onBackAction: onBackAction,
            content: content
        )
    }
}

public extension SeugiTopBarView {
    struct Colors {
        public let backgroundColor: Color
        public let tintColor: Color
        
        public init(backgroundColor: Color, tintColor: Color) {
            self.backgroundColor = backgroundColor
            self.tintColor = tintColor
        }
        
        public static let `default` = Colors(
            backgroundColor: .seugi(.sub(.white)),
            tintColor: .seugi(.sub(.black))
        )
        
        public func copy(backgroundColor: Color? = nil, tintColor: Color? = nil) -> Self {
            return Colors(
                backgroundColor: backgroundColor ?? self.backgroundColor,
                tintColor: tintColor ?? self.tintColor
            )
        }
    }
}

public extension View {
    func seugiTopBar<SubView: View>(
        title: String?,
        colors: SeugiTopBarView.Colors = .default,
        showShadow: Bool = false,
        showBackButton: Bool = true,
        @ViewBuilder subView: @escaping () -> SubView = { EmptyView() },
        onBackAction: (() -> Void)? = nil
    ) -> SeugiTopBarView {
        SeugiTopBarView(
            title: title,
            colors: colors,
            showShadow: showShadow,
            showBackButton: showBackButton,
            buttons: [],
            subView: subView,
            onBackAction: onBackAction,
            content: SwiftUI.AnyView(self)
        )
    }
}
