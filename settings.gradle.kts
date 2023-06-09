rootProject.name = "KotlinMC"

pluginManagement {
    plugins {
        val kotlinV = File("versions/kotlin.txt").bufferedReader().use { it.readLine() }
        id("kotlin").version(kotlinV)
        id("kotlinx-serialization").version(kotlinV)
    }
}