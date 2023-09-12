//
//  RestApiApp.swift
//  RestApi
//
//  Created by CHEBIHI FAYCAL on 12/9/2023.
//

import SwiftUI

@main
struct RestApiApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: GistsViewModel())
        }
    }
}
