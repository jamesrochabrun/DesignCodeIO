//
//  UpdateStore.swift
//  SwiftUIDesignCodeIO
//
//  Created by james rochabrun on 11/16/20.
//

import SwiftUI
import Combine

final class UpdateStore: ObservableObject {
    
    @Published var updates: [Update] = updateData
    
    
    
}
