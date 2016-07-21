---
title: Abstracting Grails controller logic using closures
tags:
  - grails
  - controllers
  - closures
---

As I've been working more with Grails I have been finding that in many of my controllers
I need to load the same type of entity in many controller mappings based on the ID
from the URL. Initially I wrote a function to call that would return the model with
that entity prepopulated. However, I've found there is a more Groovy-like way to do
this using a method taking a closure.

So, assume we have a model class Entity that is loaded in many request mappings based
on the ID value from the URL. So, a common task for each mapping is to load the entity
and add it to the model if it exists. If the entity doesn't exist we want to redirect
to a default controller.

We can write a method utilizing a closure to do this quite simply as follows:

{% highlight groovy %}
class AbstractController {
  def withEntityOnModelOrRedirect(Closure c) {
    def entity = Entity.findById(params["id"])

    if(entity) {
      def model = [entity: entity]
      c.call model
    }
    else {
      redirect controller: default
    }
  }
}
{% endhighlight %}

The method can be implemented directly in the controller class, or in an abstract
class to be shared between multiple controllers. To use our new method we can do
the following:

{% highlight groovy %}
class SomeController extends AbstractController {
  def edit() {
    withEntityOnModelOrRedirect { model ->
        //Do something with the model
    }
  }
}
{% endhighlight %}

This is a pretty simple pattern and can be quite useful, but it definitely takes
some time to get used to thinking in this way about solving problems as opposed
to the typical Java way.
