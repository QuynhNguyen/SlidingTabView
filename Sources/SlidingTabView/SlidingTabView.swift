//
//  SlidingTabView.swift
//
//  Copyright (c) 2019 Quynh Nguyen
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

import SwiftUI

public struct SlidingTabView : View {
    
    // MARK: Internal State
    
    /// Internal state to keep track of the selection index
    @State private var selectionState: Int = 0 {
        didSet {
            selection = selectionState
        }
    }
    
    // MARK: Required Properties
    
    /// Binding the selection index which will  re-render the consuming view
    @Binding var selection: Int
    
    /// The list of tabs
    let tabs: [SlidingTab]
    
    // Mark: View Customization Properties
    
    /// The font of the tab title
    let font: Font
    
    /// The selection bar sliding animation type
    let animation: Animation
    
    /// The accent color when the tab is selected
    let activeAccentColor: Color
    
    /// The accent color when the tab is not selected
    let inactiveAccentColor: Color
    
    /// The height of the tabs.
    let tabHeight: CGFloat
    
    /// The color of the selection bar
    let selectionBarColor: Color
    
    /// The tab color when the tab is not selected
    let inactiveTabColor: Color
    
    /// The tab color when the tab is  selected
    let activeTabColor: Color
    
    /// The height of the selection bar
    let selectionBarHeight: CGFloat
    
    /// The selection bar background color
    let selectionBarBackgroundColor: Color
    
    /// The height of the selection bar background
    let selectionBarBackgroundHeight: CGFloat
    
    // MARK: init
    
    public init(selection: Binding<Int>,
                tabs: SlidingTab...,
                font: Font = .body,
                animation: Animation = .spring(),
                activeAccentColor: Color = .blue,
                inactiveAccentColor: Color = Color.black.opacity(0.4),
                tabHeight: CGFloat = 50,
                selectionBarColor: Color = .blue,
                inactiveTabColor: Color = .clear,
                activeTabColor: Color = .clear,
                selectionBarHeight: CGFloat = 2,
                selectionBarBackgroundColor: Color = Color.gray.opacity(0.2),
                selectionBarBackgroundHeight: CGFloat = 1) {
        self._selection = selection
        self.tabs = tabs
        self.font = font
        self.animation = animation
        self.activeAccentColor = activeAccentColor
        self.inactiveAccentColor = inactiveAccentColor
        self.tabHeight = tabHeight
        self.selectionBarColor = selectionBarColor
        self.inactiveTabColor = inactiveTabColor
        self.activeTabColor = activeTabColor
        self.selectionBarHeight = selectionBarHeight
        self.selectionBarBackgroundColor = selectionBarBackgroundColor
        self.selectionBarBackgroundHeight = selectionBarBackgroundHeight
    }
    
    // MARK: View Construction
    
    public var body: some View {
        assert(tabs.count > 1, "Must have at least 2 tabs")
        
        return ZStack {
            
            VStack(alignment: .leading, spacing: 0) {
                
                Group {
                    HStack(spacing: 0) {
                        
                        ForEach(0..<self.tabs.count) { (index) in
                            
                            let tab = tabs[index]
                            
                            Button(action: {
                                
                                self.selectionState = index
                                
                            }) {
                                HStack {
                                    Spacer()
                                    Text(tab.title).font(self.font)
                                    Spacer()
                                }
                            }
                            .frame(height: self.tabHeight)
                            .foregroundColor(
                                self.isSelected(tabIndex: index)
                                    ? self.activeAccentColor
                                    : self.inactiveAccentColor)
                            .background(
                                self.isSelected(tabIndex: index)
                                    ? self.activeTabColor
                                    : self.inactiveTabColor)
                        }
                    }
                    GeometryReader { geometry in
                        ZStack(alignment: .leading) {
                            Rectangle()
                                .fill(self.selectionBarColor)
                                .frame(width: self.tabWidth(from: geometry.size.width), height: self.selectionBarHeight, alignment: .leading)
                                .offset(x: self.selectionBarXOffset(from: geometry.size.width), y: 0)
                                .animation(self.animation)
                            Rectangle()
                                .fill(self.selectionBarBackgroundColor)
                                .frame(width: geometry.size.width, height: self.selectionBarBackgroundHeight, alignment: .leading)
                        }.fixedSize(horizontal: false, vertical: true)
                    }.fixedSize(horizontal: false, vertical: true)
                    Spacer()
                }
            }
            
            let tab = tabs[selectionState]
            tab.content().offset(y: self.tabHeight + self.selectionBarHeight)
            
        }
    }
    
    // MARK: Private Helper
    
    private func isSelected(tabIndex: Int) -> Bool {
        return selectionState == tabIndex
    }
    
    private func selectionBarXOffset(from totalWidth: CGFloat) -> CGFloat {
        return self.tabWidth(from: totalWidth) * CGFloat(selectionState)
    }
    
    private func tabWidth(from totalWidth: CGFloat) -> CGFloat {
        return totalWidth / CGFloat(tabs.count)
    }
}

#if DEBUG
struct SlidingTabView_Previews : PreviewProvider {
    
    @State static var selectedTab = 0
    
    static var previews: some View {
        SlidingTabView(
            selection: $selectedTab,
            tabs: SlidingTab(title: "Hello") {
                
                Text("Hello")
                
            },
            SlidingTab(title: "World!") {
                
                Text("World!")
                
            },
            font: .body,
            activeAccentColor: Color.blue,
            selectionBarColor: Color.blue
        )
    }
}
#endif
