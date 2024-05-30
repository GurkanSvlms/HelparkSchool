//
//  OtpView.swift
//  HelparkIOS
//
//  Created by Ali Gürkan Sevilmis on 30.05.2024.
//

import SwiftUI

struct OtpView: View {
    @State private var otpCode: String = ""
    @State private var timer: Int = 60
    @Binding var phoneNumber : String
    
    var maskedPhoneNumber: String {
        let maskedPart = String(phoneNumber.prefix(phoneNumber.count - 4)).replacingOccurrences(of: ".", with: "*")
        let visiblePart = String(phoneNumber.suffix(4))
        return maskedPart + visiblePart
    }
    
    var body: some View {
        VStack {
            HStack {
                Text("Lütfen \(maskedPhoneNumber) numaralı telefonunuza gönderilen doğrulama kodunu giriniz")

                    .font(.popSemiboldCallout)
                    .multilineTextAlignment(.center)
                    .padding()
            }
            HStack(spacing: 10) {
                ForEach(0..<6) { index in
                    TextField("", text: Binding(
                        get: {
                            let otpArray = Array(otpCode)
                            return index < otpArray.count ? String(otpArray[index]) : ""
                        },
                        set: { newValue in
                            if newValue.count <= 1 && otpCode.count < 6 {
                                otpCode.append(newValue)
                            }
                        }
                    ))
                    .frame(width: 50, height: 50)
                    .background(Color(UIColor.systemGray6))
                    .cornerRadius(12)
                    .multilineTextAlignment(.center)
                    .keyboardType(.numberPad)
                }
            }
            .padding()
            HStack {
                Text("\(timer) Sn")
                Spacer()
                Button(action: {
                    // Kod tekrar gönderme işlemi
                }) {
                    Text("Kodu Tekrar Gönder")
                        .foregroundColor(Color("#3c7484"))
                }
            }
            .padding(.horizontal, 40)
            .padding(.top, 12)
            
            ProgressView(value: Double(60 - timer), total: 60)
                .progressViewStyle(LinearProgressViewStyle(tint: Color("#3c7484")))
                .padding(.horizontal, 40)
                .padding(.top, 10)
            
            Button(action: {
                // Doğrulama işlemi
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
            Spacer()
        }
        .navigationTitle("Doğrulama Kodu")
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: CustomBackButtonView())
        .onAppear {
            startTimer()
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
