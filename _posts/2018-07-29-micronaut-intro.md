---
title: "Micronaut: A five-minute introduction."
categories: Java Micronaut Groovy
date:  2018-07-29 20:40:00 -0500
---

[Micronaut](http://micronaut.io) is a new open source Java/JVM framework for creating microservice applications. 
Development is being led by the creators of the Grails framework and is backed by 
[Object Computing](https://objectcomputing.com/products/micronaut). The project is actively working toward its 
official 1.0 release. 

I've used Grails in the past for some personal projects and currently work primarily in the JVM ecosystem 
professionally. So, when I saw the announcement about Micronaut, I decided to give it a try and see
what it was all about.

Micronaut's goals are to provide fast startup times and small memory footprint. Both of which are important for deploying
microservices.

## Getting Started

To get started building an application, the [user guide](https://docs.micronaut.io/snapshot/guide/index.html#quickStart) 
recommends installing the Micronaut CLI. After completing the installation, you can create a new project with the following command.

```
mn create-app my-app-name
```

By default, this creates a Gradle script to build a Java application using Micronaut. You can alternatively specify 
maven as your build script, and either Java, Groovy, or Kotlin as a programming language. For my examples, I opted to use Groovy.
As you look at the generated project structure it will feel very familiar if you have worked with Spring framework before.

To start the application, just run:

```
./gradlew run
```

You can also compile the application and run the main method in the `Application` class directly using your IDE.

## Controllers

Much like in Spring Framework controllers are defined declaratively using the `@Controller` annotation. 
Classes that are annotated with `@Controller` or other annotations are automatically detected.
Unlike other frameworks, like Spring, that rely on run-time classpath scanning this is done at compile time.

A simple controller looks as follows:

```groovy
import io.micronaut.http.annotation.Controller
import io.micronaut.http.annotation.Get

@Controller("/api/todo")
class TodoController {
    @Get("/{id}")
    Todo getTodo(int id) {
      //Do something with the id from the URI
    }    
}
```

The `@Get` annotation is placed onto the method that will handle the GET action for the combined URL in the `@Controller`
and `@Get` annotations. Additional annotations exist for other HTTP methods (POST, PUT, etc.). Path variables are supported
in URLs and consist of a placeholder (`{id}` in this case) and a matching method parameter. Objects returned from controller
methods will automatically be converted to JSON.

## Beans

Beans can be defined using annotations on a class. Like with controllers, beans will be found and registered via classpath
scanning. There are several different annotations (`@Singleton`, `@Prototype`, etc.) for creating beans with different scopes.
So, for example, I can create a service using the Singleton annotation.

```groovy
import javax.inject.Singleton

@Singleton
class TodoService {
  //Provide some implementation
}
```

## Dependency Injection

Dependency injection is provided using the JSR-330 `@Inject` annotation. Unlike other frameworks, Micronaut performs 
dependency injection at compile time. This avoids the use of reflection/proxies and contributes to faster startup
times.

The `@Inject` annotation can be used to inject dependencies via constructor injection, field injection, and method parameters.

Extending the controller example from before, we can inject a service as follows:

```groovy
import io.micronaut.http.annotation.Controller
import io.micronaut.http.annotation.Get
import javax.inject.Inject

@Controller("/api/todo")
class TodoController {
    TodoService todoService
  
    @Inject
    TodoController(TodoService todoService) {
      this.todoService = todoService
    }
    
    @Get("/{id}")
    Todo getTodo(int id) {
      //Do something with the id from the URI
    }    
}
```

## Conclusion

This quick overview just barely scratches the surface of the functionality available already in Micronaut. The 
[user guide](https://docs.micronaut.io/snapshot/guide/index.html) is comprehensive and provides a lot of great information
for all of the functionality. Developers coming to Micronaut from Spring Framework will find it very familiar.

Considering that the framework hasn't reached an official 1.0 release yet, it already seems very powerful. I look forward
to seeing how it continues to evolve and grow.

<small>
**Updated 2018-07-30**: Thanks to [Jim Kleeh](https://twitter.com/Schlogen) for pointing out on Twitter that annotations
are not found via classpath scanning, but instead this happens at compile time.
</small>