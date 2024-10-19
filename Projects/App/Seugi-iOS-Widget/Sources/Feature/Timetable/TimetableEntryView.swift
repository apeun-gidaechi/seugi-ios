import SwiftUI
import Component
import SwiftUtil

struct TimetableEntryView: View {
    @Environment(\.widgetFamily) private var widgetFamily
    
    private let entry: TimetableEntry
    
    init(for entry: TimetableEntry) {
        self.entry = entry
    }
    
    var body: some View {
        VStack(spacing: 4) {
            HStack(spacing: 0) {
                Text("시간표")
                    .seugiColor(.sub(.white))
                    .padding(.horizontal, 10)
                    .padding(.vertical, 4)
                    .seugiBackground(.primary(.p500))
                    .cornerRadius(14, corners: .allCorners)
                    .font(.footnote)
                Spacer()
                Text(Date.now.parseString("MM.dd"))
                    .font(.caption)
                    .seugiColor(.gray(.g600))
            }
            VStack(alignment: .leading, spacing: 0) {
                if let timetables = entry.timetables {
                    if timetables.isEmpty {
                        TimetableSubjectText(text: "오늘은\n급식이 없어요", isTimetableEmpty: true)
                    } else {
                        HStack(spacing: 8) {
                            if widgetFamily == .systemSmall {
                                VStack(alignment: .leading, spacing: 0) {
                                    ForEach(0..<min(timetables.count, 6), id: \.self) { idx in
                                        TimetableSubjectText(
                                            text: String(timetables.count > 6 && idx == 6 ? "..." : timetables[idx].subject)
                                        )
                                    }
                                }
                            } else {
                                ForEach(Array.from(timetables.splitArray(position: 6)), id: \.self) { timetables in
                                    VStack(alignment: .leading, spacing: 0) {
                                        ForEach(timetables, id: \.self) { timetable in
                                            TimetableSubjectText(text: String(timetable.subject))
                                        }
                                    }
                                }
                            }
                        }
                    }
                } else {
                    TimetableSubjectText(text: "급식을\n불러올 수 없어요", isTimetableEmpty: true)
                }
            }
            .padding(8)
            .frame(maxHeight: .infinity)
            .seugiBackground(.gray(.g200))
            .cornerRadius(18, corners: .allCorners)
            .shadow(.evBlack(.ev2))
        }
        .padding(8)
        .seugiBackground(.gray(.g100))
    }
}
