//
//  ContentView.swift
//  Task2.1
//
//  Created by neoviso on 8/26/22.
//

import SwiftUI

struct ContentView: View {
    
    @State private var searchText = ""
    
    var body: some View {
        NavigationView {
            List(countries, id: \.self) { country in
                ListRowView(name: country, urlString: "https://en.wikipedia.org/wiki/" + country.addingPercentEncoding(withAllowedCharacters: .urlUserAllowed)!)
            }
            //.searchable(text: $searchText)
            .navigationTitle("Countries")
        }
    }
    
    var countries: [String] {
        let countryList = Locale.isoRegionCodes.compactMap { Locale.current.localizedString(forRegionCode: $0) }.sorted()
        let lcCountries = countryList.map { $0.lowercased() }
        return searchText.isEmpty ? lcCountries : lcCountries.filter { $0.contains(searchText.lowercased())
        }
    }
}

struct ListRowView: View {
    var name: String
    var urlString: String
    var body: some View {
        if let url = URL(string: urlString) {
            Link(destination: url, label: {
                Text(name)
                    .font(.headline)
                    .frame(width: 350, height: 20, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .foregroundColor(.white)
                    .background(Color.gray)
                    .cornerRadius(12)
             })
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewDevice("iPhone 11")
    }
}

