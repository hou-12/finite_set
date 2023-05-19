Install the **finite_set** package
=====================================

|cmake| |Documentation Status|

Installation
------------

Install *finite_set* using the bash commands:

.. code-block:: shell-session

    $ git clone https://github.com/hou-12/finite_set.git
    $ cd finite_set
    $ git submodule add https://github.com/hou-12/inversion-list.git  finite_set/c-inversion-list
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

Test *finite_set* using the bash commands:

.. code-block:: shell-session

    $ poetry run tox
    $ poetry run tox -e style
    $ poetry run tox -e linter


.. |cmake| image:: https://github.com/hou-12/finite_set/actions/workflows/python-package.yml/badge.svg
   :target: https://github.com/hou-12/finite_set/actions
.. |Documentation Status| image:: https://img.shields.io/readthedocs/finite_set.svg
   :target: http://finite_set.readthedocs.io/en/latest/?badge=latest
