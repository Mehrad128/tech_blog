pluginManagement {
    repositories {
        gradlePluginPortal() // برای پلاگین‌ها
        google()
        mavenCentral()
        maven { url = uri("https://repo.arvancloud.com/maven/") }
        maven { url = uri("https://repo.arvancloud.com/google/") }
    }
}

dependencyResolutionManagement {
    // فقط اجازه ریپازیتوری از settings رو میده، نه از build.gradle
    repositoriesMode.set(RepositoriesMode.FAIL_ON_PROJECT_REPOS)
    repositories {
        google()
        mavenCentral()
        // ریپازیتوری اختصاصی مایکت
        maven { url = uri("https://maven.myket.ir") }
        // ریپازیتوری اختصاصی آروانکلود
        maven { url = uri("https://repo.arvancloud.com/maven/") }
        maven { url = uri("https://repo.arvancloud.com/google/") }
    }
}

// نام روت پروژه
rootProject.name = "tech_blog"

// ماژول‌ها
include(":app")
