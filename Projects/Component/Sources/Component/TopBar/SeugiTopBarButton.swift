public struct SeugiTopBarButton {
    public let icon: SeugiIconography
    public let action: () -> Void
    
    public init(icon: SeugiIconography, action: @escaping () -> Void) {
        self.icon = icon
        self.action = action
    }
    
    @resultBuilder
    public struct Builder {
        public static func buildBlock(_ components: SeugiTopBarButton...) -> [SeugiTopBarButton] {
            return components
        }
        
        public static func buildEither(first component: [SeugiTopBarButton]) -> [SeugiTopBarButton] {
            return component
        }
        
        public static func buildEither(second component: [SeugiTopBarButton]) -> [SeugiTopBarButton] {
            return component
        }
        
        public static func buildOptional(_ component: [SeugiTopBarButton]?) -> [SeugiTopBarButton] {
            return component ?? []
        }
        
        public static func buildExpression(_ expression: SeugiTopBarButton) -> [SeugiTopBarButton] {
            return [expression]
        }
        
        public static func buildBlock(_ components: [SeugiTopBarButton]...) -> [SeugiTopBarButton] {
            return components.flatMap(\.self)
        }
    }
}
