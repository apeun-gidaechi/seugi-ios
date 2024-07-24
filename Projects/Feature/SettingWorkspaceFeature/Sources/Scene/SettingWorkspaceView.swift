import SwiftUI
import Component
import BaseFeatureInterface
import SettingWorkspaceFeatureInterface

public struct SettingWorkspaceView: View {
    
    @EnvironmentObject private var router: Router
    
    public var body: some View {
        ScrollView {
            LazyVStack(spacing: 0) {
                SettingWorkspaceHeadline(icon: .settingFill)
                    .padding(.top, 6)
                SeugiListItem.icon(title: "일반", icon: .expandRightLine)
                    .button {
                        //
                    }
                    .applyAnimation()
                SeugiListItem.icon(title: "알림 설정", icon: .expandRightLine)
                    .button {
                        //
                    }
                    .applyAnimation()
                SettingWorkspaceHeadline(icon: .personFill)
                    .padding(.top, 24)
                SeugiListItem.icon(title: "멤버 관리", icon: .expandRightLine)
                    .button {
                        router.navigate(to: SettingWorkspaceDestination.manageMember)
                    }
                    .applyAnimation()
                SeugiListItem.icon(title: "멤버 초대", icon: .expandRightLine)
                    .button {
                        //
                    }
                    .applyAnimation()
            }
        }
        .scrollIndicators(.hidden)
        .seugiTopBar("학교 설정")
    }
}
