//
//  AddBalanceView.swift
//  HelparkIOS
//
//  Created by Ali Gürkan Sevilmis on 2.06.2024.
//

import SwiftUI

struct AddBalanceView: View {
    @StateObject var viewModel = AddBalanceViewModel()

    @Binding var showCardSelection : Bool
    @Binding var showEnterBalance : Bool
    @State private var balance = ""
    @State private var userId = 0
    
    var body: some View {
        VStack {
            Text("Bakiye Gir")
                .font(.headline)
                .foregroundColor(.black)
                .padding(.top, 24)
            
            TextField("Bakiye Gir", text: $balance)
                .keyboardType(.decimalPad)
                .font(.title)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(10)
                .padding(.horizontal, 20)
            
            Spacer()
            Button(action: {
                viewModel.addBalance(userId: userId, balance: Double(balance) ?? 0.0)
            }) {
                Text("Bakiye Yükle")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(width: 330)
                    .padding()
                    .background(Color("#3c7484"))
                    .cornerRadius(16)
            }
            .opacity(balance != "" ? 1.0 : 0.5)
            .disabled(balance == "")
        }
        .navigationBarHidden(true)
        .onAppear{
            do {
                try userId = Int(HPUserDefaultsManager.shared.getModel(.userID, String.self)) ?? 1
                
            } catch {
                print(HPUserDefaultsError.encodingFailed.localizedDescription)
            }
        }
        .onChange(of: viewModel.returnProfileView, perform: { value in
            if value{
                showCardSelection = false
                showEnterBalance = false
            }
        })
    }
}

#Preview {
    AddBalanceView(showCardSelection: .constant(true), showEnterBalance: .constant(true))
}
