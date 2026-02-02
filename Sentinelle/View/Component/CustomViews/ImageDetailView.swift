//
//  ImageDetailView.swift
//  Sentinelle
//
//  Created by Sebby on 16/12/2024.
//

import SwiftUI

struct ImageDetailView: View {
    @State var journal: Journal
    @State var currentIndex: Int = 0
    @State private var images: [Image] = []
    
    var body: some View {
        ZStack(alignment: .bottom) {
            // 1. Fond principal (Épuré)
            Color(uiColor: .systemBackground)
                .ignoresSafeArea()
            
            // 2. Zone de contenu principale
            TabView(selection: $currentIndex) {
                ForEach(0..<images.count, id: \.self) { index in
                    ZoomableScrollView {
                        images[index]
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                    }
                    .tag(index)
                    .ignoresSafeArea()
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            
            // 3. Barre de miniatures "Liquid Glass"
            thumbnailBar
                .padding(.bottom, 20)
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                VStack(spacing: 2) {
                    Text("Photo \(currentIndex + 1) sur \(images.count)")
                        .font(.system(.subheadline, design: .serif, weight: .bold))
                    Text(journal.dateFormated())
                        .font(.caption2)
                        .foregroundStyle(.secondary)
                }
            }
            
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    // Action Partage
                } label: {
                    Image(systemName: "square.and.arrow.up")
                        .font(.subheadline)
                }
            }
        }
        .onAppear { images = getImageData() }
    }
    
    private var thumbnailBar: some View {
        ScrollViewReader { proxy in
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 12) {
                    ForEach(0..<images.count, id: \.self) { index in
                        images[index]
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 48, height: 48)
                            .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                            .overlay {
                                RoundedRectangle(cornerRadius: 10, style: .continuous)
                                    .stroke(currentIndex == index ? Color.blue : .white.opacity(0.2), lineWidth: 1.5)
                            }
                            .scaleEffect(currentIndex == index ? 1.1 : 1.0)
                            .onTapGesture {
                                withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                                    currentIndex = index
                                }
                            }
                            .id(index)
                    }
                }
                .padding(.horizontal, 30)
                .padding(.vertical, 10)
            }
            .onChange(of: currentIndex) { _, newValue in
                withAnimation { proxy.scrollTo(newValue, anchor: .center) }
            }
        }
        // L'effet Liquid Glass : Un matériau fin sans fond dur
        .background(.ultraThinMaterial)
        .clipShape(Capsule())
        .padding(.horizontal)
        .shadow(color: .black.opacity(0.1), radius: 10, x: 0, y: 5)
    }

    func getImageData() -> [Image] {
        journal.imageData.compactMap { data in
            if let uiImage = UIImage(data: data) {
                return Image(uiImage: uiImage)
            }
            return nil
        }
    }
}

// MARK: - Moteur de Zoom Pro avec Double Tap
struct ZoomableScrollView<Content: View>: UIViewRepresentable {
    private var content: Content
    init(@ViewBuilder content: () -> Content) { self.content = content() }

    func makeUIView(context: Context) -> UIScrollView {
        let scrollView = UIScrollView()
        scrollView.delegate = context.coordinator
        scrollView.maximumZoomScale = 5.0
        scrollView.minimumZoomScale = 1.0
        scrollView.bouncesZoom = true
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false

        let hostedView = context.coordinator.hostingController.view!
        hostedView.translatesAutoresizingMaskIntoConstraints = false
        hostedView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        hostedView.backgroundColor = .clear
        scrollView.addSubview(hostedView)

        NSLayoutConstraint.activate([
            hostedView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
            hostedView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
            hostedView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            hostedView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
            hostedView.widthAnchor.constraint(equalTo: scrollView.frameLayoutGuide.widthAnchor),
            hostedView.heightAnchor.constraint(equalTo: scrollView.frameLayoutGuide.heightAnchor)
        ])

        // Ajout du Double Tap pour l'UX
        let doubleTap = UITapGestureRecognizer(target: context.coordinator, action: #selector(Coordinator.handleDoubleTap))
        doubleTap.numberOfTapsRequired = 2
        scrollView.addGestureRecognizer(doubleTap)

        return scrollView
    }

    func makeCoordinator() -> Coordinator {
        return Coordinator(hostingController: UIHostingController(rootView: content))
    }

    func updateUIView(_ uiView: UIScrollView, context: Context) {
        context.coordinator.hostingController.rootView = content
    }

    class Coordinator: NSObject, UIScrollViewDelegate {
        var hostingController: UIHostingController<Content>

        init(hostingController: UIHostingController<Content>) {
            self.hostingController = hostingController
        }

        func viewForZooming(in scrollView: UIScrollView) -> UIView? {
            return hostingController.view
        }

        @objc func handleDoubleTap(_ gesture: UITapGestureRecognizer) {
            guard let scrollView = gesture.view as? UIScrollView else { return }
            if scrollView.zoomScale > 1 {
                scrollView.setZoomScale(1, animated: true)
            } else {
                scrollView.setZoomScale(3, animated: true)
            }
        }
    }
}

#Preview {
    NavigationStack {
        ImageDetailView(journal: .preview1)
    }
}
