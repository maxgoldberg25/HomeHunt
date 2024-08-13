//
//  ContentView.swift
//  NewDigs
//
//  Created by Max Goldberg on 11/4/22.
//

import SwiftUI
import CoreData


struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.date, ascending: false)],
        animation: .default)
    private var items: FetchedResults<Item>
    @State private var addItemPresenting = false
    

    var body: some View {
        NavigationView {
            List{
                ForEach(items) { item in
                    NavigationLink {
                        ApartmentView(imageData: item)
                    } label: {
                        HStack {
                        Image(imageData: item.image, placeholder: "house")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 48, height: 48, alignment: .center)
                        VStack(alignment: .leading) {
                                VStack(alignment: .leading) {
                                    Text(item.title ?? "")
                                        .font(.headline)
                                    Text("$"+String(item.rent ))
                                        .font(.subheadline)
                                    Text(String(item.sqft ) + " ft^2")
                                        .font(.subheadline)
                                    
                                }
                            }
                        }
                    }
                }
                .onDelete(perform: deleteItems)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    EditButton()
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        addItemPresenting.toggle()
                    }, label: {
                        Label("Add Item", systemImage: "plus")
                    })
                }
            }
            .sheet(isPresented: $addItemPresenting) {
                AddApartmentView()
            }
            .navigationTitle("NewDigs")
            
            Text("Select an item")
        }
    }


    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { items[$0] }.forEach(viewContext.delete)

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
