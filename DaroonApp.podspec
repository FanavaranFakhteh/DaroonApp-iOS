Pod::Spec.new do |s|  
    s.name              = 'DaroonApp'
    s.version           = '1.0.0'
    s.summary           = 'DaroonApp payment system'
    s.homepage          = 'http://daroonapp.com/'

    s.author            = { 'Name' => 'zzmasoud' }
    s.license           = { :type => 'Apache-2.0', :file => 'LICENSE' }

    s.platform          = :ios
    s.source            = { :http => 'http://example.com/sdk/1.0.0/MySDK.zip' }

    s.ios.deployment_target = '8.0'
    s.ios.vendored_frameworks = 'DaroonApp.framework'
end  