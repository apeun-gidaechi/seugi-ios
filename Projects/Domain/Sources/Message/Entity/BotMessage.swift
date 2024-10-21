// - 이 코드는 왜 더러운가?
// - 단기적 목표만 이루는 것을 추구하고 포트폴리오용 프로젝트를 양성하려는 학교 분위기 => 다가오는 마감기한, 리팩토링 부족, 그냥 서비스 전반 설계가 잘못됨.
// - 나중에 삭제될 코드.
public struct BotMessage: Entity {
    public enum MessageType: String, Entity {
        case meal = "급식"
        case schedule = "시간표"
        case notification = "공지"
        case pickMember = "사람 뽑기"
        case teamBuilding = "팀짜기"
        case etc = "기타"
    }
    
    public enum MessageData: Entity {
        case meal([Meal])
        case schedule([Timetable])
        case notification(Domain.Notification)
        case pickMember(String)
        case teamBuilding(String)
        case etc(String)
    }
    
    public let keyword: MessageType
    public let data: MessageData
    
    enum CodingKeys: CodingKey {
        case keyword
        case data
    }
    
    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.keyword = try container.decode(BotMessage.MessageType.self, forKey: .keyword)
        switch self.keyword {
        case .meal:
            let mealData = try container.decode([Meal].self, forKey: .data)
            self.data = .meal(mealData)
            
        case .schedule:
            let scheduleData = try container.decode([Timetable].self, forKey: .data)
            self.data = .schedule(scheduleData)
            
        case .notification:
            let notificationData = try container.decode(Domain.Notification.self, forKey: .data)
            self.data = .notification(notificationData)
            
        case .pickMember:
            let memberData = try container.decode(String.self, forKey: .data)
            self.data = .pickMember(memberData)
            
        case .teamBuilding:
            let teamBuildingData = try container.decode(String.self, forKey: .data)
            self.data = .teamBuilding(teamBuildingData)
            
        case .etc:
            let etcData = try container.decode(String.self, forKey: .data)
            self.data = .etc(etcData)
        }
    }
}

