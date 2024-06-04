//
//  CarParkDetailView.swift
//  HelparkIOS
//
//  Created by Hasan Ali Şişeci on 4.02.2024.
//

import SwiftUI

struct CarParkDetailView: View {
    @ObservedObject var homeViewModel: HomeViewModel
    @ObservedObject var addOrRemoveViewModel = FavoritesViewModel()
    @Environment(\.presentationMode) var presentationMode

    let carPark: CarParkModel
    @State var isExpanded = false
    @State var showDeleteButton = false
    @State private var showDeletePopup = false

    var occupancyColor: Color {
        carPark.emptyCapacity > carPark.capacity / 2 ? .green : .red
    }
    
    var occupancyCapacity: Int {
        (carPark.capacity) - (carPark.emptyCapacity)
    }
    
    var openOrClosedColor: Color {
        carPark.isOpen == 0 ? .red : .green
    }
    
    var carParkOpenText: String {
        "\(carPark.isOpen == 0 ? Strings.closed.uppercased() : Strings.open.uppercased())"
    }
    
    var body: some View {
        ZStack{
            VStack{
                ScrollView {
                    VStack(spacing: UI.Spacing.p3) {
                        header
                        carParkName
                        densityAndLastUpdate
                        someInfo
                        priceInfo
                        Spacer()
                        
                    }
                }
                .scrollIndicators(.hidden)
                //        .onAppear(perform: viewAppear)
                .background(.white)
                if showDeleteButton{
                    Spacer()
                    
                    Button(action: {
                        showDeletePopup = true
                    }) {
                        Text("Favori Otoparkı Sil")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(width: 330)
                            .padding()
                            .background(.red)
                            .cornerRadius(16)
                    }
                }
            }
            .navigationBarTitle("Otopark Detayı")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(leading: CustomBackButtonView())
            .onAppear{
                if let userIdString = try? HPUserDefaultsManager.shared.getModel(.userID, String.self),
                   let userId = Int(userIdString) {
                    addOrRemoveViewModel.fetchFavouriteParks(userId: userId)
                }
            }
            if showDeletePopup {
                PopupOneButton(
                    showPopup: $showDeletePopup,
                    title: "Plaka Silme",
                    subtitle: "Plaka Silme İşlemini Onaylıyor musunuz",
                    buttonText: "Evet",
                    showCloseButton: true) {
                        if let userIdString = try? HPUserDefaultsManager.shared.getModel(.userID, String.self),
                           let userId = Int(userIdString) {
                            addOrRemoveViewModel.addOrRemoveFavorite(request: FavoriteParkRequest(userId: userId, parkId: carPark.id))
                            showDeletePopup = false
                            presentationMode.wrappedValue.dismiss()
                        }
                    }
            }
        }
    }
    
    private var header: some View {
        HStack(spacing: 0) {
            Image.locationPinRed
                .resizable()
                .frame(width: 24, height: 24)
                .aspectRatio(contentMode: .fit)
            Text(carPark.district)
                .font(.popBoldTitle3)
            Spacer()
            HStack {
                Button {
                    openMapsForDirection()
                } label: {
                    HPSquareButton(image: Image.detailDirectionImage, showStroke: false, color: .blue, lenght: 40)
                }
                .backgroundWithShadow()
                
                if !showDeleteButton{
                    Button {
                        if let userIdString = try? HPUserDefaultsManager.shared.getModel(.userID, String.self),
                           let userId = Int(userIdString) {
                            addOrRemoveViewModel.addOrRemoveFavorite(request: FavoriteParkRequest(userId: userId, parkId: carPark.id))
                        }
                    } label: {
                        HPSquareButton(
                            image: addOrRemoveViewModel.parks.contains(where: { $0.id == carPark.id }) ? Image.detailFavImage : Image.detailAddFavImage,
                            showStroke: false,
                            color: .red,
                            lenght: 40
                        )
                        .backgroundWithShadow()
                    }
                    .backgroundWithShadow()
                }
            }
        }.padding()
        
    }
    
    private var carParkName: some View {
        HStack{
            Text(carPark.parkName)
                .padding(.horizontal)
                .multilineTextAlignment(.center)
                .font(.popMediumHeadline)
                .padding(.leading, 8)
                .lineLimit(isExpanded ? nil : 1)
                .fixedSize(horizontal: false, vertical: true)
                .transition(.slide)
                .animation(.easeInOut, value: isExpanded)
                .onTapGesture {
                    withAnimation {
                        isExpanded.toggle()
                    }
                }
            
            Spacer()
            Rectangle().frame(width: 2, height: isExpanded ? 100 : 50)
                .foregroundStyle(Color.black.opacity(0.2))
            
            Image("rate")
                .resizable()
                .frame(width: 20, height: 20)
                .aspectRatio(contentMode: .fit)
            Text(carPark.parkPoint)
                .padding(.trailing, 16)
                .multilineTextAlignment(.center)
                .font(.popMediumSubheadline)
        }
        .frame(width: UIScreen.main.bounds.width - 32, height: isExpanded ? 2 * UI.Size.Button.defaultHeight : UI.Size.Button.defaultHeight)
        .backgroundWithShadow()
        
    }
    
