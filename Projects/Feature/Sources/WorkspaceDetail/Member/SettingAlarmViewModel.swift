//
//  SettingAlarmViewModel.swift
//  Feature
//
//  Created by hhhello0507 on 9/11/24.
//  Copyright © 2024 apeun-gidaechi. All rights reserved.
//

import Foundation
import DIContainer
import Domain

final class SettingAlarmViewModel: BaseViewModel<SettingAlarmViewModel.Effect> {
    enum Effect {}
    @Inject private var keyValueRepo: KeyValueRepo
    
    @Published var allowAlarm: Bool = true
    
    override init() {
        super.init()
        if let allowAlarm = keyValueRepo.load(key: .allowAlarm) as? Bool {
            self.allowAlarm = allowAlarm
        }
        $allowAlarm.sink { _ in
            self.fetchAllowAlarm()
        }.store(in: &subscriptions)
    }
    
    func fetchAllowAlarm() {
        // TODO: Implemention
    }
}
