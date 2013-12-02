Autoproj.manifest.each_autobuild_package do |pkg|
    next if !pkg.kind_of?(Autobuild::Orogen)
    if pkg.name != "tools/logger" && pkg.name != "base/orogen/types" && pkg.name != 'base/orogen/std'
        pkg.optional_dependency 'tools/logger'
    end

    if Autoproj.user_config('ROCK_FLAVOR') == 'master'
        pkg.orogen_options << '--extensions=metadata_support'
    end
    if pkg.name != 'base/orogen/std'
        pkg.optional_dependency 'base/orogen/std'
        pkg.orogen_options << '--import=std'
    end

    pkg.optional_dependency 'tools/service_discovery'
    if !Autoproj.user_config('USE_OCL')
        pkg.optional_dependencies.delete 'ocl'
    end
end
