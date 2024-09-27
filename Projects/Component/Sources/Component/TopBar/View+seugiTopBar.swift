import SwiftUI

public struct SeugiTopBarView: View {
    
    @State private var isTextField = false
    @Namespace private var animation
    @Environment(\.dismiss) private var dismiss
    
    private let title: String
    private let showShadow: Bool
    private let showBackButton: Bool
    private let showTitle: Bool
    private let background: Color
    private let tintColor: Color
    private let subView: AnyView?
    private let buttons: [SeugiTopBarButton]
    private let onBackAction: (() -> Void)?
    private let content: AnyView
    
    private var showMergedBackButton: Bool {
        showBackButton || isTextField
    }
    
    public init(
        title: String,
        showShadow: Bool,
        showBackButton: Bool,
        showTitle: Bool,
        background: Color,
        tintColor: Color,
        subView: AnyView? = nil,
        buttons: [SeugiTopBarButton],
        onBackAction: (() -> Void)?,
        content: AnyView
    ) {
        self.title = title
        self.showShadow = showShadow
        self.showBackButton = showBackButton
        self.showTitle = showTitle
        self.background = background
        self.tintColor = tintColor
        self.subView = subView
        self.buttons = buttons
        self.onBackAction = onBackAction
        self.content = content
    }
    
    public var body: some View {
        ZStack {
            background.ignoresSafeArea()
            VStack(spacing: 0) {
                HStack(spacing: 0) {
                    if showMergedBackButton {
                        Image(icon: .expandLeftLine)
                            .resizable()
                            .renderingMode(.template)
                            .foregroundStyle(tintColor)
                            .frame(width: 24, height: 24)
                            .button {
                                if let onBackAction {
                                    onBackAction()
                                } else {
                                    dismiss()
                                }
                            }
                            .applyAnimation()
                            .matchedGeometryEffect(id: "backbutton", in: animation)
                    }
                    
                    if showTitle {
                        Text(title)
                            .font(showMergedBackButton ? .subtitle(.s2) : .title(.t2))
                            .foregroundStyle(tintColor)
                            .if(showMergedBackButton) {
                                $0.padding(.leading, 12)
                            } else: {
                                $0.padding(.leading, 8)
                            }
                            .matchedGeometryEffect(id: "title", in: animation)
                    }
                    
                    Spacer()
                    
                    subView
                    
                    HStack(spacing: 16) {
                        ForEach(buttons.indices, id: \.self) { idx in
                            let button = buttons[idx]
                            Button {
                                button.action()
                            } label: {
                                Image(icon: button.icon)
                                    .resizable()
                                    .renderingMode(.template)
                                    .foregroundStyle(tintColor)
                                    .frame(width: 28, height: 28)
                            }
                        }
                    }
                }
                .frame(height: 54)
                .padding(.horizontal, 16)
                .navigationBarBackButtonHidden()
                .if(showShadow) {
                    $0.shadow(.evBlack(.ev1))
                }
                content
                    .navigationBarBackButtonHidden()
            }
        }
    }
    
    public func button(_ icon: SeugiIconography, action: @escaping () -> Void) -> SeugiTopBarView {
        let button = SeugiTopBarButton(icon: icon, action: action)
        return Self.init(title: title,
                         showShadow: showShadow,
                         showBackButton: showBackButton,
                         showTitle: showTitle,
                         background: background,
                         tintColor: tintColor,
                         subView: subView,
                         buttons: buttons + [button],
                         onBackAction: onBackAction,
                         content: content
        )
    }
    
    public func showShadow(_ condition: Bool = true) -> SeugiTopBarView {
        Self.init(title: title,
                  showShadow: condition,
                  showBackButton: showBackButton,
                  showTitle: showTitle,
                  background: background,
                  tintColor: tintColor,
                  subView: subView,
                  buttons: buttons,
                  onBackAction: onBackAction,
                  content: content
        )
    }
    
    public func subView<S: View>(@ViewBuilder content: @escaping () -> S) -> SeugiTopBarView {
        Self.init(title: title,
                  showShadow: showShadow,
                  showBackButton: showBackButton,
                  showTitle: showTitle,
                  background: background,
                  tintColor: tintColor,
                  subView: AnyView(content()),
                  buttons: buttons,
                  onBackAction: onBackAction,
                  content: self.content
        )
    }
    
    public func hideBackButton(_ condition: Bool = true) -> SeugiTopBarView {
        Self.init(title: title,
                  showShadow: showShadow,
                  showBackButton: !condition,
                  showTitle: showTitle,
                  background: background,
                  tintColor: tintColor,
                  subView: subView,
                  buttons: buttons,
                  onBackAction: onBackAction,
                  content: content
        )
    }
    
    public func hideTitle(_ condition: Bool = true) -> SeugiTopBarView {
        Self.init(title: title,
                  showShadow: showShadow,
                  showBackButton: showBackButton,
                  showTitle: !condition,
                  background: background,
                  tintColor: tintColor,
                  subView: subView,
                  buttons: buttons,
                  onBackAction: onBackAction,
                  content: content
        )
    }
}

public extension View {
    func seugiTopBar(
        _ title: String,
        background: Color = Color.seugi(.sub(.white)),
        tintColor: Color = Color.seugi(.sub(.black)),
        onBackAction: (() -> Void)? = nil
    ) -> SeugiTopBarView {
        SeugiTopBarView(
            title: title,
            showShadow: false,
            showBackButton: true,
            showTitle: true,
            background: background,
            tintColor: tintColor,
            buttons: [],
            onBackAction: onBackAction,
            content: AnyView(self)
        )
    }
}
