import Domain

struct EmojiRes: SeugiResponse {
    let emojiId: Int?
    let userId: [Int]
    
    func toEntity() -> Emoji {
        Emoji(
            emojiId: emojiId, 
            userId: userId
        )
    }
}
