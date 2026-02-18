import java.util.Properties
import java.io.FileInputStream

// این خط رو اضافه کن برای پیدا کردن Flutter SDK
val flutterRoot = localProperties.getProperty("flutter.sdk") ?: throw GradleException("Flutter SDK not found")

// به جای plugins block، از apply استفاده کن
apply(from = "$flutterRoot/packages/flutter_tools/gradle/flutter.gradle")

android {
    namespace = "com.example.tech_blog"
    compileSdk = 34  // یا flutter.compileSdkVersion

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_17.toString()
    }

    defaultConfig {
        applicationId = "com.example.tech_blog"
        minSdk = 21  // یا flutter.minSdkVersion
        targetSdk = 34  // یا flutter.targetSdkVersion
        versionCode = 1
        versionName = "1.0"
    }

    signingConfigs {
        create("release") {
            val keystorePropertiesFile = rootProject.file("key.properties")
            if (keystorePropertiesFile.exists()) {
                val keystoreProperties = Properties()
                keystoreProperties.load(FileInputStream(keystorePropertiesFile))
                
                keyAlias = keystoreProperties["keyAlias"] as String
                keyPassword = keystoreProperties["keyPassword"] as String
                storeFile = keystoreProperties["storeFile"]?.let { file(it) }
                storePassword = keystoreProperties["storePassword"] as String
            }
        }
    }

    buildTypes {
        release {
            signingConfig = if (rootProject.file("key.properties").exists()) {
                signingConfigs.getByName("release")
            } else {
                signingConfigs.getByName("debug")
            }
        }
        debug {
            signingConfig = signingConfigs.getByName("debug")
        }
    }
}

flutter {
    source = "../.."
}

dependencies {
    implementation("com.google.android.material:material:1.13.0")
}