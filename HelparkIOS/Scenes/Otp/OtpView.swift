//
//  OtpView.swift
//  HelparkIOS
//
//  Created by Ali Gürkan Sevilmis on 30.05.2024.
//

import SwiftUI

struct OtpView: View {
    @StateObject private var viewModel = OtpViewModel()
    @EnvironmentObject var navigationManager: NavigationManager

    @State private var otpCode: String = ""
    @State private var timer: Int = 60
    @Binding var phoneNumber : String
    
    @State private var showPopup = false
    @State private var popupTitle = "Hata"
    @State private var popupSubtitle = "Girdiğiniz Kod Yanlıştır, Lütfen Tekrar Deneyiniz"
    
    var maskedPhoneNumber: String {
        let maskedPart = String(phoneNumber.prefix(phoneNumber.count - 4)).replacingOccurrences(of: ".", with: "*")
        let visiblePart = String(phoneNumber.suffix(4))
        return maskedPart + visiblePart
    }
    
    var body: some View {
        ZStack {
            VStack {
                HStack {
                    Text("Lütfen \(maskedPhoneNumber) numaralı telefonunuza gönderilen doğrulama kodunu giriniz")
                        .font(.popSemiboldCallout)
                        .multilineTextAlignment(.center)
                        .padding()
                }
                OtpFormFieldView(otpCode: $otpCode)
                    .padding()
                
                HStack {
                    Text("\(timer) Sn")
                    Spacer()
                    Button(action: {
                        viewModel.sendOtp(phoneNumber: phoneNumber)
                        timer = 60
                    }) {
                        Text("Kodu Tekrar Gönder")
                            .foregroundColor(Color("#3c7484"))
                    }
                    .opacity(!(timer == 0) ? 0.5 : 1.0)
                    .disabled(!(timer == 0))
                }
                .padding(.horizontal, 40)
                .padding(.top, 12)
                
                ProgressView(value: Double(60 - timer), total: 60)
                    .progressViewStyle(LinearProgressViewStyle(tint: Color("#3c7484")))
                    .padding(.horizontal, 40)
                    .padding(.top, 10)
                
                Button(action: {
                    if otpCode == "123456" {
                        viewModel.verifyPhoneNumber(phoneNumber: phoneNumber, otpCode: otpCode)
                    }
                    else {
                        showPopup = true
                        otpCode.removeAll()
                    }
                }) {
                    Text("Doğrula")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color("#3c7484"))
                        .foregroundColor(.white)
                        .cornerRadius(16)
                        .padding(.horizontal, 16)
                }
                .padding(.top, 16)
                .opacity(otpCode.count < 6 ? 0.5 : 1.0)
                .disabled(otpCode.count < 6)
                Spacer()
            }
            .navigationTitle("Doğrulama Kodu")
            .navigationBarBackButtonHidden(true)
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(leading: CustomBackButtonView())
            .onAppear {
                viewModel.sendOtp(phoneNumber: phoneNumber)
            }
            .onChange(of: viewModel.startTimer, perform: { value in
                if value {
                    startTimer()
                }
            })
            .onChange(of: viewModel.goToNextView, perform: { value in
                if value {
                    navigationManager.navigate(.home(.home))
                }
            })
            if showPopup {
                PopupOneButton(
                    title: popupTitle,
                    subtitle: popupSubtitle,
                    buttonText: "Tamam",
                    buttonAction: {
                        showPopup = false
                    }
                )
            }
        }
        .onDisappear{
            do {
                try HPUserDefaultsManager.shared.setModel(key: .userID, model: viewModel.userId)
            } catch {
                print(HPUserDefaultsError.encodingFailed.localizedDescription)
            }
        }
    }
    
    func startTimer() {
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
            if self.timer > 0 {
                self.timer -= 1
            } else {
                timer.invalidate()
            }
        }
    }
}

struct OtpView_Previews: PreviewProvider {
    static var previews: some View {
        OtpView(phoneNumber: .constant("5337832139"))
    }
}