    private var densityAndLastUpdate: some View {
        HStack {
            intensity
            Rectangle().frame(width: 2, height: 50)
                .foregroundStyle(Color.black.opacity(0.2))
            lastUpdate
        }
        .frame(width: UI.Size.Screen.width - 32, height: 80)
        .backgroundWithShadow()
    }
    
    private var intensity: some View {
        VStack(spacing: UI.Spacing.p1) {
            HStack {
                Text(Strings.live).foregroundStyle(occupancyColor)
                    .font(.popRegularSubheadline)
                Circle().frame(width: 5)
                    .foregroundStyle(.brown)
                Text(Strings.intensity)
                    .font(.popRegularSubheadline)
            }
            Text("\(occupancyCapacity) / \(carPark.capacity)")
                .padding(.horizontal, 15)
                .padding(.vertical, 5)
                .background {
                    Capsule().foregroundStyle(occupancyColor)
                }
        }
        .fixedSize(horizontal: false, vertical: true)
        .frame(width: (UI.Size.Screen.width - 60) / 2)
    }
    
    private var lastUpdate: some View {
        VStack {
            Text(Strings.lastUpdate).font(.popSemiboldSubheadline)
            Text("\(carPark.parkDetail.updateDate)").font(.popRegularSubheadline)
        }.frame(width: (UI.Size.Screen.width - 60) / 2)
    }
    
    private var someInfo: some View {
        VStack(spacing: UI.Spacing.p2) {
            Group {
                Text(Strings.workingHours)
                    .font(.popRegularBody)
                Text(carParkOpenText)
                    .font(.popMediumSubheadline)
                    .foregroundStyle(openOrClosedColor)
                Text(carPark.workHours)
                    .font(.popLightSubheadline)
            }
            Rectangle().frame(width: UI.Size.Screen.width - 50, height: 1)
                .foregroundStyle(Color.black.opacity(0.3))
            Group {
                Text(Strings.forDirections)
                    .font(.popRegularBody)
                Text(carPark.parkDetail.tariff)
                    .multilineTextAlignment(.center)
                    .font(.popLightSubheadline)
            }
            Rectangle().frame(width: UI.Size.Screen.width - 50, height: 1)
                .foregroundStyle(Color.black.opacity(0.3))
            Group {
                Text(Strings.parkType)
                    .font(.popRegularBody)
                Text(carPark.parkType)
                    .font(.popLightSubheadline)
            }
            Rectangle().frame(width: UI.Size.Screen.width - 50, height: 1)
                .foregroundStyle(Color.black.opacity(0.3))
            Group {
                Text(Strings.price)
                    .font(.popRegularBody)
                Text(String(carPark.freeTime) + " dakika")
                    .font(.popLightSubheadline)
            }
        }
        .padding()
        .frame(width: UI.Size.Screen.width - 32)
        .backgroundWithShadow()
    }
    
    private var priceInfo: some View {

        VStack(spacing: UI.Spacing.p2) {
            Text("Ücretler")
                .font(.popRegularBody)
            
            Rectangle().frame(width: UI.Size.Screen.width - 50, height: 1)
                .foregroundStyle(Color.black.opacity(0.3))
            
            ForEach(parseFeeScheduleToUiModel(schedule: carPark.formattedPrices).keys.sorted(), id: \.self) { key in
                Group {
                    Text(key)
                        .font(.popRegularBody)
                    if let price = parseFeeScheduleToUiModel(schedule: carPark.formattedPrices)[key] {
                        Text(price + "TL")
                            .font(.popLightSubheadline)
                    }
                }
                Rectangle().frame(width: UI.Size.Screen.width - 50, height: 1)
                    .foregroundStyle(Color.black.opacity(0.3))
            }
            Group {
                Text(Strings.mountlyPrice)
                    .font(.popRegularBody)
                Text(String(Int(carPark.parkDetail.monthlyFee)) + " TL")
                    .font(.popLightSubheadline)
            }
        }
        .padding()
        .frame(width: UI.Size.Screen.width - 32)
        .backgroundWithShadow()
    }
    
    private func openMapsForDirection() {
        let latitude = carPark.lat
        let longitude = carPark.lng
        
        let appleMapsURL = URL(string: "http://maps.apple.com/?daddr=\(latitude),\(longitude)")!

        if UIApplication.shared.canOpenURL(appleMapsURL) {
            UIApplication.shared.open(appleMapsURL, options: [:], completionHandler: nil)
        }
    }
    
    func parseFeeScheduleToUiModel(schedule: String) -> [String: String] {
        var scheduleMap = [String: String]()
        let scheduleEntries = schedule.split(separator: ";")

        for entry in scheduleEntries {
            let parts = entry.split(separator: ":")
            if parts.count == 2 {
                let hoursRange = parts[0].trimmingCharacters(in: .whitespaces)
                let price = parts[1].trimmingCharacters(in: .whitespaces)
                scheduleMap[hoursRange] = price
            }
        }
        return scheduleMap
    }
}

#Preview {
    CarParkDetailView(homeViewModel: HomeViewModel(), carPark: CarParkModel.defaultCarPark, showDeleteButton: true)
}
