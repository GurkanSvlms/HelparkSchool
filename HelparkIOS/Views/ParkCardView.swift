//
//  ParkCardView.swift
//  Helpark
//
//  Created by Ali Gürkan Sevilmis on 5.11.2023.
//

import SwiftUI

struct ParkCardView: View {
    
    let parkName: String
    let capacity: Int
    let emptyCapacity: Int
    let workHours: String
    let parkType: String
    let district: String
    let isOpen: Int
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .frame(height: 200)
                .foregroundColor(Color(.systemBackground))
                .shadow(radius: 5)
            
            HStack {
                VStack(alignment: .leading, spacing: 6) {
                    Text(parkName)
                        .font(.title)
                        .foregroundColor(Color(.label))
                        HStack{
                            Text(String("\(emptyCapacity)/\(capacity)"))
                                .font(.system(size: 16))
                                .foregroundColor(Color(.label))
                            
                            Text(isOpen == 1 ? "Açık" : "Kapalı")
                                .font(.system(size: 18))
                                .foregroundColor(Color("#3c7484"))
                                .bold()
                                .padding(.leading, 5)
                            
                        }
            
                    
                    Text(workHours)
                        .font(.body)
                        .foregroundColor(Color(.label))
                    
                    Text(parkType)
                        .font(.body)
                        .foregroundColor(Color(.label))
                }
                Spacer()
                
                Button(action: {
                    // Yol tarifi butonuna tıklama işlemi burada tanımlanır
                }) {
                    HStack {
                        Image(systemName: "arrow.right.circle.fill")
                            .resizable()
                            .frame(width: 20, height: 20)
                            .foregroundColor(.white)
                        
                        Text("Yol tarifi")
                            .font(.body)
                            .foregroundColor(.white)
                    }
                }
                .frame(width: 100, height: 37)
                .background(RoundedRectangle(cornerRadius: 10).fill(Color("#3c7484")))
                .padding(.bottom, 6)
            }
            .padding(10)
        }
    }
}
struct ParkCardView_Previews: PreviewProvider {
    static var previews: some View {
        ParkCardView(parkName: "Kartal", capacity: 50, emptyCapacity: 30, workHours: "24 Saat", parkType: "Kapalı", district: "Kartal", isOpen: 0)
            .frame(width: 350, height: 200)
    }
}

