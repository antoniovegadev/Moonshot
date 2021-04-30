//
//  ContentView.swift
//  Moonshot
//
//  Created by Antonio Vega on 4/29/21.
//

import SwiftUI

struct ContentView: View {
    let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")
    let missions: [Mission] = Bundle.main.decode("missions.json")
    
    @State private var showDate = true

    var body: some View {
        NavigationView {
            List(missions) { mission in
                NavigationLink(destination: MissionView(mission: mission, astronauts: astronauts)) {
                    HStack {
                        Image(mission.image)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 44, height: 44)
                        
                        VStack(alignment: .leading) {
                            Text(mission.displayName)
                                .font(.headline)
                            if showDate {
                                Text(mission.formattedLaunchDate)
                            } else {
                                HStack {
                                    ForEach(mission.crew, id: \.name) {
                                        Text($0.name)
                                    }
                                }
                            }
                        }
                    }
                }
            }
            .listStyle(PlainListStyle())
            .navigationBarTitle("Moonshot")
            .navigationBarItems(trailing: Button(showDate ? "Show Crew" : "Show Date") {
                showDate.toggle()
            })
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
