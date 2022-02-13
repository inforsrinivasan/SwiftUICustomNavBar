//
//  ContentView.swift
//  SwiftUICustomNavbar
//
//  Created by Srinivasan Rajendran on 2022-02-13.
//

import SwiftUI

struct ScrollViewOffsetPreferenceKey: PreferenceKey {
    static var defaultValue: CGFloat = 0.0

    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}

extension View {
    func scrollOffset(_ newValue: CGFloat) -> some View {
        preference(key: ScrollViewOffsetPreferenceKey.self, value: newValue)
    }
}

struct ContentView: View {

    let title: String = "Home Title"
    @State private var scrollOffset: CGFloat = 0.0

    var body: some View {
        ScrollView {
            VStack {
                Text(title)
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(
                        GeometryReader { reader in
                            Text("")
                                .scrollOffset(reader.frame(in: .global).minY)
                        }
                    )
                    .opacity(scrollOffset > 0 ? Double(scrollOffset / 64) : 0)

                ForEach((1..<20)) { _ in
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.blue)
                        .frame(height: 150)
                }
            }
            .padding()
        }
        .overlay(alignment: .top) {
            Text(title)
                .font(.headline)
                .frame(maxWidth: .infinity)
                .frame(height: 64)
                .background(Color.indigo)
                .opacity(scrollOffset < 0 ? 1 : 0)
        }
        .overlay {
            Text("\(scrollOffset)")
                .frame(maxWidth: .infinity)
                .background(Color.green)
        }
        .onPreferenceChange(ScrollViewOffsetPreferenceKey.self) { offset in
            scrollOffset = offset
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
