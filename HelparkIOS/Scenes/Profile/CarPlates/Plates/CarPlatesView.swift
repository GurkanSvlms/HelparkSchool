//
//  CarPlatesView.swift
//  HelparkIOS
//
//  Created by Ali Gürkan Sevilmis on 2.06.2024.
//

import SwiftUI

struct CarPlatesView: View {
    @StateObject var viewModel = ProfileMenuViewModel()
    @StateObject var deleteViewModel = CarPlateViewModel()
    @ObservedObject var reservationViewModel = RezervationViewModel()

    @EnvironmentObject var navigationManager: NavigationManager
    @State private var userId = ""
    @State private var plateId = ""
    @State private var showDeletePopup = false
    @State var selectButton = false
    @State var parkId : Int
    @State var resTime : Int
    @State var hire : Int
    
    var body: some View {
        ZStack{
            VStack {
                if viewModel.isLoading {
                    LoadingView()
                } else {
                    if viewModel.userPlates.isEmpty{
                        Spacer()
                        EmptyViewComponent(message: "Kayıtlı araç bulunamadı")
                    }
                    else{
                        ScrollView {
                            VStack {
                                ForEach(viewModel.userPlates, id: \.id) { plate in
                                    PlateItemView(
                                        carPlate: plate.plate,
                                        carModel: plate.model,
                                        carFuel: plate.fuelTypeId.rawValue)
                                    .onTapGesture {
                                        if selectButton{
                                            plateId = String(plate.plate)
                                        }
                                        else{
                                            showDeletePopup = true
                                            plateId = String(plate.plate)
                                        }
                                    }
                                }
                            }
                        }
                    }
                    
                    Spacer()
                    
                    if selectButton{
                        Button(action: {
                            do {
                                try reservationViewModel.addRezervation(userId: Int(HPUserDefaultsManager.shared.getModel(.userID, String.self)) ?? 2, carPlateId: Int(plateId) ?? 1, parkId: parkId, resTime: resTime, hire: hire)
                            } catch {
                                print(HPUserDefaultsError.encodingFailed.localizedDescription)
                            }
                        }) {
                            Text("Plaka Seç")
                                .font(.headline)
                                .foregroundColor(.white)
                                .frame(width: 330)
                                .padding()
                                .background(Color("#3c7484"))
                                .cornerRadius(16)
                        }
                    }
                    else{
                        Button(action: {
                            navigationManager.navigate(.profile(.addCar))
                        }) {
                            Text("Plaka Ekle")
                                .font(.headline)
                                .foregroundColor(.white)
                                .frame(width: 330)
                                .padding()
                                .background(Color("#3c7484"))
                                .cornerRadius(16)
                        }
                    }
                }
            }
            .navigationTitle("Kayıtlı Araçlarım")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(leading: CustomBackButtonView())
            .onAppear{
                do {
                    try userId = HPUserDefaultsManager.shared.getModel(.userID, String.self)
                    viewModel.fetchUserData(userId: userId)
                    
                } catch {
                    print(HPUserDefaultsError.encodingFailed.localizedDescription)
                }
            }
            .onChange(of: deleteViewModel.plateDeleted) { newValue in
                if newValue{
                    showDeletePopup = false
                    do {
                        try userId = HPUserDefaultsManager.shared.getModel(.userID, String.self)
                        viewModel.fetchUserData(userId: userId)
                        
                    } catch {
                        print(HPUserDefaultsError.encodingFailed.localizedDescription)
                    }
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
                           let userId = Int32(userIdString) {
                            deleteViewModel.deletePlate(carPlate: plateId)
                        }
                    }
            }
            
        }
    }
}

struct CarPlatesView_Previews: PreviewProvider {
    static var previews: some View {
        CarPlatesView(parkId: 1, resTime: 1, hire: 1)
    }
}
