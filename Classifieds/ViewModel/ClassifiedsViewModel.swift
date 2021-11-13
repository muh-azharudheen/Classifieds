//
//  ClassifiedsViewModel.swift
//  Classifieds
//
//  Created by Muhammed Azharudheen on 13/11/2021.
//

import Foundation

class ClassifiedsViewModel {
    
    private var classifieds = [Classified]()
    
    init() {
        classifieds = createClassifieds()
    }
    
    var reloadClosure: (() -> Void)?
    
    var showDetailClosure: ((DetailViewModel) -> Void)?
    
    var title: String { "home.welcome.message".localized }
    
    var subTitle: String { Date().toString() }
    
    var listTitle: String { "home.listing.title".localized }
    
    func numberOfLists() -> Int {
        classifieds.count
    }
    
    func list(index: Int) -> ListViewModel {
        classifieds[index].createListViewModel()
    }
    
    func didSelectItem(at index: Int) {
        let item = classifieds[index].createDetailViewModel()
        showDetailClosure?(item)
    }
    
    // TODO: to be deleted once api call is over
    private func createClassifieds() -> [Classified] {
        return [
            Classified(dateCreated: Date(), price: "AED 5", name: "Notebook", uuid: UUID(uuidString: "4878bf592579410fba52941d00b62f94") ?? UUID(), imageURL: URL(string: "https://demo-app-photos-45687895456123.s3.amazonaws.com/9355183956e3445e89735d877b798689-thumbnail?AWSAccessKeyId=ASIASV3YI6A4YX5LBDH2&Signature=81qpski0IRTmuwBmEkUMd%2Blimsg%3D&x-amz-security-token=IQoJb3JpZ2luX2VjEI3%2F%2F%2F%2F%2F%2F%2F%2F%2F%2FwEaCXVzLWVhc3QtMSJIMEYCIQDNlEETuTsjU93fXxn6kxDWWP2fJ83j1WOy0O7Z%2BSEChgIhANUnOykbdhPOB4sH4U%2F5HR6%2FqSMgn9EZq4Pyhv%2ByiBFQKpQCCEYQAxoMMTg0Mzk4OTY2ODQxIgyo%2Fr6vcUYCpJDIbLMq8QFmayvuZ3RqOi984F0ZRu6t9vXhBedU7ahx9z%2Fzqj5UyWbDqevBY94%2BNl5K%2FC5zsqwyiR3XgVAx9fLcSO%2FU8jO5XYyUjKfm0qr%2FQ9xO7VBWduzZyx%2BC8VcNNy68d2D%2FvuKUhEgdET%2FoMFeDgQrpGaoMGcA5DJyY3gcfxaATDufOrxFxBeBFCq37FPdpBsYTKrAQzXjXKDp7vtmdh9Q3Jij%2FVggRRAPFQbRIdfqR2DaWKBBPf1sFvF%2FqFZYqmYK5JeCKbCWaKFLgVC70Gtcos%2FLdHgxOlj2WVvBOCeo24A%2BXjfuQNpVOa%2F1n2r0c%2BPuYvxuHMOjovowGOpkBwxZJ0hW%2FpjA%2B2Xd8mtqA4oJUj8nu8I8kzWPApiZA5tj9GgUnDdJ0%2FHHevNeSm6WIhjEELPVOlc3P8GIdErtevb5sHtJAGVOxSd%2BSRCTkIME50UE2byMm7N5c9LNOVZX3fxBkYAncYmnX%2FN%2F0J3XVT5odBiK0W58wkLAr49LcNGy6LApX4aPYmo%2BYyySxBVJjUinsMeqywLRf&Expires=1636811387"), thumbnailURL: URL(string: "https://demo-app-photos-45687895456123.s3.amazonaws.com/9355183956e3445e89735d877b798689-thumbnail?AWSAccessKeyId=ASIASV3YI6A4YX5LBDH2&Signature=81qpski0IRTmuwBmEkUMd%2Blimsg%3D&x-amz-security-token=IQoJb3JpZ2luX2VjEI3%2F%2F%2F%2F%2F%2F%2F%2F%2F%2FwEaCXVzLWVhc3QtMSJIMEYCIQDNlEETuTsjU93fXxn6kxDWWP2fJ83j1WOy0O7Z%2BSEChgIhANUnOykbdhPOB4sH4U%2F5HR6%2FqSMgn9EZq4Pyhv%2ByiBFQKpQCCEYQAxoMMTg0Mzk4OTY2ODQxIgyo%2Fr6vcUYCpJDIbLMq8QFmayvuZ3RqOi984F0ZRu6t9vXhBedU7ahx9z%2Fzqj5UyWbDqevBY94%2BNl5K%2FC5zsqwyiR3XgVAx9fLcSO%2FU8jO5XYyUjKfm0qr%2FQ9xO7VBWduzZyx%2BC8VcNNy68d2D%2FvuKUhEgdET%2FoMFeDgQrpGaoMGcA5DJyY3gcfxaATDufOrxFxBeBFCq37FPdpBsYTKrAQzXjXKDp7vtmdh9Q3Jij%2FVggRRAPFQbRIdfqR2DaWKBBPf1sFvF%2FqFZYqmYK5JeCKbCWaKFLgVC70Gtcos%2FLdHgxOlj2WVvBOCeo24A%2BXjfuQNpVOa%2F1n2r0c%2BPuYvxuHMOjovowGOpkBwxZJ0hW%2FpjA%2B2Xd8mtqA4oJUj8nu8I8kzWPApiZA5tj9GgUnDdJ0%2FHHevNeSm6WIhjEELPVOlc3P8GIdErtevb5sHtJAGVOxSd%2BSRCTkIME50UE2byMm7N5c9LNOVZX3fxBkYAncYmnX%2FN%2F0J3XVT5odBiK0W58wkLAr49LcNGy6LApX4aPYmo%2BYyySxBVJjUinsMeqywLRf&Expires=1636811387")),
            Classified(dateCreated: Date(), price: "AED 500", name: "Glasses", uuid: UUID(uuidString: "bdf455e89f3b49f484d2a181b0268eab") ?? UUID(), imageURL: URL(string: "https://demo-app-photos-45687895456123.s3.amazonaws.com/46a0c97762ba449cb49b3575681a4d84?AWSAccessKeyId=ASIASV3YI6A4YX5LBDH2&Signature=xufhA%2Fv%2Bu8PGkD2UMAGzkMWavwI%3D&x-amz-security-token=IQoJb3JpZ2luX2VjEI3%2F%2F%2F%2F%2F%2F%2F%2F%2F%2FwEaCXVzLWVhc3QtMSJIMEYCIQDNlEETuTsjU93fXxn6kxDWWP2fJ83j1WOy0O7Z%2BSEChgIhANUnOykbdhPOB4sH4U%2F5HR6%2FqSMgn9EZq4Pyhv%2ByiBFQKpQCCEYQAxoMMTg0Mzk4OTY2ODQxIgyo%2Fr6vcUYCpJDIbLMq8QFmayvuZ3RqOi984F0ZRu6t9vXhBedU7ahx9z%2Fzqj5UyWbDqevBY94%2BNl5K%2FC5zsqwyiR3XgVAx9fLcSO%2FU8jO5XYyUjKfm0qr%2FQ9xO7VBWduzZyx%2BC8VcNNy68d2D%2FvuKUhEgdET%2FoMFeDgQrpGaoMGcA5DJyY3gcfxaATDufOrxFxBeBFCq37FPdpBsYTKrAQzXjXKDp7vtmdh9Q3Jij%2FVggRRAPFQbRIdfqR2DaWKBBPf1sFvF%2FqFZYqmYK5JeCKbCWaKFLgVC70Gtcos%2FLdHgxOlj2WVvBOCeo24A%2BXjfuQNpVOa%2F1n2r0c%2BPuYvxuHMOjovowGOpkBwxZJ0hW%2FpjA%2B2Xd8mtqA4oJUj8nu8I8kzWPApiZA5tj9GgUnDdJ0%2FHHevNeSm6WIhjEELPVOlc3P8GIdErtevb5sHtJAGVOxSd%2BSRCTkIME50UE2byMm7N5c9LNOVZX3fxBkYAncYmnX%2FN%2F0J3XVT5odBiK0W58wkLAr49LcNGy6LApX4aPYmo%2BYyySxBVJjUinsMeqywLRf&Expires=1636811387"), thumbnailURL: URL(string: "https://demo-app-photos-45687895456123.s3.amazonaws.com/46a0c97762ba449cb49b3575681a4d84-thumbnail?AWSAccessKeyId=ASIASV3YI6A4YX5LBDH2&Signature=FciiZ8INhkSlZ%2BOOD1jyJNysteo%3D&x-amz-security-token=IQoJb3JpZ2luX2VjEI3%2F%2F%2F%2F%2F%2F%2F%2F%2F%2FwEaCXVzLWVhc3QtMSJIMEYCIQDNlEETuTsjU93fXxn6kxDWWP2fJ83j1WOy0O7Z%2BSEChgIhANUnOykbdhPOB4sH4U%2F5HR6%2FqSMgn9EZq4Pyhv%2ByiBFQKpQCCEYQAxoMMTg0Mzk4OTY2ODQxIgyo%2Fr6vcUYCpJDIbLMq8QFmayvuZ3RqOi984F0ZRu6t9vXhBedU7ahx9z%2Fzqj5UyWbDqevBY94%2BNl5K%2FC5zsqwyiR3XgVAx9fLcSO%2FU8jO5XYyUjKfm0qr%2FQ9xO7VBWduzZyx%2BC8VcNNy68d2D%2FvuKUhEgdET%2FoMFeDgQrpGaoMGcA5DJyY3gcfxaATDufOrxFxBeBFCq37FPdpBsYTKrAQzXjXKDp7vtmdh9Q3Jij%2FVggRRAPFQbRIdfqR2DaWKBBPf1sFvF%2FqFZYqmYK5JeCKbCWaKFLgVC70Gtcos%2FLdHgxOlj2WVvBOCeo24A%2BXjfuQNpVOa%2F1n2r0c%2BPuYvxuHMOjovowGOpkBwxZJ0hW%2FpjA%2B2Xd8mtqA4oJUj8nu8I8kzWPApiZA5tj9GgUnDdJ0%2FHHevNeSm6WIhjEELPVOlc3P8GIdErtevb5sHtJAGVOxSd%2BSRCTkIME50UE2byMm7N5c9LNOVZX3fxBkYAncYmnX%2FN%2F0J3XVT5odBiK0W58wkLAr49LcNGy6LApX4aPYmo%2BYyySxBVJjUinsMeqywLRf&Expires=1636811387")),
            Classified(dateCreated: Date(), price: "AED 600", name: "Monitor", uuid: UUID(uuidString: "b27233dd372543ffae38cce03ea9f047") ?? UUID(), imageURL: URL(string: "https://demo-app-photos-45687895456123.s3.amazonaws.com/5cfcab40ab9048c0b265468b9eea8cd8?AWSAccessKeyId=ASIASV3YI6A4YX5LBDH2&Signature=37OTZ%2FRfsDg%2Fdqs0JiY1%2Fo4U5H8%3D&x-amz-security-token=IQoJb3JpZ2luX2VjEI3%2F%2F%2F%2F%2F%2F%2F%2F%2F%2FwEaCXVzLWVhc3QtMSJIMEYCIQDNlEETuTsjU93fXxn6kxDWWP2fJ83j1WOy0O7Z%2BSEChgIhANUnOykbdhPOB4sH4U%2F5HR6%2FqSMgn9EZq4Pyhv%2ByiBFQKpQCCEYQAxoMMTg0Mzk4OTY2ODQxIgyo%2Fr6vcUYCpJDIbLMq8QFmayvuZ3RqOi984F0ZRu6t9vXhBedU7ahx9z%2Fzqj5UyWbDqevBY94%2BNl5K%2FC5zsqwyiR3XgVAx9fLcSO%2FU8jO5XYyUjKfm0qr%2FQ9xO7VBWduzZyx%2BC8VcNNy68d2D%2FvuKUhEgdET%2FoMFeDgQrpGaoMGcA5DJyY3gcfxaATDufOrxFxBeBFCq37FPdpBsYTKrAQzXjXKDp7vtmdh9Q3Jij%2FVggRRAPFQbRIdfqR2DaWKBBPf1sFvF%2FqFZYqmYK5JeCKbCWaKFLgVC70Gtcos%2FLdHgxOlj2WVvBOCeo24A%2BXjfuQNpVOa%2F1n2r0c%2BPuYvxuHMOjovowGOpkBwxZJ0hW%2FpjA%2B2Xd8mtqA4oJUj8nu8I8kzWPApiZA5tj9GgUnDdJ0%2FHHevNeSm6WIhjEELPVOlc3P8GIdErtevb5sHtJAGVOxSd%2BSRCTkIME50UE2byMm7N5c9LNOVZX3fxBkYAncYmnX%2FN%2F0J3XVT5odBiK0W58wkLAr49LcNGy6LApX4aPYmo%2BYyySxBVJjUinsMeqywLRf&Expires=1636811387"), thumbnailURL: URL(string: "https://demo-app-photos-45687895456123.s3.amazonaws.com/5cfcab40ab9048c0b265468b9eea8cd8-thumbnail?AWSAccessKeyId=ASIASV3YI6A4YX5LBDH2&Signature=H78lvKidkrFonXSoyKEMuGJVj6M%3D&x-amz-security-token=IQoJb3JpZ2luX2VjEI3%2F%2F%2F%2F%2F%2F%2F%2F%2F%2FwEaCXVzLWVhc3QtMSJIMEYCIQDNlEETuTsjU93fXxn6kxDWWP2fJ83j1WOy0O7Z%2BSEChgIhANUnOykbdhPOB4sH4U%2F5HR6%2FqSMgn9EZq4Pyhv%2ByiBFQKpQCCEYQAxoMMTg0Mzk4OTY2ODQxIgyo%2Fr6vcUYCpJDIbLMq8QFmayvuZ3RqOi984F0ZRu6t9vXhBedU7ahx9z%2Fzqj5UyWbDqevBY94%2BNl5K%2FC5zsqwyiR3XgVAx9fLcSO%2FU8jO5XYyUjKfm0qr%2FQ9xO7VBWduzZyx%2BC8VcNNy68d2D%2FvuKUhEgdET%2FoMFeDgQrpGaoMGcA5DJyY3gcfxaATDufOrxFxBeBFCq37FPdpBsYTKrAQzXjXKDp7vtmdh9Q3Jij%2FVggRRAPFQbRIdfqR2DaWKBBPf1sFvF%2FqFZYqmYK5JeCKbCWaKFLgVC70Gtcos%2FLdHgxOlj2WVvBOCeo24A%2BXjfuQNpVOa%2F1n2r0c%2BPuYvxuHMOjovowGOpkBwxZJ0hW%2FpjA%2B2Xd8mtqA4oJUj8nu8I8kzWPApiZA5tj9GgUnDdJ0%2FHHevNeSm6WIhjEELPVOlc3P8GIdErtevb5sHtJAGVOxSd%2BSRCTkIME50UE2byMm7N5c9LNOVZX3fxBkYAncYmnX%2FN%2F0J3XVT5odBiK0W58wkLAr49LcNGy6LApX4aPYmo%2BYyySxBVJjUinsMeqywLRf&Expires=1636811387"))
        ]
    }
}

private extension Classified {
    func createListViewModel() -> ListViewModel {
      ListViewModel(title: name, subtitle: price, imageURL: thumbnailURL)
    }
    
    func createDetailViewModel() -> DetailViewModel {
        let viewModel = DetailViewModel(title: name, subTitle: dateCreated.toString(), price: price)
        if let url = imageURL {
            viewModel.imageURL = url
        }
        return viewModel
    }
}

private extension Date {
    func toString() -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale.current
        formatter.dateFormat = "MMM dd EEEE"
        return formatter.string(from: self)
    }
}
