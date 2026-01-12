script_dir = File.dirname(__FILE__)
$flutter_application_path = script_dir
puts "puts flutter_application_path:"
puts $flutter_application_path
load File.join($flutter_application_path, '.ios', 'Flutter', 'podhelper.rb')


def ios_install_all_flutter_pods()
     install_all_flutter_pods($flutter_application_path) if defined?(install_all_flutter_pods)
    #  eval("pod 'SnapKit'")
end

def ios_installer_flutter_build_settings(installer)
   flutter_post_install(installer) if defined?(flutter_post_install)
end
