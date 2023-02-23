import XCTest
@testable import InventoryApp

final class VanillaTests: XCTestCase {

    func testFirstTabModel() {
        let model = FirstTabModel()
        
        let expectation = self.expectation(description: "goToInventoryTab")
        model.goToInventoryTab = {
            expectation.fulfill()
        }
        
        model.goToInventoryButtonTapped()
        
        self.wait(for: [expectation], timeout: 0)
    }
    
    func testAppModel() {
        let model = AppModel(firstTab: FirstTabModel())
        
        model.firstTab.goToInventoryButtonTapped()
        
        XCTAssertEqual(model.selectdTab, .inventory)
    }

}
