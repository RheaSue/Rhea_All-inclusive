//
//  HitronWidgetView.swift
//  Rhea_All-Inclusive
//
//  Created by Rhea on 2022/3/25.
//

import SwiftUI
import WidgetKit

struct HitronWidgetView: View {
    
    @Environment(\.widgetFamily) var family: WidgetFamily
    
    @ViewBuilder
    var body: some View {
        switch family {
        case .systemSmall:
            SmallHitronWidgetView()
        case .systemMedium:
            EmptyView()
        case .systemLarge:
            EmptyView()
        @unknown default:
            EmptyView()
        }
    }
}

struct HitronWidgetPlaceholderView: View {
    var body: some View {
      Color(UIColor.systemIndigo)
    }
}

struct SmallHitronWidgetView: View {
    var body: some View {
        ZStack {
            Color.theme_gray_background
            ZStack {
                VStack(alignment: .leading) {
                    Text("CODA-4582")
                        .foregroundColor(Color.init(white: 0.3))
                        .font((.system(size: 16, weight: .semibold)))
                                        
                    VStack {
                        HStack {
                            Image("m_devices_hitron")
                                .resizable()
                                .frame(width: 60, height: 60)
                                .padding(.trailing, 10)
                                                        
                            Text("11")
                                .foregroundColor(Color.theme_minor_color)
                                .font((.system(size: 28, weight: .semibold)))
                                .padding(.trailing, 10)
                        }
                        
                        Text("Internet is paused on 1 device(s)")
                            .foregroundColor(Color.theme_medium_gray)
                            .font((.system(size: 11, weight: .regular)))
                            .padding(.top, -5)
                        
                    }
                    .padding(.bottom, 5)
                }
            }
            .padding(.all, 5)
        }
    }
}

struct SmallHitronWidgetView_Previews: PreviewProvider {
    static var previews: some View {
        SmallHitronWidgetView()
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}

struct MediumHitronWidgetView: View {
    var data = ["第一个组件", "第二个组件", "第三个组件"]
    
    var body: some View {
        ZStack {
            Color.theme_gray_background
            ZStack {
                VStack(alignment: .leading, spacing: 0.0) {
                    Text("CODA-4582")
                        .foregroundColor(Color.init(white: 0.3))
                        .font((.system(size: 16, weight: .semibold)))
                    
                    HStack(alignment: .center, spacing: 2.0) {
                        
                        VStack(alignment: .center, spacing: 0.0) {
//                            HStack {
//
//                            }
                            
                            
                            Image("m_devices_hitron")
                                .resizable()
                                .frame(width: 50, height: 50)
                                                        
                            Text("11")
                                .foregroundColor(Color.theme_minor_color)
                                .font((.system(size: 20, weight: .semibold)))
                            
                            Text("Internet is paused on 1 device(s)")
                                .foregroundColor(Color.theme_medium_gray)
                                .font((.system(size: 10, weight: .regular)))
                                .frame(minWidth: 100, idealWidth: 100, maxWidth: 100)
//                                .padding(.top, -5)
//                                .padding(.leading, 5)
//                                .padding(.trailing, 5)
                            
                        }
                                                
                        VStack(alignment: .center, spacing: 0.0) {
//                            HStack {
//
//                            }
                            
                            Image("m_network_hitron")
                                .resizable()
                                .frame(width: 50, height: 50)
                                                        
                            Text("3")
                                .foregroundColor(Color.theme_minor_color)
                                .font((.system(size: 20, weight: .semibold)))
                            
                            Text("")
                                .foregroundColor(Color.theme_medium_gray)
                                .font((.system(size: 10, weight: .regular)))
                                .frame(minWidth: 100, idealWidth: 100, maxWidth: 100, minHeight: 26)
//                                .padding(.top, -5)
                            
                        }
                                                
                        VStack(alignment: .center, spacing: 0.0) {
//                            HStack {
//
//                            }
                            
                            Image("m_performance_hitron")
                                .resizable()
                                .frame(width: 50, height: 50)
                                                        
                            Text("1052")
                                .foregroundColor(Color.theme_minor_color)
                                .font((.system(size: 20, weight: .semibold)))
                            
                            Text("")
                                .foregroundColor(Color.theme_medium_gray)
                                .font((.system(size: 10, weight: .regular)))
                                .frame(minWidth: 100, idealWidth: 100, maxWidth: 100, minHeight: 26)
//                                .padding(.top, -5)
                            
                        }
                        
                    }
                    
                    
                }
            }
            .padding(.top, 5)
            .padding(.bottom, 5)
        }
    }
}

struct MediumHitronWidgetView_Previews: PreviewProvider {
    static var previews: some View {
        MediumHitronWidgetView()
            .previewContext(WidgetPreviewContext(family: .systemMedium))
    }
}
