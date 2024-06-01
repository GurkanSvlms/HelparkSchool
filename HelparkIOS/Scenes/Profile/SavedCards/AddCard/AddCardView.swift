//
//  AddCardView.swift
//  HelparkIOS
//
//  Created by Ali Gürkan Sevilmis on 1.06.2024.
//

import SwiftUI

struct AddCardView: View {
    
    @StateObject private var viewModel = AddCardViewModel()
    @EnvironmentObject var navigationManager: NavigationManager
    
    @State private var userId = ""
    @State private var cardName = ""
    @State private var cardAlias = ""
    @State private var cardNumber = ""
    @State private var cardMonth = ""
    @State private var cardYear = ""
    @State private var cvv = ""
    
    @State private var showPopup = false
    @State private var popupTitle = ""
    @State private var popupSubtitle = ""
    
    private var cardDate : String{
        return (cardMonth + cardYear)
    }
    
    private var buttonEnabled: Bool {
        !cardName.isEmpty &&
        !cardAlias.isEmpty &&
        !cardNumber.isEmpty &&
        !cardDate.isEmpty &&
        !cvv.isEmpty
    }
    
    var body: some View {
        VStack {
            ScrollView {
                VStack(spacing: 16){
                    
                    ValidationTextField(
                        text: $cardName,
                        placeholder: "Kart İsmi",
                        fontColor: Color("#3c7484"))
                    
                    ValidationTextField(
                        text: $cardAlias,
                        placeholder: "Kart Üzerindeki İsim",
                        fontColor: Color("#3c7484"))
                    
                    ValidationTextField(
                        text: $cardNumber,
                        placeholder: "Kart Numarası",
                        fontColor: Color("#3c7484"))
                    HStack{
                        ValidationTextField(
                            text: $cardMonth,
                            placeholder: "Ay",
                            fontColor: Color("#3c7484"))
                        ValidationTextField(
                            text: $cardYear,
                            placeholder: "Yıl",
                            fontColor: Color("#3c7484"))
                        ValidationTextField(
                            text: $cvv,
                            placeholder: "Cvv",
                            fontColor: Color("#3c7484"))
                    }
                    
                }
                .navigationTitle("Kart Ekle")
                .navigationBarTitleDisplayMode(.inline)
                .navigationBarBackButtonHidden(true)
                .navigationBarItems(leading: CustomBackButtonView())
                .padding(.horizontal)
                .padding(.top, 40)
            }
            Spacer()
            
            Button(action: {
                viewModel.addCardFunction(
                    userId: Int(userId) ?? 1,
                    cardName: cardName,
                    cardAlias: cardAlias,
                    cardNumber: cardNumber,
                    cardDate: cardDate,
                    cvv: cvv,
                    cardTypeId: 1)
            }) {
                Text("Kart Ekle")
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
                userId = HPUserDefaultsManager.shared.getModel(.userID, String.self)
            } catch {
                print(HPUserDefaultsError.encodingFailed.localizedDescription)
            }
        }
        .onChange(of: viewModel.returnCardView, perform: { value in
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
    AddCardView()
}
