
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
SlidingTabView(selection: $selectedTabIndex,tabs: ["First Tab", "Second Tab"]) {
    Text("First Page")
    Text("Second Page")
}
```

## Canvas Preview
```swift
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
```

## Suggestions or feedback?
Feel free to create a pull request!
