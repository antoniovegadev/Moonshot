//
//  AstronautView.swift
//  Moonshot
//
//  Created by Antonio Vega on 4/30/21.
//

import SwiftUI

struct AstronautView: View {
    let astronaut: Astronaut
    let missionsFlew: [Mission]
    
    init(astronaut: Astronaut) {
        self.astronaut = astronaut
        
        var matches = [Mission]()
        let missions: [Mission] = Bundle.main.decode("missions.json")
        
        for mission in missions {
            if mission.crew.contains(where: { $0.name == astronaut.id }) {
                matches.append(mission)
            }
        }
        
        self.missionsFlew = matches
    }
    
    var body: some View {
        GeometryReader { geo in
            ScrollView(.vertical) {
                VStack {
                    Image(astronaut.id)
                        .resizable()
                        .scaledToFit()
                        .frame(width: geo.size.width)
                    
                    Text(astronaut.description)
                        .padding()
                        .layoutPriority(1)
                    
                    HStack(alignment: .bottom) {
                        ForEach(missionsFlew) { mission in
                            VStack {
                                Image(mission.image)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: geo.size.width * 0.2)
                                
                                Text(mission.displayName)
                            }
                        }
                    }
                }
            }
        }
        .navigationBarTitle(Text(astronaut.name), displayMode: .inline)
    }
}

struct AstronautView_Previews: PreviewProvider {
    static let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")
    
    static var previews: some View {
        AstronautView(astronaut: astronauts[0])
    }
}
