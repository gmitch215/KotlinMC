rootProject.name = "KotlinMC"

pluginManagement {
    plugins {
        val kotlinV = File("versions/kotlin.txt").bufferedReader().use { it.readLine() }
        id("kotlin").version(kotlinV)
        id("kotlinx-serialization").version(kotlinV)

        val kotlinAtomicV = File("versions/kotlinx-atomicfu.txt").bufferedReader().use { it.readLine() }
        id("kotlinx-atomicfu").version(kotlinAtomicV)
    }
}