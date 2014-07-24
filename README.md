# Design Patterns in Ruby
---

This project has detailed sample code (with my modification) for each pattern in the book [Design Patterns in Ruby](http://designpatternsinruby.com/). 
I also add important notes as comments. 

## Short summary of each pattern

- *Template Pattern*: Build an abstract base class with a skeletal method. This skeletal method (also called a template method) drives the bit of the processing that needs to vary, but it does so by making calls to abstract methods, which are then supplied by the concrete subclasses. 
- *Strategy Pattern*: Define a family of objects, the strategies, which all do the same thing. Not only does each strategy object perform the same job, but all of the objects support exactly the same interface.
- *Observer Pattern*: Create a clean interface between the source of the news (the observable object) and the consumer of that news (the observers), the Observer pattern moves the news without tangling things up. Ruby has a module [Observable](http://ruby-doc.org/stdlib-2.0.0/libdoc/observer/rdoc/Observable.html)
