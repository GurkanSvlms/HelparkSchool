//
//  PlateItemView.swift
//  HelparkIOS
//
//  Created by Ali Gürkan Sevilmis on 2.06.2024.
//

import SwiftUI

struct PlateItemView: View {
    
    @State var carPlate : String
    @State var carModel : String
    @State var carFuel : Int
    
    var body: some View {
        VStack {
            HStack(spacing: 0) {
                VStack {
                    Text("TR")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .background(Color.blue)
                        .cornerRadius(5)
                }
                .padding(.leading, 16)
                
                VStack {
                    Text(carPlate)
                        .font(.popMediumBody)
                        .foregroundColor(.black)
                }
                .padding(.leading, 24)
                Spacer()
                
                VStack(alignment: .trailing) {
                    Text(carModel)
                        .font(.popMediumCallout)
                        .foregroundColor(.black)
                    if let fuelType = FuelType(rawValue: carFuel) {
                        Text(fuelType.description)
                            .font(.popMediumCallout)
                            .foregroundColor(.green)
                    } else {
                        Text("Unknown")
                            .font(.popMediumCallout)
                            .foregroundColor(.green)
                    }
                }
                .padding(.trailing)
            }
            .frame(height: 60)
            .background(Color.white)
            .cornerRadius(10)
            .shadow(radius: 3)
        .ignoresSafeArea()
        }
        .padding(.horizontal)
    }
}

struct PlateItemView_Previews: PreviewProvider {
    static var previews: some View {
        PlateItemView(carPlate: "32lk2kl", carModel: "lslkdmsqasdasdas", carFuel: 1)
    }
}
