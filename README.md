# KotlinMC

A library for the kotlin runtime and various Kotlin Libraries on Spigot, BungeeCord, Velocity, and Sponge Servers.

## How does it Work?

Every hour, the actions workflow will run a series of bash scripts (see the `scripts` folder) to send an API request 
to the following libraries for new releases:
- [`JetBrains/Kotlin`](https://github.com/JetBrains/Kotlin)
- [`Kotlin/kotlinx.coroutines`](https://github.com/Kotlin/kotlinx.coroutines)
- [`Kotlin/kotlinx.serialization`](https://github.com/Kotlin/kotlinx.serialization) 
- [`Kotlin/kotlinx-atomicfu`](https://github.com/Kotlin/kotlinx.atomicfu)
- [`Kotlin/kotlinx-io`](https://github.com/Kotlin/kotlinx-io)
- [`Kotlin/kotlinx-datetime`](https://github.com/Kotlin/kotlinx-datetime)

If a new release is detected, versions stored in the `versions` folder will be updated, the Gradle Plugin will automatically be updated to include the latest version, and a publish is automatically shipped to [Modrinth](https://modrinth.com/plugin/kotlinmc/).
