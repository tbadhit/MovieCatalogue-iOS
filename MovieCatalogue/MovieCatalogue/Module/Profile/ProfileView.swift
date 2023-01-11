//
//  ProfileView.swift
//  MovieCatalogue
//
//  Created by Tubagus Adhitya Permana on 03/01/23.
//

import SwiftUI
import Core

struct ProfileView: View {
    var body: some View {
        NavigationStack {
            VStack {
                Image("profile")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200)
                    .padding(.bottom, 10)
                Text("Tubagus Adhitya Permana")
                    .font(.title2)
                    .bold()
                    .padding(.bottom, 10)
                Text("iOS Developer")
                    .font(.title3)
                Spacer()
            }
            .padding(.top, 50)
            .navigationTitle("profile_title".localized(identifier: "tbadhit.Core"))
        }
        
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
