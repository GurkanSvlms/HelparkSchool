//
//  PriceTableView.swift
//  HelparkIOS
//
//  Created by Hasan Ali Şişeci on 4.02.2024.
//

import SwiftUI

struct PriceTableView: View {
    let priceData: [ParkingRate]
    var body: some View {
        VStack(spacing: 0) {
            Text(Strings.carParkTariff)
                .font(.popRegularBody)
                .padding(.vertical)
            Rectangle().frame(width: UI.Size.Screen.width - 32, height: 1)
                .foregroundStyle(Color.black.opacity(0.3))
            HStack(spacing: 0) {
                VStack {
                    ForEach(priceData) { data in
                        tableRow(data.timeRange)
                    }
                }.padding(.top, 5)
                Divider()
                    .overlay(.black)
                    .foregroundStyle(Color.black)
                VStack {
                    ForEach(priceData) { data in
                        tableRow("\(data.price) ₺")
                    }
                }.padding(.top, 5)
            }
        }
            .fixedSize(horizontal: false, vertical: true)
            .frame(width: UI.Size.Screen.width - 32)
            .background { Color.white }
            .cornerRadius(12)
    }

    private func tableRow(_ text: String) -> some View {
        VStack(spacing: 0) {
            Text(text)
                .font(.popLightSubheadline)
                .foregroundStyle(Color.black)
            Rectangle().frame(width: (UI.Size.Screen.width - 32) / 2, height: 1)
                .foregroundStyle(Color.black.opacity(0.3))
        }
    }
}

#Preview {
    PriceTableView(priceData: [
        ParkingRate(id: UUID(), timeRange: "1", price: "10"),
        ParkingRate(id: UUID(), timeRange: "2", price: "20"),
        ParkingRate(id: UUID(), timeRange: "3", price: "30"),
        ParkingRate(id: UUID(), timeRange: "4", price: "40")])
        .backgroundWithShadow()
}
