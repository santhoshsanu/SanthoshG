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



# Maven vs Gradle Command Comparison

| Maven Command | Gradle Equivalent | Description |
|---------------|-------------------|-------------|
| `mvn clean package` | `gradle clean build` | Cleans previous build, compiles, tests, and packages the application. |
| `mvn test` | `gradle test` | Runs unit tests. |
| `mvn package` | `gradle assemble` *(package only)*<br>`gradle build` *(package + test)* | Packages the application. `build` also runs tests. |
| `mvn clean install` | `gradle publishToMavenLocal` *(if configured)* | Publishes the artifact to the local Maven repository. |


# What is Jenkins?

**Answer:**

Jenkins is an **open-source automation server** used to automate the **Continuous Integration (CI)** and **Continuous Delivery/Deployment (CD)** process. It helps automate tasks such as building, testing, and deploying applications, reducing manual effort and enabling faster, more reliable software delivery.

**Key Points:**
- Open-source CI/CD automation tool.
- Automates build, test, and deployment processes.
- Supports integration with tools like Git, Maven, Gradle, Docker, Kubernetes, and AWS.
- Extensible through a large ecosystem of plugins.
- Pipelines can be created using a **Jenkinsfile** (Pipeline as Code).


# Jenkins Build Triggers

**Interview Answer:**

Build Triggers define **when a Jenkins job starts automatically**.

| Trigger | Description |
|---------|-------------|
| **Build after other projects are built** | Starts this job after another Jenkins job completes. |
| **Build periodically** | Runs the job on a schedule using a cron expression. |
| **GitHub hook trigger for GITScm polling** | Starts the build immediately when GitHub sends a webhook after a code push. |
| **Poll SCM** | Periodically checks the Git repository and triggers a build only if changes are detected. |
| **Trigger builds remotely** | Allows external systems or scripts to trigger the job using an API URL and security token. |

