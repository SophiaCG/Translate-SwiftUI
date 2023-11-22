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

    var body: some View {
        NavigationView {
            VStack {
                HStack(alignment: .center) {
                    NavigationLink(destination: SavedView(title: "Saved View")) {
                        Image(systemName: "star.fill")
                            .font(Font.system(size: 18).weight(.bold))
                            .foregroundColor(.yellow)
                        }
                    
                    Text("Translate App")
                        .font(Font.system(size: 20).weight(.bold))
                        .foregroundColor(.black)
                        .frame(width: 300)
                        .offset(x: -10)


                }.frame(width: 500, height: 50)
                .background(.white)
                
                ZStack(alignment: .topLeading) {
                    
                    TextEditor(text: $input)
                        .font(Font.system(size: 35).weight(.medium))
                        .foregroundColor(Color.gray)
                        .clipShape(RoundedBottomCorners(cornerRadius: 30))
                    if input.isEmpty {
                        Text("Enter text")
                            .font(Font.system(size: 35).weight(.medium))
                            .foregroundColor(Color.gray)
                            .padding(8)
                    } else {
                        Text("")
                    }

                }.offset(y: -10)

                Spacer()

                HStack() {
                    Button(action: {}, label: {
                        Text("English")
                            .font(Font.system(size: 15).weight(.bold))
                            .foregroundColor(.gray)
                            .padding(.vertical, 15)
                            .padding(.horizontal, 30)
                            .background(.white)
                            .clipShape(RoundedRectangle(cornerRadius: 10))

                    })
                    Button(action: {}, label: {
                        Image(systemName: "arrow.left.arrow.right")
                            .font(Font.system(size: 15).weight(.bold))
                            .foregroundColor(.gray)
                            .padding(.horizontal, 10)
                    })
                    Button(action: {}, label: {
                        Text("French")
                            .font(Font.system(size: 15).weight(.bold))
                            .foregroundColor(.gray)
                            .padding(.vertical, 15)
                            .padding(.horizontal, 30)
                            .background(.white)
                            .clipShape(RoundedRectangle(cornerRadius: 10))

                    })
                }.padding(.vertical, 20)

            }.background(Color(red: 242/255, green: 242/255, blue: 242/255))
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


//    @Environment(\.managedObjectContext) private var viewContext
//
//    @FetchRequest(
//        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
//        animation: .default)
//    private var items: FetchedResults<Item>
//
//    var body: some View {
//        NavigationView {
//            List {
//                ForEach(items) { item in
//                    NavigationLink {
//                        Text("Item at \(item.timestamp!, formatter: itemFormatter)")
//                    } label: {
//                        Text(item.timestamp!, formatter: itemFormatter)
//                    }
//                }
//                .onDelete(perform: deleteItems)
//            }
//            .toolbar {
//#if os(iOS)
//                ToolbarItem(placement: .navigationBarTrailing) {
//                    EditButton()
//                }
//#endif
//                ToolbarItem {
//                    Button(action: addItem) {
//                        Label("Add Item", systemImage: "plus")
//                    }
//                }
//            }
//            Text("Select an item")
//        }
//    }
//
//    private func addItem() {
//        withAnimation {
//            let newItem = Item(context: viewContext)
//            newItem.timestamp = Date()
//
//            do {
//                try viewContext.save()
//            } catch {
//                // Replace this implementation with code to handle the error appropriately.
//                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
//                let nsError = error as NSError
//                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
//            }
//        }
//    }
//
//    private func deleteItems(offsets: IndexSet) {
//        withAnimation {
//            offsets.map { items[$0] }.forEach(viewContext.delete)
//
//            do {
//                try viewContext.save()
//            } catch {
//                // Replace this implementation with code to handle the error appropriately.
//                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
//                let nsError = error as NSError
//                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
//            }
//        }
//    }
//}
//
//private let itemFormatter: DateFormatter = {
//    let formatter = DateFormatter()
//    formatter.dateStyle = .short
//    formatter.timeStyle = .medium
//    return formatter
//}()
//
//#Preview {
//    ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
//}
