CLI RPN Calculator
==================

Implement a command-line reverse polish notation (RPN) calculator using a language that you know well.

Imaginary Context
-----------------

We're building this command-line calculator for people who are comfortable with UNIX-like CLI utilities.
We are starting with the basic 4 operators now but will want to eventually implement other operators and
an alternate interface (such as WebSocket, file, or TCP socket).
There's no need to implement these, but design with these future changes in mind.

Solution structure
-----------------
- The class `RpnCalculator` is a generic implementation of a calculator using RPN. It can be reused by different clients if additional are added.
- `ConsoleInputProcessor` is an abstraction that allows to easily test how console input is going to be handled. Testing the script directly is much more complex.
- `ConsoleInputParser` is an abstraction that provides general utilities for parsing input. If new clients are added this can become more generic and change it's name if relevant.
- `calculator.rb` file is the ruby script that starts the calculator, it is quite slim since all the heavy lifting was moved to the ruby classes. 
- `calculator.rb`, Like any ruby script, can be exited with `CTRL + c` or `CTRL + d`. Besides that it will recognize `q` as the exit command.

Install dependecies
--------------------

To install the dependencies navigate to the project directory
```
> gem install bundler
> bundle install
```

Start using
--------------------

To start using navigate to the project directory and run `calculator.rb`

```
ruby calculator.rb
```

Run tests
--------------------

To run tests navigate to the project directory and run:
```
# for all tests
> rake test 

# for a single test file
> ruby tests/file_i_want_to_test
```

Limitations
--------------------
- The only operations supported are sum (`+`), subtraction (`-`), multiplication (`*`) and division (`/`)
- Division by 0 exception is not controlled and will store `"Infinity"` in memo, making subsequent operations fail.
- when the input is a single term, either and operand or an operator, it will try to be added to it's corresponding group, for example:
```
> 1
> 1
> 1
> -
> 1
> + +

# Will  be equivalent to: "1 1 1 1 - + +" and not to "1 1 1 - 1 + +"
# making the input procesable instead of raising an error
````

Example Input/Output
--------------------

Use your best judgment as far as the format is concerned, as long as it makes sense to the end user. Your calculator should at the minimum handle the following examples. 

    > 5 
    5
    > 8
    8
    > +
    13

---

    > 5 5 5 8 + + -
    -13.0
    > 13 +
    0.0

---

    > -3
    -3.0
    > -2
    -2.0
    > *
    6.0
    > 5
    5.0
    > +
    11.0

---

    > 5
    5
    > 9
    9
    > 1
    1
    > -
    8
    > /
    0.625
