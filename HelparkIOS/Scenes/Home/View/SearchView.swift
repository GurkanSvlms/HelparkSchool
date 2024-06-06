//
//  SearchView.swift
//  HelparkIOS
//
//  Created by Ali Gürkan Sevilmis on 6.06.2024.
//

import SwiftUI

struct SearchView: View {
    @StateObject var viewModel = HomeViewModel()
    @State private var searchText = ""
    @Environment(\.presentationMode) var presentationMode


    var body: some View {
        NavigationView {
            VStack {
                // Search bar
                HStack {
                    Image(systemName: "magnifyingglass")
                    TextField("İlçe Ara", text: $searchText)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.horizontal)
                }
                .padding()
                
                // List of districts
                List {
                    ForEach(viewModel.districtList.filter {
                        searchText.isEmpty ? true : $0.sehir.contains(searchText) || $0.semt.contains(searchText)
                    }) { district in
                        Button(action: {
                            viewModel.selectedDistrict = district
                            presentationMode.wrappedValue.dismiss()

                        }) {
                            VStack(alignment: .leading) {
                                Text(district.semt)
                                    .font(.popMediumCallout)
                                    .foregroundColor(.gray)
                                    .padding(.vertical, 8)
                            }
                        }
                    }
                }
                
                Spacer()
            }
            .onAppear{
                viewModel.fetchDistrict()
            }
            .onDisappear{
                viewModel.fetchParksByRadius(district: viewModel.selectedDistrict?.semt, lat: viewModel.selectedDistrict?.lat ?? "" , lng: viewModel.selectedDistrict?.lng ?? "", radius: 7.0)
            }
            .navigationBarTitle("Search Districts", displayMode: .inline)
            .navigationBarItems(trailing: Button("Cancel") {
                viewModel.selectedDistrict = nil
            })
        }
        .navigationViewStyle(StackNavigationViewStyle()) // Full screen for all devices
    }
}

#Preview {
    SearchView(viewModel: HomeViewModel())
}
