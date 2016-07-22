---
title: An alternative pattern for creating custom Grails GSP tags
tags:
  - Grails
  - GSP
---

I've been working with Grails for a while now, and while I like the framework there
are a few things that I find annoying. The default recommended way of creating
custom GSP (Groovy Server Pages) tags is one of them.

If you read the Grails documentation the instructions for creating a custom GSP tag
 involve creating the HTML to be rendered within the Groovy code. While this works,
 to me this just feels a bit clumbsy as compared to being able to create HTML within
  a GSP file. The method of creating custom tags that I describe in this article is
  a hybrid approach that I've been using that seems to work quite well.

To start out with this method we need to change the Grails Config.groovy file. By
default any content output from a scriptlet (i.e. <%= expression %>) in a GSP page
will be escaped to use XML entities rather than being rendered as HTML. The setting
for scriptlet under the gsp/codes block should be changed to "none" to disable output
escaping. After being updated the file will look something like the one below:

{% highlight groovy %}
grails {
  views {
    gsp {
      encoding = 'UTF-8'
      htmlcodec = 'xml' // use xml escaping instead of HTML4 escaping
      codecs {
        expression = 'html' // escapes values inside ${}
        scriptlet = 'none' // escapes output from scriptlets in GSPs
        taglib = 'none' // escapes output from taglibs
        staticparts = 'none' // escapes output from static template parts
      }
    }
    // escapes all not-encoded output at final stage of outputting
    filteringCodecForContentType {
        //'text/html' = 'html'
    }
  }
}
{% endhighlight %}

Once this setting has been changed we can move on to creating our GSP page. Under
the "Views" section of your Grails project create a "templates" directory. This
is where you will create the GSP files for your custom tags. For this example we
will create a file called "\_myTemplate.gsp". All template GSP files must start
with an underscore. The template GSP file is just like any other GSP and can
consist of normal HTML, scriptlets, or espressions. Our example template is pretty
simple as shown below:

{% highlight html %}
{% raw %}
<div>
  ${title}
  <hr />
  <%=body%>
</div>
{% endraw %}
{% endhighlight %}

Now we need to create our TagLib Groovy file. This file is just like any other
standard Grails TagLib with the exception of the last line where we render our
GSP template with a model with have populated with any values needed. Note that
in the name of the template file the underscore and ".gsp" file extension are
left off.

{% highlight groovy %}
package myapp.tags

class MyTagLib {
  static namespace = "my"

  def tag = { attrs, body ->
    def model = [
      body: body(), //Gets the body of the GSP tag
      title: attrs.title //Gets the title attribute of the GSP tag
    ]

    //Render our template file with the model created above.
    out << render(template:"/templates/myTemplate", model:model)
  }
}
{% endhighlight %}

Finally, we can use our newly created tag within our other GSP pages. For example:

{% highlight html %}
{% raw %}
<my:tag title=”Some Value”>
    <!-- Content Here -->
</my:tag>
{% endraw %}
{% endhighlight %}

That's it! Once you get used to creating templates using this pattern it works
quite well. Hopefully you will find this useful in your own projects.
