import ComposableArchitecture
import SwiftUI

struct ThirdTabFeature: Reducer {
    struct State: Equatable {}
    enum Action: Equatable {}
    
    func reduce(into state: inout State, action: Action) -> Effect<Action> {
        
    }
}

struct ThirdTab: View {
    let store: StoreOf<ThirdTabFeature>
    var body: some View {
        Text("Three")    }
}

//struct ThirdTab_Previews: PreviewProvider {
//    static var previews: some View {
//        ThirdTab()
//    }
//}
