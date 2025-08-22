import com.android.build.gradle.AppExtension

val android = project.extensions.getByType(AppExtension::class.java)

android.apply {
    flavorDimensions("flavor-type")

    productFlavors {
        create("dev") {
            dimension = "flavor-type"
            applicationId = "com.example.flavor_app.dev"
            resValue(type = "string", name = "app_name", value = "Dev App")
        }
        create("stage") {
            dimension = "flavor-type"
            applicationId = "com.example.flavor_app.stage"
            resValue(type = "string", name = "app_name", value = "Stage App")
        }
        create("prod") {
            dimension = "flavor-type"
            applicationId = "com.example.flavor_app.prod"
            resValue(type = "string", name = "app_name", value = "Prod App")
        }
    }
}