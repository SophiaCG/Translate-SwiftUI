//
//  ContentView.swift
//  Translate-SwiftUI
//
//  Created by Sophia Gorgonio on 11/21/23.
//

import SwiftUI
import CoreData

struct ContentView: View {
    
    @State private var input: String = ""
    @State private var output: String = ""
    @State private var textVisible: Bool = false
    @State private var isModalPresented = false
    @State private var firstLanguage: Language = Language(language: "en", name: "English")
    @State private var secondLanguage: Language = Language(language: "fr", name: "French")
    @State private var selected: Int = 0
    @ObservedObject var networkRequest = NetworkRequest()
    @StateObject private var translationVM = TranslationViewModel()


    var body: some View {
        NavigationView {
            VStack {
                HStack(alignment: .center) {
                    NavigationLink(destination: SavedView()) {
                        Image(systemName: "star.fill")
                            .font(Font.system(size: 18).weight(.bold))
                            .foregroundColor(.gray)
                        }
                    
                    Text("Translate App")
                        .font(Font.system(size: 20).weight(.bold))
                        .foregroundColor(.black)
                        .frame(width: 300)
                        .offset(x: -10)


                }.frame(width: 500, height: 50)
                .background(.white)
                
                VStack (alignment: .leading) {
                    if textVisible {

                        HStack (alignment: .center) {
                            Text(firstLanguage.name)
                                .font(Font.system(size: 15).weight(.bold))
                                .foregroundColor(Color.blue)

                            Spacer()
                            
                            Button(action: {
                                input = ""
                                output = ""
                                textVisible = false
                            }, label: {
                                Image(systemName: "multiply")
                                    .font(Font.system(size: 20))
                                    .foregroundColor(.gray)
                            })
                            
                            Button(action: {
                                if !translationVM.translationExists(input: input, translation: output) {
                                    translationVM.addTranslation(input: input, translation: output, timestamp: Date())
                                } else {
                                    translationVM.deleteTranslation(input: input, translation: output)
                                }

                            }, label: {
                                Image(systemName: translationVM.translationExists(input: input, translation: output) ? "star.fill" : "star")
                                    .font(Font.system(size: 18))
                                    .foregroundColor(translationVM.translationExists(input: input, translation: output) ? .yellow : .gray)
                                    .padding(.leading, 10)
                            })

                        }.padding(10)
                    }

                    ZStack(alignment: .topLeading) {
                        
                        TextEditor(text: $input)
                            .font(Font.system(size: 35).weight(.medium))
                            .foregroundColor(Color.gray)
                            .frame(maxHeight: 200)

                        if input.isEmpty {
                            Text("Enter text")
                                .font(Font.system(size: 35).weight(.medium))
                                .foregroundColor(Color.gray)
                                .padding(8)
                        } else {
                            Text("")
                        }

                    }
                    
                    if !input.isEmpty {
                        HStack {
                            VStack {
                                Divider()
                                    .background(.blue)
                                    .frame(maxWidth: 225)
                            }
                            Button(action: {
                                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)

                                networkRequest.translate(input: input, sourceLang: firstLanguage.language, targetLang: secondLanguage.language) { (results) in
                                    output = results.responseData.translatedText
                                }
                                
                                textVisible = true

                            }, label: {
                                if !textVisible {
                                    Image(systemName: "arrow.forward.circle.fill")
                                        .font(Font.system(size: 40))
                                        .foregroundColor(.blue)
                                        .padding(.horizontal, 10)
                                }
                            })

                        }.offset(x: 60)
                    }

                    if textVisible {
                        HStack {
                                Text(secondLanguage.name)
                                    .font(Font.system(size: 15).weight(.bold))
                                    .foregroundColor(Color.blue)
                            
                            Spacer()
                        }.padding(10)
                    }

                    Text(output)
                        .font(Font.system(size: 35).weight(.medium))
                        .foregroundColor(.blue)
                        .minimumScaleFactor(0.5) // Adjust the minimum scale factor as needed
                        .lineLimit(nil)
                        .padding(.horizontal, 5)
                    
                    Spacer()

                }.background(.white)
                    .clipShape(RoundedBottomCorners(cornerRadius: 30))
                    .offset(y: -10)
                
                Spacer()

                HStack() {
                    Button(action: {
                        selected = 1
                        isModalPresented.toggle()
                    }, label: {
                        Text(firstLanguage.name)
                            .font(Font.system(size: 15).weight(.bold))
                            .foregroundColor(.gray)
                            .frame(width: 120, height: 50, alignment: .center)
                            .background(.white)
                            .clipShape(RoundedRectangle(cornerRadius: 10))

                    })
                    Button(action: {
                        let langTemp = firstLanguage
                        firstLanguage = secondLanguage
                        secondLanguage = langTemp
                        
                        let inOutTemp = input
                        input = output
                        output = inOutTemp
                    }, label: {
                        Image(systemName: "arrow.left.arrow.right")
                            .font(Font.system(size: 15).weight(.bold))
                            .foregroundColor(.gray)
                            .padding(.horizontal, 10)
                    })
                    Button(action: {
                        selected = 2
                        isModalPresented.toggle()
                    }, label: {
                        Text(secondLanguage.name)
                            .font(Font.system(size: 15).weight(.bold))
                            .foregroundColor(.gray)
                            .frame(width: 120, height: 50, alignment: .center)
                            .background(.white)
                            .clipShape(RoundedRectangle(cornerRadius: 10))

                    })
                }.padding(.bottom, 20)

            }.background(Color(red: 242/255, green: 242/255, blue: 242/255))
                .sheet(isPresented: $isModalPresented, content: {
                    LanguageListView(firstLanguage: $firstLanguage, secondLanguage: $secondLanguage, selected: $selected, isModalPresented: $isModalPresented)
                })

        }

    }
    
}

struct RoundedBottomCorners: Shape {
    var cornerRadius: CGFloat

    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.minX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY - cornerRadius))
        path.addArc(center: CGPoint(x: rect.maxX - cornerRadius, y: rect.maxY - cornerRadius), radius: cornerRadius, startAngle: Angle(degrees: 0), endAngle: Angle(degrees: 90), clockwise: false)
        path.addLine(to: CGPoint(x: rect.minX + cornerRadius, y: rect.maxY))
        path.addArc(center: CGPoint(x: rect.minX + cornerRadius, y: rect.maxY - cornerRadius), radius: cornerRadius, startAngle: Angle(degrees: 90), endAngle: Angle(degrees: 180), clockwise: false)
        path.closeSubpath()
        return path
    }
}

#Preview {
    ContentView()
}
