//
//  OtpFormFieldView.swift
//  HelparkIOS
//
//  Created by Ali Gürkan Sevilmis on 1.06.2024.
//

import SwiftUI
import Combine

struct OtpFormFieldView: View {
    enum FocusPin {
        case pinOne, pinTwo, pinThree, pinFour, pinFive, pinSix
    }

    @FocusState private var pinFocusState: FocusPin?
    @Binding var otpCode: String
    @State var pinOne: String = ""
    @State var pinTwo: String = ""
    @State var pinThree: String = ""
    @State var pinFour: String = ""
    @State var pinFive: String = ""
    @State var pinSix: String = ""

    var body: some View {
        HStack(spacing: 10) {
            TextField("", text: $pinOne)
                .padding()
                .background(Color.white)
                .cornerRadius(8)
                .shadow(radius: 1)
                .multilineTextAlignment(.center)
                .keyboardType(.numberPad)
                .onChange(of: pinOne) { newVal in
                    if newVal.count == 1 {
                        otpCode.append(newVal)
                        pinFocusState = .pinTwo
                    }
                }
                .focused($pinFocusState, equals: .pinOne)

            TextField("", text: $pinTwo)
                .padding()
                .background(Color.white)
                .cornerRadius(8)
                .shadow(radius: 1)
                .multilineTextAlignment(.center)
                .keyboardType(.numberPad)
                .onChange(of: pinTwo) { newVal in
                    if newVal.count == 1 {
                        otpCode.append(newVal)
                        pinFocusState = .pinThree
                    } else if newVal.count == 0 {
                        otpCode.removeLast()
                        pinFocusState = .pinOne
                    }
                }
                .focused($pinFocusState, equals: .pinTwo)

            TextField("", text: $pinThree)
                .padding()
                .background(Color.white)
                .cornerRadius(8)
                .shadow(radius: 1)
                .multilineTextAlignment(.center)
                .keyboardType(.numberPad)
                .onChange(of: pinThree) { newVal in
                    if newVal.count == 1 {
                        otpCode.append(newVal)
                        pinFocusState = .pinFour
                    } else if newVal.count == 0 {
                        otpCode.removeLast()
                        pinFocusState = .pinTwo
                    }
                }
                .focused($pinFocusState, equals: .pinThree)

            TextField("", text: $pinFour)
                .padding()
                .background(Color.white)
                .cornerRadius(8)
                .shadow(radius: 1)
                .multilineTextAlignment(.center)
                .keyboardType(.numberPad)
                .onChange(of: pinFour) { newVal in
                    if newVal.count == 1 {
                        otpCode.append(newVal)
                        pinFocusState = .pinFive
                    } else if newVal.count == 0 {
                        otpCode.removeLast()
                        pinFocusState = .pinThree
                    }
                }
                .focused($pinFocusState, equals: .pinFour)

            TextField("", text: $pinFive)
                .padding()
                .background(Color.white)
                .cornerRadius(8)
                .shadow(radius: 1)
                .multilineTextAlignment(.center)
                .keyboardType(.numberPad)
                .onChange(of: pinFive) { newVal in
                    if newVal.count == 1 {
                        otpCode.append(newVal)
                        pinFocusState = .pinSix
                    } else if newVal.count == 0 {
                        otpCode.removeLast()
                        pinFocusState = .pinFour
                    }
                }
                .focused($pinFocusState, equals: .pinFive)

            TextField("", text: $pinSix)
                .padding()
                .background(Color.white)
                .cornerRadius(8)
                .shadow(radius: 1)
                .multilineTextAlignment(.center)
                .keyboardType(.numberPad)
                .onChange(of: pinSix) { newVal in
                    if newVal.count == 1 {
                        otpCode.append(newVal)
                    } else if newVal.count == 0 {
                        otpCode.removeLast()
                        pinFocusState = .pinFive
                    }
                }
                .focused($pinFocusState, equals: .pinSix)
        }
        .padding()
    }
}

struct OtpFormFieldView_Previews: PreviewProvider {
    static var previews: some View {
        OtpFormFieldView(otpCode: .constant(""))
    }
}
