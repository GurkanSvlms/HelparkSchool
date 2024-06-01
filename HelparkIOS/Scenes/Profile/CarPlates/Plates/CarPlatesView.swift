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
    @EnvironmentObject var navigationManager: NavigationManager
    @State private var userId = ""
    @State private var plateId = ""
    @State private var showDeletePopup = false
    
    var body: some View {
        ZStack{
            VStack {
                if viewModel.isLoading {
                    LoadingView()
                } else {
                    ScrollView {
                        VStack {
                            ForEach(viewModel.userPlates, id: \.id) { plate in
                                PlateItemView(
                                    carPlate: plate.plate,
                                    carModel: plate.model,
                                    carFuel: plate.fuelTypeId.rawValue)
                                .onTapGesture {
                                    showDeletePopup = true
                                    plateId = String(plate.plate)
                                }
                            }
                        }
                    }
                    Spacer()
                    
                    Button(action: {
                        navigationManager.navigate(.profile(.addCard))
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
        CarPlatesView()
    }
}
