//
//  ContentView.swift
//  DevoteCoreData
//
//  Created by Gurjinder Singh on 11/01/23.
//

import SwiftUI
import CoreData

struct ContentView: View {
    
    @State var task: String = "" // hold value user enter
    @State private var showNewTaskItem: Bool = false
    @AppStorage("isDarKMode") private var isDarKMode: Bool = false

    //managedObjectContext an environment where we can manipulate Core data objects entirely in RAM
    //Fetching Data
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Item>

    //MARK: - Function
    

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { items[$0] }.forEach(viewContext.delete)

            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                //MARK: - Main View
                VStack {
                    //MARK: - Header
                    HStack(spacing: 10) {
                        //Title
                        Text("Devote")
                            .font(.system(.largeTitle, design: .rounded))
                            .fontWeight(.heavy)
                            .padding(.leading, 4)
                        
                        Spacer()
                        
                        //Edit button
                        EditButton()
                            .font(.system(size: 16, weight: .semibold, design: .rounded))
                            .padding(.horizontal, 10)
                            .frame(minWidth: 70, minHeight: 24)
                            .background(
                                Capsule().stroke(Color.white, lineWidth: 2)
                            )
                        
                        //Appearance button
                        Button {
                            isDarKMode.toggle()
                        } label: {
                            Image(systemName: isDarKMode ? "moon.circle.fill" : "moon.circle")
                                .resizable()
                                .frame(width: 24, height: 24)
                                .font(.system(.title, design: .rounded))
                        }
                    }
                    .padding()
                    .foregroundColor(Color.white)
                    
                    Spacer(minLength: 80)

                    //MARK: - New Task Button
                    Button {
                        showNewTaskItem = true
                    } label: {
                        Image(systemName: "plus.circle")
                            .font(.system(size: 30, weight: .semibold, design: .rounded))
                        Text("New Task")
                            .font(.system(size: 30, weight: .semibold, design: .rounded))
                    }
                    .padding(.horizontal, 20)
                    .padding(.vertical, 15)
                    .foregroundColor(Color.white)
                    .background(
                        LinearGradient(colors: [Color.pink, Color.blue], startPoint: .leading, endPoint: .trailing).clipShape(Capsule())
                    )
                    .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.25), radius: 8, x: 0, y: 4)

                    //MARK: - Tasks
                    List {
                        ForEach(items) { item in
//                            NavigationLink {
//                                Text("Item at \(item.timestamp!, formatter: itemFormatter)")
//                                    .font(.footnote)
//                                    .foregroundColor(.gray)
//
//                            } label: {
                                VStack(alignment: .leading) {
                                    Text(item.task ?? "")
                                        .font(.headline)
                                        .fontWeight(.bold)
                                    Text(item.timestamp!, formatter: itemFormatter)
                                }
//                            }
                        }
                        .onDelete(perform: deleteItems)
//                        .listRowBackground(Color.green)
                    } // List
                    .listStyle(InsetGroupedListStyle())
                    .shadow(color: Color.init(red: 0, green: 0, blue: 0, opacity: 0.7), radius: 32)
                    .padding(.vertical, 0)
                    .cornerRadius(33)
                    .scrollContentBackground(.hidden)
//                    .frame(height: 500)
//                    .background(Color.clear)
                } //: VStack
                if showNewTaskItem {
                    BlankView()
                        .onTapGesture {
                            withAnimation {
                                showNewTaskItem = false
                            }
                        }
                    NewTaskItemView(isShowing: $showNewTaskItem)
                }
            } //: ZStack
            .navigationBarTitle("Daily Tasks", displayMode: .large)
            .navigationBarHidden(true)
            .background(
                BackgroundImageView()
            )
            .background(
                backgroundGradient.ignoresSafeArea(.all)
            )
        } //: Navigation
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
