//import WidgetKit
//import SwiftUI
//import Component
//
//public struct MealWidget: Widget {
//    private let widgetFamilyList: [WidgetFamily] = if #available(iOSApplicationExtension 16.0, *) {
//        [.systemSmall, .systemMedium, .accessoryRectangular, .accessoryCircular]
//    } else {
//        [.systemSmall, .systemMedium]
//    }
//    public static let kind = "Meal_Widget"
//    
//    public init() {}
//    
//    public var body: some WidgetConfiguration {
//        StaticConfiguration(
//            kind: Self.kind,
//            provider: MealProvider()
//        ) { entry in
//            MealWidgetEntryView(entry: entry)
//                .safeContainerBackground(color: Colors.Background.neutral)
//        }
//        .configurationDisplayName("급식")
//        .description("오늘 우리 학교 급식은?")
//        .contentMarginsDisabled()
//        .supportedFamilies(widgetFamilyList)
//    }
//}
