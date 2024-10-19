import WidgetKit
import Domain

struct TimetableEntry: TimelineEntry {
    let date: Date
    let timetables: [Timetable]?
}

extension TimetableEntry {
    static let dummy = TimetableEntry(
        date: .now,
        timetables: .dummy
    )
    
    static func of(_ date: Date) -> TimetableEntry {
        TimetableEntry(
            date: date,
            timetables: nil
        )
    }
}

extension [Timetable] {
    static let dummy: [Timetable] = [
        Timetable(
            id: 1,
            workspaceId: "",
            grade: "1",
            classNum: "2",
            time: "1",
            subject: "수학",
            date: .now
        ),
        Timetable(
            id: 2,
            workspaceId: "",
            grade: "1",
            classNum: "2",
            time: "2",
            subject: "국어",
            date: .now
        ),
        Timetable(
            id: 1,
            workspaceId: "",
            grade: "1",
            classNum: "2",
            time: "3",
            subject: "과학",
            date: .now
        ),
        Timetable(
            id: 1,
            workspaceId: "",
            grade: "1",
            classNum: "2",
            time: "4",
            subject: "영어",
            date: .now
        ),
        Timetable(
            id: 1,
            workspaceId: "",
            grade: "1",
            classNum: "2",
            time: "5",
            subject: "미술",
            date: .now
        )
    ]
}
/**
 [
   {
     "id": 1493,
     "workspaceId": "669e339593e10f4f59f8c583",
     "grade": "1",
     "classNum": "2",
     "time": "1",
     "subject": "토요휴업일",
     "date": "2024-10-19"
   },
   {
     "id": 1494,
     "workspaceId": "669e339593e10f4f59f8c583",
     "grade": "1",
     "classNum": "2",
     "time": "2",
     "subject": "토요휴업일",
     "date": "2024-10-19"
   },
   {
     "id": 1495,
     "workspaceId": "669e339593e10f4f59f8c583",
     "grade": "1",
     "classNum": "2",
     "time": "3",
     "subject": "토요휴업일",
     "date": "2024-10-19"
   },
   {
     "id": 1496,
     "workspaceId": "669e339593e10f4f59f8c583",
     "grade": "1",
     "classNum": "2",
     "time": "4",
     "subject": "토요휴업일",
     "date": "2024-10-19"
   }
 ]
 */
