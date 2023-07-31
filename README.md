# KotlinMC

A library for the kotlin runtime, `kotlinx-coroutines`, `kotlinx-serialization`, and `kotlin-reflect` for Spigot, BungeeCord and Velocity Servers.

## How does it Work?

Every hour, the actions workflow will run a series of bash scripts (see the `scripts` folder) to send an API request 
to the [`JetBrains/Kotlin`](https://github.com/JetBrains/Kotlin), [`Kotlin/kotlinx.coroutines`](https://github.com/Kotlin/kotlinx.coroutines),
and [`Kotlin/kotlinx.serialization`](https://github.com/Kotlin/kotlinx.serialization) repositories to check for new releases. If a new release is detected, versions stored in the `versions` folder will be updated, the Gradle Plugin will automatically be updated to include the latest version, and a publish is automatically shipped to [Modrinth](https://modrinth.com/plugin/kotlinmc/).