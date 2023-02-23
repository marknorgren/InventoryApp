import SwiftUI
import Foundation
import XCTestDynamicOverlay

class AppModel: ObservableObject {
    @Published var selectdTab: Tab = .one
    @Published var firstTab: FirstTabModel {
        didSet { self.bind() }
    }
    
    init(
        firstTab: FirstTabModel,
        selectedTab: Tab = .one
    ) {
        self.firstTab = firstTab
        self.selectdTab = selectedTab
        
        self.bind()
    }
    
    private func bind() {
        self.firstTab.goToInventoryTab = { [weak self] in
            self?.selectdTab = .inventory
        }
    }
    
}


class FirstTabModel: ObservableObject {
    var goToInventoryTab: () -> Void = unimplemented("FirstTabModel.goToInventoryTab")
    
    func goToInventoryButtonTapped() {
        self.goToInventoryTab()
    }
}
