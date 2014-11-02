NOTES
=====

A Hydrator is responsible for inflating a type into a Task::Template type, if possible. A Task::Template will be basically a no-op. :-)

A Catalog is responsible for knowing what sort of Task::Instance types this Consumer is familiar with.

A Resolver is responsible for instantiating a Task::Template into a Task::Instance.

Open Question: Where do we want to wrap a Task::Instance into a Task. A Resolver doesn't seem like the right place.

Instance is a stupid name for the specific code behind a task; it's way too
ambiguous. Find a better name, plz.
