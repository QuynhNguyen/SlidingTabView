//
//  File.swift
//  
//
//  Created by Tim Fraedrich on 17.01.21.
//

import Foundation
import SwiftUI

public struct SlidingTab {
    
    public let title: String
    public let content: () -> AnyView
    
    public init<Content: View>(title: String, @ViewBuilder content: @escaping () -> Content) {
        
        self.title = title
        self.content = {
            AnyView(content())
        }
        
    }
    
}
