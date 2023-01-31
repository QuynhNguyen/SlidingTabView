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
import ViewExtractor

@available(iOS 14.0, *)
public struct SlidingTabView<Content:View>: View{

    // MARK: Required Properties
    
    /// Binding the selection index which will  re-render the consuming view
    @Binding var selection: Int
    
    /// The title of the tabs
    let tabs: [String]
    
    let content: () -> Content

    // MARK: View Customization Properties
    
    /// The font of the tab title
    let font: Font
    
    /// The selection bar sliding animation type
    let animation: Animation
    
    /// The accent color when the tab is selected
    let activeAccentColor: Color
    
    /// The accent color when the tab is not selected
    let inactiveAccentColor: Color
    
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
                tabs: [String],
                font: Font = .body,
                animation: Animation = .spring(),
                activeAccentColor: Color = .blue,
                inactiveAccentColor: Color = Color.black.opacity(0.4),
                selectionBarColor: Color = .blue,
                inactiveTabColor: Color = .clear,
                activeTabColor: Color = .clear,
                selectionBarHeight: CGFloat = 2,
                selectionBarBackgroundColor: Color = Color.gray.opacity(0.2),
                selectionBarBackgroundHeight: CGFloat = 1,
                @ViewBuilder content: @escaping () -> Content) {
        self._selection = selection
        self.tabs = tabs
        self.font = font
        self.animation = animation
        self.activeAccentColor = activeAccentColor
        self.inactiveAccentColor = inactiveAccentColor
        self.selectionBarColor = selectionBarColor
        self.inactiveTabColor = inactiveTabColor
        self.activeTabColor = activeTabColor
        self.selectionBarHeight = selectionBarHeight
        self.selectionBarBackgroundColor = selectionBarBackgroundColor
        self.selectionBarBackgroundHeight = selectionBarBackgroundHeight
        self.content = content
    }
    
    // MARK: View Construction
    
    private var tabsView: some View {
        VStack(alignment: .leading, spacing: 0) {
            
            HStack(spacing: 0) {
                ForEach(self.tabs, id:\.self) { tab in
                    Button{
                        withAnimation(self.animation) {
                            self.selection =  self.tabs.firstIndex(of: tab)!
                        }
                    } label: {
                        HStack {
                            Spacer()
                            Text(tab).font(self.font)
                            Spacer()
                        }
                    }
                    .frame(height: 52)
                    .accentColor(
                        self.isSelected(tabIdentifier: tab)
                        ? self.activeAccentColor
                        : self.inactiveAccentColor)
                    .background(
                        self.isSelected(tabIdentifier: tab)
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
                    
                    Rectangle()
                        .fill(self.selectionBarBackgroundColor)
                        .frame(width: geometry.size.width, height: self.selectionBarBackgroundHeight, alignment: .leading)
                }.fixedSize(horizontal: false, vertical: true)
            }.fixedSize(horizontal: false, vertical: true)
            
        }
    }
    
    public var body: some View {
        assert(tabs.count > 1, "Must have at least 2 tabs")
        
        return VStack(alignment: .leading) {
            tabsView
            Extract(content) { views in
                TabView(selection: $selection.animation(self.animation)) {
                    ForEach(Array(zip(views.indices, views)), id: \.1.id) {index, view in
                        view.tag(index)
                    }
                }
                .tabViewStyle(.page)
                .indexViewStyle(.page(backgroundDisplayMode: .never))
            
            }
        }
    }
    
    // MARK: Private Helper
    
    private func isSelected(tabIdentifier: String) -> Bool {
        return tabs[selection] == tabIdentifier
    }
    
    private func selectionBarXOffset(from totalWidth: CGFloat) -> CGFloat {
        return self.tabWidth(from: totalWidth) * CGFloat(selection)
    }
    
    private func tabWidth(from totalWidth: CGFloat) -> CGFloat {
        return totalWidth / CGFloat(tabs.count)
    }
}

#if DEBUG

@available(iOS 14.0, *)
struct SlidingTabConsumerView : View {
    @State private var selectedTabIndex = 0
    
    var body: some View {
        SlidingTabView(selection: self.$selectedTabIndex,
                       tabs: ["First", "Second"],
                       font: .body,
                       activeAccentColor: Color.blue,
                       selectionBarColor: Color.blue) {
            Text("First View")
            Text("Second View")
        }
    }
}

@available(iOS 14.0.0, *)
struct SlidingTabView_Previews : PreviewProvider {
    static var previews: some View {
        SlidingTabConsumerView()
    }
}
#endif
