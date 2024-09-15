//
//  ChatDetailDrawer.swift
//  Feature
//
//  Created by hhhello0507 on 9/12/24.
//  Copyright © 2024 apeun-gidaechi. All rights reserved.
//

import SwiftUI
import Component
import Domain

struct ChatDetailDrawer: View {
    enum Action {
        case leftRoom
    }
    
    let room: Room
    let action: (Action) -> Void
    
    var body: some View {
        VStack(spacing: 0) {
            Text("멤버")
                .padding(.leading, 16)
                .font(.subtitle(.s2))
                .frame(height: 40)
                .frame(maxWidth: .infinity, alignment: .leading)
            SeugiDivider(thickness: .thin)
            ScrollView {
                LazyVStack(spacing: 0) {
                    SeugiMemberList(type: .invitation)
                    ForEach(room.joinUserId, id: \.id) { member in
                        SeugiMemberList(type: .normal(member: member, role: member.id == room.roomAdmin ? .admin : .student))
                    }
                }
            }
            Spacer()
            SeugiDivider(thickness: .thin)
            HStack(spacing: 16) {
                if room.type == .group {
                    makeImageButton(.logoutLine) {
                        action(.leftRoom)
                    }
                }
                Spacer()
                makeImageButton(.notificationFill) {
                    // TODO: handle
                }
                makeImageButton(.settingFill) {
                    // TODO: handle
                }
            }
            .padding(.horizontal, 16)
            .frame(height: 40)
        }
    }
    
    @ViewBuilder
    private func makeImageButton(
        _ icon: SeugiIconography,
        action: @escaping () -> Void
    ) -> some View {
        Button {
            action()
        } label: {
            Image(icon: icon)
                .resizable()
                .renderingMode(.template)
                .frame(width: 28, height: 28)
                .seugiColor(.gray(.g600))
        }
    }
}
