import java.io.BufferedReader
import java.io.InputStreamReader
import java.net.HttpURLConnection
import java.net.URL

plugins {
    id("com.github.johnrengelman.shadow") version "8.1.1"
    id("com.modrinth.minotaur") version "2.+"
    java
}

val kotlinVersion = version("kotlin")
val coroutinesVersion = version("kotlinx-coroutines")
val serializationVersion = version("kotlinx-serialization")

java {
    sourceCompatibility = JavaVersion.VERSION_1_8
    targetCompatibility = JavaVersion.VERSION_1_8
}

group = "me.gamercoder215.kotlinmc"
version = kotlinVersion

project.ext["url"] = "https://github.com/GamerCoder215/KotlinMC"
project.ext["kotlin_version"] = kotlinVersion

tasks {
    jar.configure {
        enabled = false
        dependsOn(shadowJar)
    }

    shadowJar {
        archiveClassifier.set("")
    }

    processResources {
        expand(project.properties)
    }

}

modrinth {
    token.set(System.getenv("MODRINTH_TOKEN"))
    projectId.set("kotlinmc")
    versionNumber.set(kotlinVersion)
    versionType.set("release")
    uploadFile.set(tasks.shadowJar)
    gameVersions.addAll(listOf("1.20", "1.19.4", "1.19.3", "1.19.2", "1.19.1", "1.19", "1.18.2", "1.18.1", "1.18", "1.17.1", "1.17", "1.16.5", "1.16.4", "1.16.3", "1.16.2",
        "1.16.1", "1.16", "1.15.2", "1.15.1", "1.15", "1.14.4", "1.14.3", "1.14.2", "1.14.1", "1.14", "1.13.2", "1.13.1", "1.13", "1.12.2", "1.12.1", "1.12", "1.11.2",
        "1.11.1", "1.11", "1.10.2", "1.10.1", "1.10", "1.9.4", "1.9.3", "1.9.2", "1.9.1", "1.9", "1.8.9", "1.8.8", "1.8.7", "1.8.6", "1.8.5", "1.8.4", "1.8.3", "1.8.2",
        "1.8.1", "1.8"
    ))
    loaders.addAll(listOf("bukkit", "bungeecord", "folia", "paper", "purpur", "spigot", "sponge", "velocity", "waterfall"))
    changelog.set(createChangelog())

    syncBodyFrom.set(rootProject.file("README.md").bufferedReader().use { it.readText() })
}

repositories {
    mavenCentral()
    mavenLocal()

    maven("https://plugins.gradle.org/m2/")
    maven("https://oss.sonatype.org/content/repositories/snapshots")
    maven("https://oss.sonatype.org/content/repositories/central")
    maven("https://hub.spigotmc.org/nexus/content/repositories/snapshots/")
    maven("https://repo.papermc.io/repository/maven-public/")
}

// Dependencies & Plugins

dependencies {
    implementation("org.jetbrains.kotlin:kotlin-stdlib:${kotlinVersion}")
    implementation("org.jetbrains.kotlinx:kotlinx-coroutines-core:${coroutinesVersion}")
    implementation("org.jetbrains.kotlinx:kotlinx-serialization-json:${serializationVersion}")

    compileOnly("org.spigotmc:spigot-api:1.8-R0.1-SNAPSHOT")
    compileOnly("net.md-5:bungeecord-api:1.8-SNAPSHOT")
    compileOnly("com.velocitypowered:velocity-api:3.1.1")
}

fun version(name: String): String = File("versions/${name}.txt").bufferedReader().use { it.readLine() }

fun createChangelog(): String = "# KotlinMC v${kotlinVersion}\n\n- `kotlin-stdlib` v${kotlinVersion}\n- `kotlinx-coroutines` v${coroutinesVersion}\n- `kotlinx-serialization` v${serializationVersion}"