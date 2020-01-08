//
//  CommentsView.swift
//  SwifUITest
//
//  Created by Tomas Green on 2019-10-09.
//  Copyright © 2019 Evry AB. All rights reserved.
//

import SwiftUI
import URLImage
//import TextView

struct RoundedCorners: Shape {
    var tl: CGFloat = 0.0
    var tr: CGFloat = 0.0
    var bl: CGFloat = 0.0
    var br: CGFloat = 0.0

    func path(in rect: CGRect) -> Path {
        var path = Path()

        let w = rect.size.width
        let h = rect.size.height

        // Make sure we do not exceed the size of the rectangle
        let tr = min(min(self.tr, h/2), w/2)
        let tl = min(min(self.tl, h/2), w/2)
        let bl = min(min(self.bl, h/2), w/2)
        let br = min(min(self.br, h/2), w/2)

        path.move(to: CGPoint(x: w / 2.0, y: 0))
        path.addLine(to: CGPoint(x: w - tr, y: 0))
        path.addArc(center: CGPoint(x: w - tr, y: tr), radius: tr,
                    startAngle: Angle(degrees: -90), endAngle: Angle(degrees: 0), clockwise: false)

        path.addLine(to: CGPoint(x: w, y: h - br))
        path.addArc(center: CGPoint(x: w - br, y: h - br), radius: br,
                    startAngle: Angle(degrees: 0), endAngle: Angle(degrees: 90), clockwise: false)

        path.addLine(to: CGPoint(x: bl, y: h))
        path.addArc(center: CGPoint(x: bl, y: h - bl), radius: bl,
                    startAngle: Angle(degrees: 90), endAngle: Angle(degrees: 180), clockwise: false)

        path.addLine(to: CGPoint(x: 0, y: tl))
        path.addArc(center: CGPoint(x: tl, y: tl), radius: tl,
                    startAngle: Angle(degrees: 180), endAngle: Angle(degrees: 270), clockwise: false)

        return path
    }
}
struct ButtonBackgroundShape: Shape {

    var cornerRadius: CGFloat
    var style: RoundedCornerStyle

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: [.topLeft, .topRight], cornerRadii: CGSize(width: cornerRadius, height: cornerRadius))
        return Path(path.cgPath)
    }
}
fileprivate func roundedAsyncImage(from url:URL) -> some View {
    return URLImage(url,incremental: true) { proxy in
        proxy.image.resizable().aspectRatio(contentMode: .fill)
    }.frame(width: 30, height: 30, alignment: .center).cornerRadius(15).padding(Edge.Set.top, 8)
}

struct CommentListItem: View {
    @State var userComment = false
    @State var comment:CommentViewModel
    var body: some View {
        HStack(alignment: .top, spacing: 5) {
            if userComment == false {
                roundedAsyncImage(from: comment.user.image)
            } else {
                Spacer().frame(width: 40, height: nil, alignment: .center)
            }
            VStack(alignment: .leading) {
                VStack(alignment: .leading) {
                    Image("test.png").resizable().aspectRatio(contentMode: .fill).frame(width: nil, height: 200, alignment: Alignment.center).clipped()
                    Text("header").font(Font.headline).padding(EdgeInsets(top: 3, leading: 16, bottom: 0, trailing: 16))
                    Text("text").font(Font.body).padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
                    Text("www.svt.se - 2019 10 10 kl 14:00").font(Font.footnote).foregroundColor(Color(UIColor.secondaryLabel)).padding(EdgeInsets(top: 3, leading: 16, bottom: 3, trailing: 16))
                    Divider()
                }.background(Color(UIColor.tertiarySystemBackground))
                VStack(alignment: .leading, spacing: 3) {
                    Text(comment.user.name).font(Font.caption).foregroundColor(Color(UIColor.secondaryLabel))
                    Text(comment.content)
                }.foregroundColor(userComment ? Color(UIColor.white) : Color(UIColor.label))
                .padding(EdgeInsets(top: 3, leading: 16, bottom: 16, trailing: 16))
            }
            .background(userComment ? Color(UIColor.blue) : Color(UIColor.secondarySystemBackground))
            .cornerRadius(16)
                //.background(RoundedCorners(tl: 0, tr: 30, bl: 30, br: 0).fill(Color.blue))
        }.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: userComment ? .trailing : .leading)
    }
}


struct CommentList: View {
    @State var comments:[CommentViewModel]
    var body: some View {
        GeometryReader { geometry in
            NavigationView() {
                VStack(spacing: 0) {
                    List() {
                        ForEach(self.comments) { comment in
                            CommentListItem(comment:comment)
                        }
                    }
                    BottomTextView(geometry: geometry)
                }.navigationBarTitle("Comments")
            }
        }
    }
}


struct CommentsView_Previews: PreviewProvider {
    static var previews: some View {
        CommentList(comments: [CommentViewModel]())
    }
}
