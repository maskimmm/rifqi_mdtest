//
//  ContentView.swift
//  mdtest
//
//  Created by Rifqi Alhakim Hariyantoputera on 05/06/24.
//

import SwiftUI

struct ContentView: View {
    private let firebase: FirebaseService = FirebaseService.shared
    @State private var auth: AuthManager = AuthManager.shared
    
    var body: some View {
        if auth.isAuth {
            HomepageScreenView()
        } else {
            LoginScreenView()
        }
    }
}

#Preview {
    ContentView()
}
