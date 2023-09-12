//
//  GistsViewModel.swift
//  RestApi
//
//  Created by CHEBIHI FAYCAL on 12/9/2023.
//

import Foundation

final class GistsViewModel : ObservableObject {
    
    init()
    {
        DataService.shared.fetchGists()
    }
}
