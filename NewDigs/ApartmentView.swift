//
//  ImageView.swift
//  NewDigs
//
//  Created by Max Goldberg on 11/4/22.
//


import SwiftUI
import MapKit

struct ApartmentView: View {
    @State private var isEditing: Bool = false
    
     
    var imageData: Item
    
    
   // Use imageData for all .(functions)

    
    var body: some View {
        
        ZStack(alignment: .center) {
            Color.white
                .edgesIgnoringSafeArea([.all])

            VStack(alignment: .center, spacing: 70) {

                Image(imageData: imageData.image, placeholder: "house")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                   // .padding()

                    NavigationLink("Show Me on Map", destination: {
                        MapView(coord: CLLocationCoordinate2D(latitude: imageData.latitude, longitude: imageData.longitude))
                    })
                .foregroundColor(.blue)
                .font(.largeTitle)
                VStack(alignment: .leading) {
                   // Spacer()
                    

                    HStack{
                        Text("Title:")
                            .font(.title)
                           // .padding()
                            .foregroundColor(.black)
                        Text(imageData.title ?? "")
                            .font(.title)
                          //  .padding()
                            .foregroundColor(.black)
                    }
                    .padding()
                    
                    HStack{
                        Text("Address:")
                            .font(.title3)
                            .foregroundColor(.black)
                        Text(imageData.address ?? "")
                                .font(.title3)
                         //   .padding()
                            .foregroundColor(.black)
                    }
                    
                    
                    Text("Date: \(imageData.date!, formatter: itemFormatter)")
                        .foregroundColor(.black)
                    
              
                    HStack{
                        Text("Notes:")
                            .font(.title3)
                            .multilineTextAlignment(.center)
                         //   .padding()
                            .foregroundColor(.black)
                        Text(imageData.notes ?? "")
                            .font(.title3)
                            .multilineTextAlignment(.center)
                       //     .padding()
                            .foregroundColor(.black)
                    }
                    
                    HStack{
                        Text("Phone:")
                            .font(.title3)
                            .multilineTextAlignment(.center)
                         //   .padding()
                            .foregroundColor(.black)
                        Text(imageData.phone ?? "")
                            .font(.title3)
                            .multilineTextAlignment(.center)
                          //  .padding()
                            .foregroundColor(.black)
                    }
              
                    HStack{
                        Text("Rent:")
                            .font(.title3)
                            .multilineTextAlignment(.center)
                          //  .padding()
                            .foregroundColor(.black)
                        Text("$"+String(imageData.rent ))
                            .font(.title3)
                            .multilineTextAlignment(.center)
                          //  .padding()
                            .foregroundColor(.black)
                    }
                   
                    HStack{
                        Text("Sqft:")
                            .font(.title3)
                            .multilineTextAlignment(.center)
                       //     .padding()
                            .foregroundColor(.black)
                        Text(String(imageData.sqft ))
                            .font(.title3)
                            .multilineTextAlignment(.center)
                          //  .padding()
                            .foregroundColor(.black)
                        Text(" ft^2")
                            .font(.title3)
                            .multilineTextAlignment(.center)
                          //  .padding()
                            .foregroundColor(.black)
                    }
                    
                    HStack{
                        Text("Thoughts on property:")
                            .font(.title3)
                            .multilineTextAlignment(.center)
                       //     .padding()
                            .foregroundColor(.black)
                        Text(imageData.thumb ?? "")
                            .font(.title3)
                            .multilineTextAlignment(.center)
                          //  .padding()
                            .foregroundColor(.black)
                    }
                    
                    HStack{
                        Text("Latitude:")
                            .font(.title3)
                            .multilineTextAlignment(.center)
                          //  .padding()
                            .foregroundColor(.black)
                        Text(String(imageData.latitude))
                            .font(.title3)
                            .multilineTextAlignment(.center)
                        //    .padding()
                            .foregroundColor(.black)
                    }
                    
                    HStack{
                        Text("Longitude:")
                            .font(.title3)
                            .multilineTextAlignment(.center)
                          //  .padding()
                            .foregroundColor(.black)
                        Text(String(imageData.longitude))
                            .font(.title3)
                            .multilineTextAlignment(.center)
                         //   .padding()
                            .foregroundColor(.black)
                    }
                    
        
                   
                    
               
                    
                }

            }.padding()
         //   Spacer()
            
            .foregroundColor(.white)
          //  .shadow(color: .black, radius: 2, x: 1, y: 1)
            .padding()
            
            Spacer()
            Spacer()
        }
        .navigationBarTitle(imageData.title ?? "", displayMode: .inline)
        .padding()
    }
    
    
    var border: some View {
        RoundedRectangle(cornerRadius:10)
//          .frame(width: 2, height: 2)
          .strokeBorder(
            LinearGradient(
              gradient: .init(
                colors: [
                    Color(.black)
                ]
              ),
              startPoint: .topLeading,
              endPoint: .bottomTrailing
            ),
            lineWidth: isEditing ? 4 : 2
          )
          .frame(width: 300, height: 280)

      }

}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .short
    return formatter
}()



