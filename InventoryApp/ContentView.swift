//
//  ContentView.swift
//  InventoryApp
//
//  Created by mark on 2/21/23.
//

import ComposableArchitecture
import SwiftUI

struct AppFeature: Reducer {
    struct State: Equatable {
        var selectedTab: Tab = .one
        var firstTab = FirstTabFeature.State()
        var inventoryTab = InventoryFeature.State()
        var thirdTab = ThirdTabFeature.State()
    }
    enum Action: Equatable {
        case firstTab(FirstTabFeature.Action)
        case inventoryTab(InventoryFeature.Action)
        case thirdTab(ThirdTabFeature.Action)
        case selectedTabChanged(Tab)
    }
    
    var body: some ReducerOf<Self> {
        Reduce<State, Action> { state, action in
            switch action {
            case let .firstTab(.delegate(action)):
                switch action {
                case .switchToInventoryTab:
                    state.selectedTab = .inventory
                    return .none
                }

            case let .selectedTabChanged(tab):
                state.selectedTab = tab
                return .none
                
            case .firstTab, .inventoryTab, .thirdTab:
                return .none
            }
            

        }
        Scope(state: \.firstTab, action: /Action.firstTab) {
            FirstTabFeature()
        }
        Scope(state: \.inventoryTab, action: /Action.inventoryTab) {
            InventoryFeature()
        }
        Scope(state: \.thirdTab, action: /Action.thirdTab) {
            ThirdTabFeature()
        }
        
    }
}


enum Tab {
    case one
    case inventory
    case three
}

struct ContentView: View {
    let store: StoreOf<AppFeature>
    
    var body: some View {
        WithViewStore(self.store, observe: \.selectedTab) { viewStore in
            
            TabView(selection: viewStore.binding(send: AppFeature.Action.selectedTabChanged)) {
                
                FirstTabView(
                    store: self.store.scope(
                        state: \.firstTab,
                        action: AppFeature.Action.firstTab
                    )
                )
                .tabItem { Text("One") }
                .tag(Tab.one)
                
                InventoryView(
                    store: self.store.scope(
                        state: \.inventoryTab,
                        action: AppFeature.Action.inventoryTab
                    )
                )
                    .tabItem { Text("Inventory") }
                    .tag(Tab.inventory)
                
                ThirdTab(
                    store: self.store.scope(
                        state: \.thirdTab,
                        action: AppFeature.Action.thirdTab
                    )
                )
                    .tabItem { Text("Three") }
                    .tag(Tab.three)
            }
            .padding()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(
            store: Store(
                initialState:
                    AppFeature.State(),
                reducer: AppFeature()
            )
        )
    }
}
