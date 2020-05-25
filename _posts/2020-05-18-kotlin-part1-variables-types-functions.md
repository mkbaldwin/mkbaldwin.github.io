---
title: "Introduction to Kotlin (Part 1): Variables, types, and functions"

categories:
  - Kotlin
  - Programming Language
  - Tutorial
date: 2019-05-18T22:37:00-0500
---

## What is Kotlin?

If you are reading this then chances are you have already heard of [Kotlin](https://kotlinlang.org), but you may be 
wondering what it is and why you should be interested. Kotlin is a modern cross-platform programming language developed 
and backed by JetBrains. In 2017 Google announced Kotlin as a preferred language for Android development.

Kotlin code can be compiled for the Java Virtual Machine (JVM), JavaScript, or Native. All of the language concepts 
discussed in this article should be common to all three platforms, but the primary focus is on JVM support and, 
comparisons to Java will be made. 

The Kotlin language was designed from the beginning with Java compatibility in mind. Code written in Kotlin is 100% 
interoperable with Java. This means you can easily incorporate Kotlin into existing Java projects and/or take advantage 
of the robust ecosystem of Java libraries and tools.

![Java + Kotlin = Heart]({{ site.url }}{{ site.baseurl }}/images/blog/2020/05/18/java_kotlin_heart.png){: .align-center}

Note, this article assumes that the reader already has some programming knowledge.

## Variables and Types

Variables are declared using the `var` keyword, or the `val` keyword for variables that are immutable (read-only). The 
use of the immutable `val` should be preferred.

```kotlin
var mutableVariable: String = "Default Value"
val immutableVariable: String = "The Value"
```

Kotlin supports type inference during variable assignment. In other words, in some cases, the compiler can figure out 
the type of the variable by context. So, the code shown before can be simplified to exclude the type definition.

```kotlin
var mutableVariable = "Default Value"
val immutableVariable = "The Value"
```

Kotlin includes very strong compile-time type checking and null-safety. By default, all variables are not nullable. If 
you want a variable to allow null values it must be specified as a part of the type by adding a `?`.

```kotlin
var nullableVariable: Int? = null
```

Because nullability of variables is explicitly defined, the Kotlin compiler can generate errors when code called is 
unsafe and needs a null check. While the Kotlin type system is designed to try to prevent `NullPointerExceptions`, it
is still possible to have them under [certain scenarios](https://kotlinlang.org/docs/reference/null-safety.html).

Unlike Java, all of the basic types in Kotlin treated as objects. Basic types for String, Int, Long, Float, Double, 
etc. are provided. Note that while these types are treated as objects in Kotlin code the compiler may represent them 
as the appropriate JVM primitive once compiled.

## Functions

Functions in Kotlin are defined using the `fun` keyword.

```kotlin
fun add(a: Int, b: Int): Int {
    return a + b;
}
```

Notice in the example function that the declaration of parameters looks a lot like in variable declaration. When 
declaring parameters the `var`/`val` keywords are omitted. Function parameters are always immutable.

The return type follows the function parameters. If a function returns no value then the `Unit` type is returned. In 
this case, the return type can be omitted.

```kotlin
fun sayHello(name: String) {
    println("Hello $name!")
}
```

In this example function, you will notice an additional handy feature in Kotlin, string interpolation. In our example, 
the `$name` is replaced with the value in the parameter. So, the string `"Hello $name!"` is the equivalent  of doing 
`"Hello " + name + "!"` in Java code.

Many of the language features in Kotlin are designed to make code more concise and easier to read and write. If a 
function is only a single expression that returns a value we can shorten the code and write a single-expression function.

```kotlin
fun add(a: Int, b: Int) = a + b
```

A single-expression function allows us to further reduce the code written by omitting the type and allowing the 
compiler to infer it from the expression.

Function parameters can be given default values and calling code can omit the argument. This is done directly in the 
function definition by assigning a value to any of the parameters.

```kotlin
fun message(message: String = "Hello", name: "World"){
  println("$message $name!)
}
```

A default value can be provided for any of the parameters. In the `message` function if you want to only override the 
default value for `name` then a named parameter must be used. This is done by including the parameter name and assigning 
a value in the function call. The example code below shows multiple ways this function can be called.

```kotlin
message(name = "Reader")  // Prints "Hello Reader!"
message("Hey", "Reader")  // Prints "Hey Reader!"
message("Hey")            // Prints "Hey World!"
message()                 // Prints "Hello World!"
```

## What next?

In <a href="{{ site.url }}/posts/kotlin-part2-conditionals-loops">part two</a> of this series, we will talk about Kotlin conditionals and looping.
Also, the <a href="https://kotlinlang.org/docs/reference">Kotlin Reference</a> documentation covers all of these items
discussed in this post in much more detail.

<small>This article is also published on <a href="https://dev.to/mkbaldwin/introduction-to-kotlin-part-1-variables-types-and-functions-193k">dev.to</a>.</small>
