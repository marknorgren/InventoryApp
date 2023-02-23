import ComposableArchitecture
import XCTest
@testable import InventoryApp

@MainActor
final class InventoryAppTests: XCTestCase {
    
    func testGoToInventory() async {
        let store = TestStore(
            initialState: AppFeature.State(),
            reducer: AppFeature()
        )
        
        await store.send(.firstTab(.goToInventoryButtonTapped))
        //        store.receive(.firstTab(.delegate(.switchToInventoryTab)))
        await store.receive(.firstTab(.delegate(.switchToInventoryTab))) {
            $0.selectedTab = .inventory
        }
            // STEP 3 - ACTIONS Equatable
            
        // STEP 2
//            (/AppFeature.Action.firstTab).appending(path: /FirstTabFeature.Action.delegate)) {
//                $0.selectedTab = .inventory
//            }
        // STEP 1
        //            guard case .firstTab(.delegate(.switchToInventoryTab)) = $0
        //            else { return false }
        //            return true
        //        } assert: {
        //            $0.selectedTab = .inventory
        //        }
    }
}
