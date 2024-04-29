//
//  SearchBarView.swift
//  Helpark
//
//  Created by Ali Gürkan Sevilmis on 29.11.2023.
//

import SwiftUI

struct SearchBarView: View {
    @Binding var searchText: String
    @State var selectedDistrict: String?
    @State private var slideList = false

    let districts = ["İstanbul", "Ankara", "İzmir", "Adana", "Bursa", "Antalya"]

    var filteredDistricts: [String] {
        return districts.filter { $0.localizedCaseInsensitiveContains(searchText) || searchText.isEmpty }
    }

    var body: some View {
        VStack {
            HStack {
                TextField("Ara...", text: $searchText, onCommit: {

                })
                    .padding(8)
                    .background(Color(.systemGray6))
                    .cornerRadius(16)
            }
                .padding(.horizontal, 16)

            HStack {
                if slideList || !searchText.isEmpty {
                    withAnimation {
                        List(filteredDistricts, id: \.self) { district in
                            Text(district)
                                .onTapGesture {
                                selectedDistrict = district
                                searchText = selectedDistrict ?? ""
                            }
                        }
                            .listStyle(InsetGroupedListStyle())
                            .padding(.horizontal, 16)
                    }
                }
            }
        }.padding(.top, 8)
    }
}

struct SearchBarView_Previews: PreviewProvider {
    static var previews: some View {
        SearchBarView(searchText: .constant(""))
    }
}
