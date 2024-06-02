//
//  AddCarView.swift
//  HelparkIOS
//
//  Created by Ali Gürkan Sevilmis on 2.06.2024.
//

import SwiftUI

struct AddCarView: View {
    
    @StateObject private var viewModel = AddCarViewModel()
    @EnvironmentObject var navigationManager: NavigationManager
    
    @State private var userId = 0
    @State private var carPlate = ""
    @State private var carModel = ""
    @State private var selectedFuelType: FuelType?
    
    
    private var buttonEnabled: Bool {
        !carPlate.isEmpty &&
        !carModel.isEmpty &&
        !(selectedFuelType != nil)
    }
    
    var body: some View {
        VStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 16){
                    
                    ValidationTextField(
                        text: $carPlate,
                        placeholder: "Plaka",
                        fontColor: Color("#3c7484"))
                    
                    ValidationTextField(
                        text: $carModel,
                        placeholder: "Araç Modeli",
                        fontColor: Color("#3c7484"))
                    
                    Picker("Yakıt Tipi", selection: $selectedFuelType) {
                        ForEach(FuelType.allCases, id: \.self) { fuelType in
                            Text(fuelType.description)
                                .tag(fuelType)
                        }
                    }
                    .frame(width: 150, height: 50)
                    .pickerStyle(MenuPickerStyle())
                    .foregroundColor(.gray)
                    .font(.popRegularCallout)
                    .background(Color.white)
                    .overlay(RoundedRectangle(cornerRadius: 12).strokeBorder(Color.gray, lineWidth: 1))
                    
                }
                .navigationTitle("Araç Ekle")
                .navigationBarTitleDisplayMode(.inline)
                .navigationBarBackButtonHidden(true)
                .navigationBarItems(leading: CustomBackButtonView())
                .padding(.horizontal)
                .padding(.top, 40)
            }
            Spacer()
            
            Button(action: {
                viewModel.addCarFunction(
                    userId: userId,
                    plate: carPlate,
                    model: carModel,
                    fuelTypeId: selectedFuelType?.rawValue ?? 1)
            }) {
                Text("Araç Ekle")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(width: 330)
                    .padding()
                    .background(Color("#3c7484"))
                    .cornerRadius(16)
            }
            .opacity(buttonEnabled ? 1.0 : 0.5)
            .disabled(!buttonEnabled)
        }
        .onAppear{
            do {
                try
                userId = Int(HPUserDefaultsManager.shared.getModel(.userID, String.self)) ?? 0
            } catch {
                print(HPUserDefaultsError.encodingFailed.localizedDescription)
            }
        }
        .onChange(of: viewModel.returnCarView, perform: { value in
            if value{
                navigationManager.pop()
            }
        })
        .onTapGesture {
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        }
    }
}

#Preview {
    AddCarView()
}
