Overview of the parts
===

Checkout is the main entry point representing the checkout action,
it receives a product list and the discount rules and glues it all
together.

The Cart is a simple class responsible for holding the current
desired (scanned) products, it doesn't have information about
discounts, only about the items included in itself.

Discounts is a list of the discounts that are applicable to that
checkout process, it receives a list of rules and transform them
into applicable discounts. It can also return the discount amount
after applying all the discounts to a specific cart.

Product is the representation of a product with its identifier and
price.

Products embodies the list of individual products that exist in the
store. Ideally it would save and retrieve those items from a data
store, but for this simple example, the products definition is in a
file. It is also responsible for finding specific products,
matching and translating a scanned code (like "MUG") into an actual
product reference.


Notable things about the design
===
By design, the cart doesn't know about discounts and anything more complex
related to the final price, there are two ways to go about that, we could
add the discounts to the cart as line items or apply it at the end.
Although adding the discount to the cart might've been desirable depending on
the circumstances, it would add more complexity to the solution by forcing us
to recalculate the discounts after each item was added or removed from the cart.
This simpler approach of calculating the discount value and subtracting it from
the total separately was simpler and was enough to fulfill the problem proposal.

Each discount only works on one product at a time, that means we can't add cross
product discounts (for example buy two shirts, get a mug for free), I created the
discounts in a way that it would not be too complex to add that, but the added
complexity was not necessary given the problem proposal.

Discounts used a switch to create discounts, that is okay for the current problem
proposal because we have few discount types, but could get too big/complex
if we had several different types of discounts and that logic would have to be
revisited and the branching replaced by polymorphism.

Improvement options
===

The YAML store for discount rules and prices would be one of the first things to
outgrow when evolving this application, moving to a proper datastore wouldn't be
complex (basically using the Products class to implement searching and saving on
the data store).

I refrained from using external libraries for the solution, that is why there is
no Gemfile here. If I added a data store I would most probably use docker to run
the application + the data store simultaneously (and isolate the environment).
