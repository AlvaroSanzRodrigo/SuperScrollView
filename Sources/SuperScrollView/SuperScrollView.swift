// Copyright ©2023 Rally Innovation. All rights reserved.

import SwiftUI
import IsScrolling

@available(iOS 14.0, *)
public struct SuperScrollView<Content: View>: View {
    var axes: Axis.Set = [.vertical]
    var showsIndicators = true
    @Binding var offset: CGPoint
    @Binding var size: CGSize
    @Binding var isScrolling: Bool
    @ViewBuilder var content: (ScrollViewProxy) -> Content
    
    private let coordinateSpaceName = UUID()
    
    public init(axes: Axis.Set = [.vertical], showsIndicators: Bool = true, offset: Binding<CGPoint>, size: Binding<CGSize>, isScrolling: Binding<Bool>, content: @escaping (ScrollViewProxy) -> Content) {
        self.axes = axes
        self.showsIndicators = showsIndicators
        _offset = offset
        _size = size
        _isScrolling = isScrolling
        self.content = content
    }
    public var body: some View {
        ScrollView(axes, showsIndicators: showsIndicators) {
            PositionObservingView(
                coordinateSpace: .named(coordinateSpaceName),
                position: Binding(
                    get: { offset },
                    set: { newOffset in
                        offset = CGPoint(
                            x: -newOffset.x,
                            y: -newOffset.y
                        )
                    }
                ),
                size: Binding(
                    get: { size },
                    set: { newSize in
                        size = CGSize(
                            width: newSize.width,
                            height: newSize.height
                        )
                    }
                ),
                content: content
            )
        }
        .coordinateSpace(name: coordinateSpaceName)
        .scrollStatusMonitor($isScrolling, monitorMode: .exclusion)
    }
}

@available(iOS 14.0, *)
struct PositionObservingView<Content: View>: View {
    var coordinateSpace: CoordinateSpace
    @Binding var position: CGPoint
    @Binding var size: CGSize
    @ViewBuilder var content: (ScrollViewProxy) -> Content
    
    var body: some View {
        ScrollViewReader { scrollProxy in
            content(scrollProxy)
                .background(GeometryReader { geometry in
                    Color.clear
                        .preference(
                            key: PreferenceKeyOffset.self,
                            value: geometry.frame(in: coordinateSpace).origin
                        )
                        .preference(
                            key: PreferenceKeySize.self,
                            value: geometry.size
                        )
                })
                .onPreferenceChange(PreferenceKeyOffset.self) { position in
                    self.position = position
                }
                .onPreferenceChange(PreferenceKeySize.self) { size in
                    self.size = size
                }
        }
    }
}

@available(iOS 14.0, *)
private extension PositionObservingView {
    struct PreferenceKeyOffset: SwiftUI.PreferenceKey {
        static var defaultValue: CGPoint { .zero }
        
        static func reduce(value: inout CGPoint, nextValue: () -> CGPoint) {
            // No-op
        }
    }
}

@available(iOS 14.0, *)
private extension PositionObservingView {
    struct PreferenceKeySize: SwiftUI.PreferenceKey {
        static var defaultValue: CGSize { .zero }
        
        static func reduce(value: inout CGSize, nextValue: () -> CGSize) {
            // No-op
        }
    }
}
