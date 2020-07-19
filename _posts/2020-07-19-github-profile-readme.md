---
title: "Display latest blog posts on GitHub profile readme"

categories:
  - GitHub
  - Tutorial
date:  2020-07-19T16:02:01-0400
---

Recently GitHub updated the user profile page to allow custom user-defined content to be displayed. This is done via
a profile README.

![GitHub Profile]({{ site.url }}{{ site.baseurl }}/images/blog/2020/07/19/0_github_profile.png){: .align-center}

Adding your profile readme section is quite simple. To start, create a new repository with your GitHub username
`YourGithubUsername/YourGithubUsername` and initialize it with a `README.md` file. Note that the repository must be
public. When you create the repository GitHub will display a message telling you that it is a 'special' repository.

![Creating a repository]({{ site.url }}{{ site.baseurl }}/images/blog/2020/07/19/1_repo_create.png){: .align-center}

Any static content you define and commit into the README in this repository will be displayed on your profile. 

### Displaying blog post links

The GitHub profile readme section only supports static content, but it would be nice to display more dynamic information
on a profile. In my case, I wanted to be able to put links to my latest blog posts. To achieve this I am going to use
GitHub Actions.

My blog (built with Jekyll) has an Atom feed listing all of my posts. To update the content in my readme I will create
an action to fetch the feed and parse out the five latest posts. Since Atom is XML I used a simple XSLT to transform
the XML into Markdown. Create the XSLT file below and commit to your profile readme repository as 
`scripts/recent-posts.xslt`. 

_Note: If your blog does not use an Atom feed you will need to update this XSLT for the
file format you have available._

```xml
<?xml version="1.0"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:at="http://www.w3.org/2005/Atom">
    <xsl:output method="text"/>
    <xsl:strip-space elements="*"/>

    <xsl:template match="/at:feed">
        <xsl:text>### Recent Blog Posts</xsl:text>
        <xsl:text>&#xa;&#xa;</xsl:text>
        <xsl:apply-templates/>
    </xsl:template>

    <!-- Only display the first 5 posts from the list -->
    <xsl:template match="at:entry[position() &lt; 6]">
        <xsl:value-of select="concat('  * [', at:link/@title, '](', at:link/@href, ')')"/>
        <xsl:text>&#xa;</xsl:text>
    </xsl:template>

    <xsl:template match="text()"/>
</xsl:stylesheet>
``` 

To create static content in the readme as well we will create a static markdown file named `README_START.md`. In this
file you can put any content you want to be shown before the latest posts list. 

Commit these files and push them to GitHub. Now we have the initial content we will create a GitHub action to 
update our readme automatically. Under your profile repository click on the `Actions` tab and then `New workflow`. 
Select a simple workflow as a starter. GitHub will now give you a starter script, that you can either edit or replace
using the script below as a basis. Also, note that you will want to rename the script from the default `blank.yml`.

```yaml
# This is a basic workflow to help you get started with Actions

name: Update Latest Posts

# Controls when the action will run. Triggers the workflow on push or pull request
# events but only for the master branch
on:
  workflow_dispatch:
  schedule:
    # Cron syntax, run at 00:00 UTC daily
  - cron: "0 0 * * *"

# A workflow run is made up of one or more jobs that can run sequentially or in parallel
jobs:
  # This workflow contains a single job called "build"
  build:
    # The type of runner that the job will run on
    runs-on: ubuntu-latest

    # Steps represent a sequence of tasks that will be executed as part of the job
    steps:
    # Checks-out your repository under $GITHUB_WORKSPACE, so your job can access it
    - uses: actions/checkout@v2

    # Perform the steps needed
    - name: Pull Latest Repo Content
      run: git pull
      
    - name: Download Saxon-HE
      run:  curl https://repo1.maven.org/maven2/net/sf/saxon/Saxon-HE/9.9.1-7/Saxon-HE-9.9.1-7.jar > saxon.jar

    - name: Fetch website Atom Feed
      run: curl https://michael.codes/feed.xml > feed.xml 
    
    - name: Perform XSL Transformation
      run: java -cp ./saxon.jar net.sf.saxon.Transform -s:feed.xml -xsl:$GITHUB_WORKSPACE/scripts/recent-posts.xslt -o:README_END.md

    - name: Combine Files
      run: cat $GITHUB_WORKSPACE/README_START.md README_END.md > $GITHUB_WORKSPACE/README.md
    
    - name: Commit Changes
      run:  |
        git add README.md
        git diff
        git config --global user.email "github-action-bot@example.com"
        git config --global user.name "GitHub Action Bot"
        git commit -m "Updated README" -a || echo "No changes to commit"
        git push
```

The script above does the following:

  * Schedules the action to run once a day (or it can be run manually from within GitHub.
  * Ensures the latest content from the GitHub profile repository is checked out.
  * Downloads both SaxonHE (our XSLT processor). The `ubuntu-latest` image includes Java that can easily be used to 
    run XSLTs.
  * Downloads the latest Atom feed from my website.
  * Runs a transformation that generates a `README_END.md` file.
  * Combines the readme start and end files into a single `README.md` file that GitHub will display.
  * Ensures our changes are committed.
  
_Before committing the script make sure to update to for your site._

Now, you can run the action and see that it successfully generates the `README.md` file and commits it into the
repository.