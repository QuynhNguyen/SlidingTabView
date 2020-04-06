
<p align="center">
<img src="https://i.imgur.com/jQBLzkg.gif" />
</p>

**SlidingTabView** is a simple Android-Like tab view that is built using the latest and greatest SwiftUI. Almost everything is customizable!

## Installation
Please use Swift Package Manager to install **SlidingTabView**

## Usage
Just instantiate and bind it to your state. That is it!
```swift
@State private var selectedTabIndex = 0
SlidingTabView(selection: $selectedTabIndex,tabs: ["First Tab", "Second Tab"])
```

If need disabled button tabs:
```swift
@State private var selectedTabIndex = 0
SlidingTabView(selection: $selectedTabIndex,tabs: ["First Tab", "Second Tab"], isEnabled: false)
```

If need change manually a tab:
```swift
@State private var selectedTabIndex = 0
SlidingTabView(
    selectionState:self.$selectedTabIndex,
    selection: $selectedTabIndex,
    tabs: ["First Tab", "Second Tab"], isEnabled: false
)
```

To change the tab, change the value of selectionState and selection


## Canvas Preview
```swift
struct SlidingTabConsumerView : View {
    @State private var selectedTabIndex = 0

    var body: some View {
        VStack(alignment: .leading) {
            SlidingTabView(selection: self.$selectedTabIndex, tabs: ["First", "Second"])
            (selectedTabIndex == 0 ? Text("First View") : Text("Second View")).padding()
            Spacer()
        }
            .padding(.top, 50)
            .animation(.none)
    }
}

@available(iOS 13.0.0, *)
struct SlidingTabView_Previews : PreviewProvider {
    static var previews: some View {
        SlidingTabConsumerView()
    }
}
```

## Suggestions or feedback?
Feel free to create a pull request!
