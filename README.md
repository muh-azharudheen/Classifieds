# Classifieds

Deployment Target: iOS 14.0,
Xcode Version: Xcode 12.0 +

### Notes
1. Used MVVVM with with clear seperation to each modules.   
2. Noted that image url is expiring after some time, but imageId Remains same. Currently image is cached againist absolute urlString to the image URL, this has to be replaced with imageID.  
3. Testing/Automation is Written only for one view controller with limited number of tests.
