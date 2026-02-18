//
//  TagCloud.swift
//  GetItWrite
//
//  Created by Hannah Billingsley-Dadd on 18/02/2022.
//

import SwiftUI

struct SelectTagView: View {
    @Binding var chosenTags: [String]
    let questionLabel: String
    let array: [String]
    
    var body: some View {
        VStack {
            Text(questionLabel)
                .bold()
                .frame(maxWidth: .infinity, alignment: .leading)
            TagCloud(tags: array, onTap: { text in
                if chosenTags.contains(text) {
                    chosenTags.removeAll(where: { $0 == text })
                } else {
                    chosenTags.append(text)
                }
            }, chosenTags: $chosenTags, singleTagView: true)
        }
    }
}

struct SingleTagSelectView: View {
    @Binding var chosenTag: [String]
    let questionLabel: String
    let array: [String]
    
    var body: some View {
        VStack {
            Text(questionLabel).bold().frame(maxWidth: .infinity, alignment: .leading)
            TagCloud(tags: array, onTap: { text in
                chosenTag = [text]
            }, chosenTags: $chosenTag, singleTagView: true)
        }
    }
}

struct MakeTagsCloud: View {
    @Binding var array: [String]
    @State private var value: String = ""
    let textLabel: String
    let questionLabel: String
    
    var body: some View {
        VStack {
            Text(questionLabel).bold().frame(maxWidth: .infinity, alignment: .leading)
            HStack {
                TextField(textLabel, text: self.$value)
                Button(action: {
                    if value != "" {
                        self.array.append(self.value)
                        self.value = ""
                    }
                }) {
                    Image(systemName: "plus.circle")
                }
            }
            Text("Tap tags to remove").font(.caption)
            TagCloud(tags: self.array, onTap: { text in
                self.array = self.array.filter { $0 != text }
            }, chosenTags: .constant([]), singleTagView: false)
        }
    }
}


struct TagCloud: View {
    var tags: [String]
    var onTap : ((String) -> Void)?
    
    @Binding var chosenTags: [String]
    var singleTagView: Bool
    var isTransparent = false
    
    @State private var totalHeight = CGFloat.zero       // << variant for ScrollView/List
    //
    //CGFloat.infinity   // << variant for VStack
    
    var body: some View {
        VStack {
            GeometryReader { geometry in
                self.generateContent(in: geometry)
            }
        }
        .frame(height: totalHeight)// << variant for ScrollView/List
        //.frame(maxHeight: totalHeight) // << variant for VStack
    }
    
    private func generateContent(in g: GeometryProxy) -> some View {
        var width = CGFloat.zero
        var height = CGFloat.zero
        
        return ZStack(alignment: .topLeading) {
            ForEach(self.tags, id: \.self) { tag in
                SingleTagView(text: tag, onTap: onTap, singleTagView: singleTagView, selectedTags: $chosenTags, isTransparent: isTransparent)
                    .padding([.horizontal, .vertical], 4)
                    .alignmentGuide(.leading, computeValue: { d in
                        if (abs(width - d.width) > g.size.width)
                        {
                            width = 0
                            height -= d.height
                        }
                        let result = width
                        if tag == self.tags.last! {
                            width = 0 //last item
                        } else {
                            width -= d.width
                        }
                        return result
                    })
                    .alignmentGuide(.top, computeValue: {d in
                        let result = height
                        if tag == self.tags.last! {
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

private struct SingleTagView: View {
    let text: String
    var onTap: ((String) -> Void)?
    var singleTagView: Bool
    @Binding var selectedTags: [String]
    let isTransparent: Bool
    
    @State var isLight = false
    
    var body: some View {
        if isTransparent {
            TransparentBoxView(text: text)
        } else {
            Text(text)
                .padding(.all, 5)
                .font(.body)
                .background(singleTagView && selectedTags.contains(text) || isLight ? Color.primary : Color.secondary)
                .foregroundColor(Color.white)
                .cornerRadius(5)
                .onTapGesture {
                    if let tapped = onTap {
                        tapped(text)
                        if !singleTagView {
                            isLight.toggle()
                        }
                    }
                }
        }
    }
}

struct TransparentBoxView: View {
    let text: String
    
    var body: some View {
        Text(text)
            .padding(10)
            .font(.body)
            .bold()
            .foregroundColor(Color.black)
            .overlay(
                RoundedRectangle(cornerRadius: 5)
                    .stroke(Color.black, lineWidth: 2)
            )
    }
}
