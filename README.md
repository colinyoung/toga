# toga

#### a todo-list for git

## Installation

Toga is a rubygem.

	gem install toga

----

## Usage

	$ mate Togafile
	
	
A sample Togafile looks like:

	CURRENT
	
	Finish serialization methods
	Write better regexes
	Resolve issue #205
	
	
	LATER
	
	Use cloud database for production instead of local redis server

This is simply your todo list. `CURRENT` marks things you are working on right now; `LATER` marks things you want to finish in the near future; and `COMPLETED` obviously marks done tasks.

Let's say we want to finish the first task on the list:

	$ toga complete Finish seria
	
(You don't need to type the whole line, just the first part.)

This will stage a git commit with your commit already set to your todo's text; you can then add more to your commit message, of course!

Now, check your `Togafile`:

  $ toga list

	CURRENT
	
	Write better regexes
	Resolve issue #205
	[x] Finish serialization methods # => completed at 2:06pm today
	
	LATER
	
	Use cloud database for production instead of local redis server
	
By default, completed tasks are left in the current list so that you can feel awesome about them. If you want, you can clean the `current` Todos:

	$ toga clean
	
We can use toga to push commits, too, if you want:

	$ toga push
	
This will move done tasks to the `completed` group:

	CURRENT
	
	Write better regexes
	Resolve issue #205
	
	LATER
	
	Use cloud database for production instead of local redis server
	
	COMPLETED
	[x] Finish serialization methods # => completed at 2:06pm today, http://github.com/colinyoung/toga/commits/abc939499cb…
	
It also provides a link to the git project and the commit ref so that you can see how you completed your task.

VOILA!
	