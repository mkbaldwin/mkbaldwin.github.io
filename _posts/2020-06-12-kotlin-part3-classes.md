---
title: "Introduction to Kotlin (Part 3): classes, properties, objects, and interfaces"

categories:
  - Kotlin
  - Programming Language
  - Tutorial
date:  2020-06-12T10:03:24-0400

---

In <a href="{{ site.url }}/posts/kotlin-part1-variables-types-functions">part one</a> of this series we talked about 
variables, types, and functions, and in <a href="{{ site.url }}/posts/kotlin-part2-conditionals-loops">part two</a>
we covered conditionals and looping. In part three we will now talk about classes in Kotlin.

### Class basics

Declared with the `class` keyword. If the class has no body then curly braces can be omitted.

```kotlin
class Book {}
```

A class can have one primary constructor and any number of secondary constructors. In Kotlin the primary constructor is 
declared directly in the class definition.

```kotlin
class Book(title: String)
```

Notice that in Kotlin the default constructor doesn't contain any initialization code. Initialization code is placed 
into `init` blocks.  These blocks will be executed when the class is being initialized after instantiation. Any 
parameters specified in the primary constructor can be accessed within the initializer block or when declaring properties.

```kotlin
class Book(title: String, author: String) {
  private val title = title
  private val author: String
  init {
    println("Book initialized with title: $title and author: $author")
    this.author = author
  }
}
```

Declaring properties and initializing them with a constructor is a very common pattern. So, Kotlin includes a shorter 
syntax allowing the properties and initializing them directly in the constructor.

```kotlin
class Book(val title: String, private val author: String = "Anonymous")
```

These properties can be defined to be either `val` or `var` and can specify visibility modifiers such as `private`. 
Much like in functions, parameters can also have default values specified.

Creating an instance of a class is done by calling the constructor like it is a function. Kotlin has no special 
keywords used for instantiation.

```kotlin
val myBook = Book("Some Great Work", "A. Author")
```

Secondary constructors are created using the `constructor` keyword. Secondary constructors can call the default (or 
other) constructor using the `this` keyword.

Multiple secondary constructors are allowed and may contain initialization logic.

```kotlin
class Book(val title: String, val author: String) {
    private var price: Double = 0.0
    constructor(title: String): this(title, "Unknown")
    constructor(title: String, author: String, price: Double): this(title, author) {
        this.price = price
    }
}
```

### Properties

Properties in Kotlin are variables defined at the class level using the `val` or `var` keywords. By default properties 
are `public`, but other visibility modifiers (e.g. `private` or `protected`) can be specified.

For compatibility with Java and other JVM languages getter and setter functions are created automatically for each 
property. When needed a custom getter or setter can be provided.

```kotlin
class Person {
  var name: String
    get() = this.name
    set(value) {
      // Do some logic
      this.name = value
    }
}
```

Note in the previous example that we can either use the shorthand assignment syntax or a code block just like when 
defining functions.

### Inheritance

All classes in Kotlin all automatically inherit from the `Any` class. This is similar to `Object` in Java. By default 
all Kotlin classes are final and cannot be extended. To make a class available for extension the `open` keyword must 
be used when declaring the class.

```kotlin
open class Vehicle(val color: String) {
    fun start() {
        // Some Implementation
    }
}
```

When we want to create a class that extends another we specify the new class name, a colon (`:`), and then the new 
class name. If the new class has a primary constructor then the constructor of the base class must be called.

```kotlin
class Car(color: String) : Vehicle(color) {
  
    fun drive() {
        // Some Implementation
    }
}
```

If the new class doesn't have a primary constructor then each secondary constructor must call the parent constructor 
using the `super` keyword. 

```kotlin
constructor(color: String) : super(color)
```

To override functions or properties the parent class must specify these items as being `open`, just like with the class itself.

```kotlin
open class Vehicle {
    open val type: String = "Vehicle"
    open fun start() {
        // Some Implementation
    }
}
```

In the derived  class the functions and properties must be marked with the `override` keyword.

```kotlin
class Car: Vehicle() {
    override val type: String = "Car"

    override fun start() {
        super.start()
    }
}
```

### Interfaces

Kotlin also supports interfaces that work similarly  to those in Java. Interfaces are defined using the `interface` keyword.

```kotlin
interface Loggable {
  fun loggerName(): String
}
```

Classes can implement one or more interfaces.

```kotlin
class MyClass : Loggable, Serializable {
  override fun loggerName(): String {
    //Some Implementation
  }

  // ...
}
```

Interfaces can inherit from other interfaces using a similar syntax to classes.

```kotlin
interface Parent {
  fun x()
}

interface Child : Parent {
  fun y()
}
```

### Objects (Singleton)

Kotlin has built-in support for singleton classes using the `object` keyword.

```kotlin
object MySingleton {
  // Functions and properties...
}
```

Objects can also be defined as companions to regular classes. This is done by declaring a `companion object` inside of the class.

```kotlin
class MyClass {
  companion object {
    fun foo() {
      // Some logic
    }
  }
}
```

Methods and properties in the companion object are accessed using the name of the parent object. This looks similar to 
how static functions are called in Java, but the companion objects are real objects. The companion objects can implement 
interfaces, have properties, etc.

```kotlin
MyClass.foo()
```

### Data Classes

There are many cases where objects are created just to hold data. In Java these classes would define some class-level 
variables as well as getters and setters. These types of classes require a lot of boilerplate code.

Kotlin provides a special type of class just for this purpose. Data classes are created with the `data class` keywords. 

```kotlin
data class Person(val firstName: String, val lastName: String)
```

The Kotlin compiler will automatically create a getter and setter for each property as well as the following functions:

  * `equals()`
  * `hashCode()`
  * `toString()`
  * `copy()`

### What Next?

In this post I have tried to cover most of the important details of classes, properties, objects, interfaces, and data 
classes. There are still a lot more specific details that I simply don't have the time and space to cover. Fortunately 
the <a href="https://kotlinlang.org/docs/reference/">Kotlin reference</a> documentation is excellent and covers all the 
topics in great detail.

<small>This article is also published on <a href="https://dev.to/mkbaldwin/introduction-to-kotlin-part-3-classes-properties-objects-and-interfaces-2bjf">dev.to</a>.</small>