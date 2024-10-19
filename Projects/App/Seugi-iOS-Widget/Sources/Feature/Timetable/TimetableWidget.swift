import WidgetKit
import SwiftUI
import Domain
import Component

struct TimetableWidget: Widget {
    private let widgetFamilyList: [WidgetFamily] = if #available(iOSApplicationExtension 16.0, *) {
        [.systemSmall, .systemMedium, .accessoryRectangular, .accessoryCircular]
    } else {
        [.systemSmall, .systemMedium]
    }
    public static let kind = "Timetable_Widget"
    
    var body: some WidgetConfiguration {
        StaticConfiguration(
            kind: Self.kind,
            provider: TimetableProvider()
        ) { entry in
            TimetableEntryView(for: entry)
                .safeContainerBackground(color: .gray(.g100))
        }
        .configurationDisplayName("시간표")
        .description("오늘 우리 학교 시간표는?")
        .contentMarginsDisabled()
        .supportedFamilies(widgetFamilyList)
    }
}
