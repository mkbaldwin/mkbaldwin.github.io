---
title: "Kotlin Type Aliases"

categories:
  - Kotlin
  - Programming Language
date: 2020-06-27T15:01:09-0400
---

Something I recently learned about in Kotlin, that I do not see talked about very often, are 
type aliases. Type aliases allow for custom names to be specified for existing types. 
This is convenient for long or complex types.

These are particularly useful for function types that have particularly complex syntax. 
For example if we have a function that takes a handler function as a parameter.

```kotlin
fun handleEvent(handler: (type: EventType, message: String) -> Unit) {
  // Some logic...
}
```

We can use a type alias to make a bit more readable by defining a name to the function type.

```kotlin
typealias EventHandler = (EventType, String) -> Unit

fun handleEvent(handler: EventHandler) {
    // Some logic...
}
```

Note that type aliases are not creating new types. Behind the scenes the Kotlin compiler 
takes the custom name and replaces it with the actual type. This means you can work with 
the original type and the alias interchangeably. 

```kotlin
typealias CharacterString = String

fun pl(s: CharacterString) = println(s)

fun main() {
  val test1: CharacterString = "Test String"
  val test2: String = "Test String 2"

  pl(test1)
  pl(test2)
}
```

Obviously, overusing this feature could result in less readable code, but used appropriately 
can be very useful. For more details see the 
<a href="https://kotlinlang.org/docs/reference/type-aliases.html">Type Aliases</a> section 
of the Kotlin documentation.


<small>This article is also published on <a href="https://dev.to/mkbaldwin/kotlin-type-aliases-4g0f">dev.to</a>.</small>

