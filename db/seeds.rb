User.destroy_all
Course.destroy_all

user = User.create(login: "johnexample", name: "John Example", provider: "github", uid: "1234")

course = Course.create!(
  user: user,
  name: "Example course with screenshot",
  short_description: "Short description of the example course",
  screenshot_url: "https://coursera-course-photos.s3.amazonaws.com/c4/e686907fbf11e3bfb3290ba1eec481/MOOCMap-highres.jpg",
  description: %q{
    # Welcome to the future (of the past)

TimL is a Lisp dialect implemented in and compiling down to VimL, the
scripting language provided by the Vim text editor.  Think Clojure meets VimL.

## Is this a joke?

If you mean the 6,000 lines of working code, then no, I poured hundreds upon
hundreds of very serious hours into that.  But if you're referring to the fact
it's woefully underdocumented, adds considerable overhead to an already slow
host platform, and ultimately unlikely to gain any traction, then yeah,
probably.

## Language features

* Clojure like syntax and API, including everything from rich syntax literals
  to destructuring.
* Namespaces, including `refer` and `alias`.
* `timl.core`, a tiny but growing API resembling `clojure.core`.
* The same persistent collection types and interfaces, including vectors, hash
  maps, hash sets, lists, and lazy sequences.
* Macros, including syntax quoting and the implicit `&form` and `&env`.
* Metadata.  (Some collection types don't support it yet.)
* Reference types, including vars, atoms, futures.
* Extensible type system, including `defmethod` for duck typing.  (This is the
  most significant departure from Clojure.)
* Caching compiler generates real VimL.

## VimL interop

* TimL functions are actually VimL dictionaries (objects) containing a
  dictionary function (method) and a reference to the enclosing scope.
* Defining a symbol `baz` in namespace `foo.bar` actually defines
  `g:foo#bar.baz`.  If that symbol refers to something callable (like a
  function), calling `foo#bar#baz()` on the VimL side will invoke it.
* Arbitrary Vim variables and options can be referred to using VimL notation:
  `b:did_ftplugin`, `v:version`, `&expandtab`. You can also change them with
  `set!`: `(set! &filetype "timl")`.
* `#*function` returns a reference to a built-in or user defined function.
  You can call it like any other function: `(#*toupper "TimL is pretty neat")`.
* Interact with VimL exceptions with `throw`/`try`/`catch`/`finally`.
* Call a Vim command with `execute`: `(execute "wq")`.
* Lisp macros are a wonderful way to encapsulate and hide a lot of the pain
  points of VimL.  The current standard library barely scratches the surface
  here.

## Getting started

If you don't have a preferred installation method, I recommend
installing [pathogen.vim](https://github.com/tpope/vim-pathogen), and
then simply copy and paste:

    cd ~/.vim/bundle
    git clone git://github.com/tpope/timl.git

Once help tags have been generated, you can view the manual with `:help timl`.
There's not a whole lot there, yet.  If you know Clojure, you can probably
guess a bunch of the function names.

Start a repl with `:TLrepl`.  Tab complete is your friend.  The first time may
take several seconds (if your computer is a piece of shit), but compilation is
cached, so subsequent invocations will be super quick, even if Vim is
restarted.

The familiar `ns` macro from Clojure is mostly identical in TimL.
`:refer-clojure` is now `:refer-timl`, which is identical to
`(refer 'timl.core opts)`. `:use` only supports symbol arguments.

    (ns my.ns
      (:refer-timl :exclude [+])
      (:use timl.repl)
      (:require [timl.file :as file]
                [timl.test]))

You can use Clojure's `in-ns`, `require`, `refer`, `alias`, and `use`,
however `use` and `require` are limited to a single argument.

    (in-ns 'my.ns)
    (use 'timl.repl)
    (require 'timl.file)
    (alias 'file 'timl.file)

Put files in `autoload/*.tim` in the runtime path and they will be requirable.

## License

Copyright © Tim Pope.

The use and distribution terms for this software are covered by the [Eclipse
Public License 1.0](http://opensource.org/licenses/eclipse-1.0.php), which can
be found in the file epl-v10.html at the root of this distribution.

By using this software in any fashion, you are agreeing to be bound by the
terms of this license.  You must not remove this notice, or any other, from
this software.
  }
)

Quiz.destroy_all

Question.destroy_all

Answer.destroy_all

quiz = Quiz.create(course: course, name: "Example quiz", short_description: "Example quiz", description: "Example quiz description")

question1 = Question.create(quiz: quiz, content: 'Check a box if and only if it is an accurate description of ML')

Answer.create(question: question1, content: 'Function arguments are evaluated before being passed to functions.', correct: true)
Answer.create(question: question1, content: 'ML is dynamically scoped.', correct: false)
Answer.create(question: question1, content: 'All functions can be called recursively.', correct: false)
Answer.create(question: question1, content: 'Functions are first-class expressions.', correct: true)

question2 = Question.create(quiz: quiz, content: 'Values of the type will hold a person\'s last name.')

Answer.create(question: question2, content: 'int', correct: true)
Answer.create(question: question2, content: 'string', correct: false)
Answer.create(question: question2, content: 'int list', correct: false)
Answer.create(question: question2, content: '(string * int) list', correct: false)
