
Pod::Spec.new do |s|

s.name         = "WKRefresh"
s.version      = "0.0.1"
s.summary      = "swift 实现的上拉刷新，下拉加载动效库"

s.homepage     = "https://github.com/KangSky123/refresh"

s.license      = { :type => "MIT", :file => "LICENSE" }
s.author       = {"HuangWenKang" => "417035863@qq.com" }


s.source       = { :git => "https://github.com/KangSky123/refresh.git", :tag => s.version }
s.source_files = "WKRefresh/*.swift"
s.resources    = 'WKRefresh/ScrollViewDataSourceManager/**/*'

s.ios.deployment_target = "8.0"
s.frameworks = "UIKit"

s.pod_target_xcconfig = { 'SWIFT_VERSION' => '4.0' }

s.dependency 'MJRefresh'

end
