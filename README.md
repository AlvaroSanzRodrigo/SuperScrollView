# SuperScrollView

This package add the SuperScrollView, an scroll view that provides `scroll offset`, `scroll content size` and if its currently scrolling, it also brings ScrollProxy in case you need it.

## Requirements

```
.iOS(.v14),

.macOS(.v12),

.macCatalyst(.v14),
```

## Installation

```
dependencies: [
  .package(url: "https://github.com/AlvaroSanzRodrigo/SuperScrollView")
]
```

## Usage

This SuperScrollView uses bindings to give you updated data

```swift
    @State private var scrollOffset: CGPoint = .zero
    @State private var scrollSize: CGSize = .zero
    @State private var isScrolling: Bool = false
    
    var body: some View {
        VStack {
            Text("Offset: \(scrollOffset.y)")
            Text("Size Width: \(scrollSize.width)")
            Text("Size Height: \(scrollSize.height)")
            Text("Is scrolling: \(isScrolling.description)")
            HStack {
                SuperScrollView(offset: $scrollOffset, size: $scrollSize, isScrolling: $isScrolling) { scrollProxy in
                    ForEach(0..<100) { index in
                        Text("This is row \(index)")
                    }
                }
            }
        }
        .padding()
    }
```

## Dependencies

This libary uses `IsScrolling` from [fatbobman/IsScrolling](https://github.com/fatbobman/IsScrolling)

## License
