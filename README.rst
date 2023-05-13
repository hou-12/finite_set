Install the **finite-set** package
=====================================

|cmake| |Documentation Status|

Installation
------------

Install *finite-set* using the bash commands:

.. code-block:: shell-session

    $ git clone https://github.com/hou-12/finite-set.git
    $ cd finite-set
    $ git submodule update --init --recursive
    $ poetry install --with docs

Building
--------

Build *finite-set* using the bash commands:

.. code-block:: shell-session

    $ poetry build
    $ ls dist

Documentation
-------------

Build the documentation using the bash commands:

.. code-block:: shell-session

    $ poetry run sphinx-build docs/ build/sphinx/html/

Testing
-------

Test *finite-set* using the bash commands:

.. code-block:: shell-session

    $ poetry run tox
    $ poetry run tox -e style
    $ poetry run tox -e linter


.. |cmake| image:: https://github.com/hou-12/finite-set/actions/workflows/python-package.yml/badge.svg
   :target: https://github.com/hou-12/finite-set/actions
.. |Documentation Status| image:: https://img.shields.io/readthedocs/finite-set.svg
   :target: http://finite-set.readthedocs.io/en/latest/?badge=latest
