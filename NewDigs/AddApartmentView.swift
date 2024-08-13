//
//  AddImageView.swift
//  FabUs
//
//  Created by Max Goldberg on 10/30/22.
//

import SwiftUI
import MapKit

struct AddApartmentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.dismiss) var dismiss
    
    @State private var address = ""
    @State private var latitude = 0.0
    @State private var longitude = 0.0
    @State private var notes = ""
    @State private var phone = ""
    @State private var title = ""
    @State private var rent = ""
    @State private var sqft = ""
    @State private var thumbIndex = 0
    @State private var uiImage: UIImage?
    @State private var imagePickerPresenting = false
    @StateObject var locationVM = LocationVM()
    
    // Special feature
    @State private var thumbs = ["👍", "👌", "👎"]
    
    var body: some View {
        
        NavigationView {
            VStack{
                
                Image(uiImage: uiImage ?? UIImage(imageLiteralResourceName: "house"))
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .cornerRadius(9)
                    .clipShape(Rectangle())
                    .padding(28)
                    .onTapGesture {
                        imagePickerPresenting.toggle()
                    }
                .sheet(isPresented: $imagePickerPresenting) {
                    PhotoPicker(image: $uiImage)
                }
                
               

            Form {
                Section("Apartment details") {
                    TextField("Address", text: $address)
                    TextField("Title", text: $title)
                    TextField("Phone", text: $phone)
                    TextField("Rent", text: $rent)
                    TextField("Square ft", text: $sqft)
                }
                
                Section(header: Text("How did you like the property?").font(.headline).foregroundColor(.black)){
                    Picker("Thumb", selection: $thumbIndex) {
                        ForEach(0..<thumbs.count){
                            Text(self.thumbs[$0])
                        }
                    }
                .pickerStyle(.segmented)
                .background(.white)
                }
                
                Section("Location"){
                    HStack{
                    Button(action: {
                        locationVM.toggleService()
                    }, label: {
                        Text("Get current location")
                    })
                    .disabled(locationVM.enabled)
                    .foregroundColor(.pink)
                    Spacer()
                    NavigationLink("Show Me", destination: {
                        MapView(coord: CLLocationCoordinate2D(latitude: locationVM.location?.coordinate.latitude ?? 0, longitude: locationVM.location?.coordinate.longitude ?? 0))
                    })
                    .disabled(!locationVM.enabled)
                    }
    
                }
            
                
                Section("Notes") {
                    TextEditor(text: $notes)
                }
            
                
                Section {
                    HStack {
                        Spacer()
                        Button(action: {
                            addItem()
                        }, label: {
                            Text("Save")
                        })
                        .disabled(title.isEmpty || address.isEmpty || notes.isEmpty ||   phone.isEmpty)
                        Spacer()
                    }
                }
            }
            .navigationTitle("New Item")
            
            }
        }
    }
    
    private func addItem() {
        withAnimation {
            let newItem = Item(context: viewContext)
            newItem.title = title
            newItem.address = address
            newItem.latitude = locationVM.location?.coordinate.latitude ?? 0
            newItem.longitude = locationVM.location?.coordinate.longitude ?? 0
            newItem.notes = notes
            newItem.phone = phone
            newItem.rent = Int16(rent) ?? 0
            newItem.sqft = Int16(sqft) ?? 0
            newItem.id = UUID()
            newItem.date = Date()
            newItem.thumb = thumbs[thumbIndex]
            
            if let data = uiImage?.jpegData(compressionQuality: 0.8) {
                newItem.image = data
            }
            do {
                try viewContext.save()
                dismiss()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

struct AddApartmentView_Previews: PreviewProvider {
    static var previews: some View {
        AddApartmentView()
    }
}
