---
title: "Introduction to Kotlin (Part 2): if, when, and looping"

categories:
  - Kotlin
  - Programming Language
  - Tutorial
date:  2020-05-25T12:32:42-0400
---

In <a href="{{ site.url }}/posts/kotlin-part1-variables-types-functions">part one</a> of this Introduction to Kotlin series, we talked about what Kotlin is and about some of the basics of the language
(variables, types, and functions). If you are completely new to Kotlin, that article is probably a good read before starting this one.

## Making decisions (if and when)

Like most other programming languages, Kotlin includes support for conditional logic with `if`/`else`. The basic structure is the same as in Java.

```kotlin
if(booleanExpression) {
    println("I'm true!")
}
else {
    println("I'm false!")
}
```

Unlike in Java, `if`/`else` blocks are expressions that can return a value. When used as an expression the last line of each block is returned as the value.

```kotlin
val result = if(booleanExpression) {
    "I'm true!"
}
else {
    "I'm false!"
}
println(result)
```

If the `if` and `else` blocks contain a single expression, then this code can be simplified further.

```kotlin
val result = if(booleanExpression)  "I'm true!" else "I'm false!"
println(result)
```

This pattern is similar to the ternary (`? :`) operator in Java, which Kotlin does not have.

In addition to `if` Kotlin also has another conditional called `when`. The `when` expression is a powerful alternative, and is especially useful when doing many comparisons together. 

```kotlin
val cost = 12
val result = when {
  cost < 5 -> "It is cheap!"
  cost > 50 -> "It is expensive!"
  else -> "It's in between."
}
println(result)
```

When multiple conditional branches are required the `when` expression results in a much more concise code. The `when` expression requires that all possible branches must be covered. So, in this case, we must have an `else` branch. When using enumerations an else can be omitted when all values are covered by an existing branch. 

If all conditional branches are going to be comparisons with a single value we can pass that as an argument to the `when` expression.

```kotlin
val count = 5
result = when (count) {
  1 -> "Only one!"
  2,3 -> "Two or three!"
  in 4..6 -> "Four to six!"
  else -> "Seven or more!!"
}
println(result)
```

For this type of `when` expression we can either specify a single value, a comma-separated list of values, or a range using the `in` keyword. Once again we still must have an `else` statement to catch any non-matching values.

In this form, the `when` expression looks very similar to the switch statement in Java, only with more power and simpler syntax.

## Looping

The `for` loop in Kotlin allows for iterating over any object that provides an iterator, or over ranges. The `in` keyword The type on the variable defined in the loop can, in most cases, be omitted.

```kotlin
for(item: Int in someCollection) {
    println(item)
}
```

Kotlin does not utilize the C style for loop for iterating over a range of numbers. Instead, iteration is specified using [Range Expressions](https://kotlinlang.org/docs/reference/ranges.html). Ranges are created using the `..` operator (which is associated with the `rangeTo()` function). 


```kotlin
for(i in 1..5) {
    print(i)
}
// Prints: 1, 2, 3, 4, and 5
```

By default iterating over a range will increment the value by one each time. In some cases, you may want to increment by other values. This can be achieved by specifying `step` and a number. In the example below, the number will be increased by two each time until the ending value is reached.

```kotlin
for(i in 1..10 step 2) {
    print(i)
}
// Prints: 1, 3, 5, 7, and 9
```

If you want the range to go in reverse order you can use `downTo` instead of `..`. This will result in the starting number being decremented by one (or another value when `step` is specified) until the ending value is reached.

```kotlin
for(i in 5 downTo 1) {
    println(i)
}
// Prints: 5, 4, 3, 2, and 1
```

Kotlin also support `while` and `do while` loops. These loops work just as you would expect them to in Java.

```kotlin
while(booleanExpression) {
    // ...
}

do {
    // ...
}
while(booleanExpression)
```

## What next?

In <a href="{{ site.url }}/posts/kotlin-part3-classes">part three</a> of this series, we will talk about Kotlin classes.
Also, the <a href="https://kotlinlang.org/docs/reference">Kotlin Reference</a> documentation covers all of these items
discussed in this post in much more detail.

<small>This article is also published on <a href="https://dev.to/mkbaldwin/introduction-to-kotlin-part-2-if-when-and-looping-4h56">dev.to</a>.</small>