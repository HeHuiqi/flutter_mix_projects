pluginManagement {
    // 插件下载仓库（插件只能从这些仓库找）
    repositories {
        val storageUrl: String = System.getenv("FLUTTER_STORAGE_BASE_URL") ?: "https://storage.googleapis.com"
        google {
            content {
                includeGroupByRegex("com\\.android.*")
                includeGroupByRegex("com\\.google.*")
                includeGroupByRegex("androidx.*")
            }
        }
        mavenCentral()
        gradlePluginPortal()
        maven("$storageUrl/download.flutter.io")
    }
}
dependencyResolutionManagement {
//    repositoriesMode.set(RepositoriesMode.FAIL_ON_PROJECT_REPOS)
//    将 Gradle 的仓库策略从「强制优先 settings」改为「允许 project 仓库」，兼容 Flutter 插件的仓库添加行为
    repositoriesMode.set(RepositoriesMode.PREFER_SETTINGS)
    val storageUrl: String = System.getenv("FLUTTER_STORAGE_BASE_URL") ?: "https://storage.googleapis.com"
    // 依赖下载仓库（依赖只能从这些仓库找）
    repositories {
        google()
        mavenCentral()
        maven("$storageUrl/download.flutter.io")

    }

}

rootProject.name = "HqAndroidMixFlutter"



include(":app")

val flutterModulePath = "${settingsDir.parentFile}/voghion_flutter_module/.android/include_flutter.groovy"
apply(from = flutterModulePath)
 