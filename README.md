
<p align="center">
<img src="https://i.imgur.com/jQBLzkg.gif" />
</p>

**SlidingTabView** is a simple Android-Like tab view that is built using the latest and greatest SwiftUI. Almost everything is customizable!

## Installation
Please use Swift Package Manager to install **SlidingTabView**

## Usage
Just instantiate, bind it to your state and add your tabs with their respective content. That is it!
```swift
import SlidingTabView

struct MyView: View {

    @State var selectedTab: Int = 0

    var body: some View {
        SlidingTabView(
            selection: $selectedTab,
            tabs: SlidingTab(title: "Hello") {

                Text("Hello")

            },
            SlidingTab(title: "World!") {

                Text("World!")

            }
        )
    }
}
```

## Suggestions or feedback?
Feel free to create a pull request!
