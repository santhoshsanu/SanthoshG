1. What is Gradle?

Answer:

Gradle is an open-source build automation tool used to compile, test, package, and manage dependencies for Java, Kotlin, Android, and other projects. It is faster than Maven because it supports incremental builds, build caching, and parallel execution.

----------

3. What is the Gradle Wrapper (gradlew)?

This is a very common interview question.

Answer:

Gradle Wrapper is a script included in the project (gradlew and gradlew.bat) that automatically downloads and uses the correct Gradle version required by the project. This ensures developers and CI servers use the same Gradle version without installing Gradle manually.



The most important property

For DevOps interviews, the key property to remember is:

distributionUrl=https://services.gradle.org/distributions/gradle-9.7.0-rc-1-bin.zip

This determines the exact Gradle version the project will use, ensuring consistent builds across developers' machines and CI/CD environments like Jenkins.

# Common Gradle Commands


```sh
./gradlew build
./gradlew clean build
./gradlew test
./gradlew tasks
./gradlew dependencies

gradle --version          # Check Gradle version
gradle tasks              # List all available tasks
gradle clean              # Delete previous build files
gradle build              # Compile, test, and build the project
gradle test               # Run unit tests
gradle assemble           # Package the application (without tests)
gradle check              # Run verification checks and tests
gradle dependencies       # Display project dependencies
gradle --refresh-dependencies   # Re-download dependencies
gradle --stop             # Stop the Gradle daemon
```
