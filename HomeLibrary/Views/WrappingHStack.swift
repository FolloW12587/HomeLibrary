//
//  WrappingHStack.swift
//  HomeLibrary
//
//  Created by Сергей Дубовой on 11.06.2024.
//

import SwiftUI

struct WrappingHStack<Item: Hashable, Representation: View>: View {
    var items: [Item]
    var representation: (Item) -> Representation

    @State private var totalHeight = CGFloat.zero

    var body: some View {
        VStack {
            GeometryReader { geometry in
                self.generateContent(in: geometry)
            }
        }
        .frame(height: totalHeight)
    }

    private func generateContent(in g: GeometryProxy) -> some View {
        var width = CGFloat.zero
        var height = CGFloat.zero

        return ZStack(alignment: .topLeading) {
            ForEach(items, id: \.self) { item in
                representation(item)
                    .padding([.horizontal, .vertical], 4)
                    .alignmentGuide(.leading, computeValue: { d in
                        if (abs(width - d.width) > g.size.width)
                        {
                            width = 0
                            height -= d.height
                        }
                        let result = width
                        if item == self.items.last! {
                            width = 0 //last item
                        } else {
                            width -= d.width
                        }
                        return result
                    })
                    .alignmentGuide(.top, computeValue: {d in
                        let result = height
                        if item == self.items.last! {
                            height = 0 // last item
                        }
                        return result
                    })
            }
        }.background(viewHeightReader($totalHeight))
    }

    private func viewHeightReader(_ binding: Binding<CGFloat>) -> some View {
        return GeometryReader { geometry -> Color in
            let rect = geometry.frame(in: .local)
            DispatchQueue.main.async {
                binding.wrappedValue = rect.size.height
            }
            return .clear
        }
    }

}

#Preview {
    VStack {
        Text("Header").font(.largeTitle)
        WrappingHStack(items: ["Ninetendo", "XBox", "PlayStation", "PlayStation 2", "PlayStation 3", "PlayStation 4"]) { text in
            Text(text)
                .padding(.all, 5)
                .font(.body)
                .background(Color.green)
                .foregroundColor(Color.white)
                .cornerRadius(5)
        }
        Text("Some other text")
        Divider()
        Text("Some other cloud")
        WrappingHStack(items: ["Apple", "Google", "Amazon", "Microsoft", "Oracle", "Facebook"]) { text in
            Text(text)
                .padding(.all, 5)
                .font(.body)
                .background(Color.blue)
                .foregroundColor(Color.white)
                .cornerRadius(5)
        }
    }
}
