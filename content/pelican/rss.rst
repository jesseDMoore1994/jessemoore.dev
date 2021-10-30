RSS Support now enabled!
########################

:tags: Pelican
:date: 2021-10-30
:lang: en
:slug: rss

Visit the feeds directory!
**************************

One of my friends Morgan was talking to me about this website yesterday and he prefers to read this type of content
using an RSS reader. I don't really use RSS so it wasn't part of my initial deployment as it had not crossed my mind.

Pelican to the Rescue! I am now producing atom feeds at the path ``/feeds``.


`<https://jessemoore.dev/feeds>`_


Pelican Configuration to make it possible
*****************************************

The configuration of this feature was actually very trivial, all I had to do was adjust my ``pelicanconf.py`` to
include the following:

.. code-block:: python3

  FEED_ALL_ATOM = 'feeds/all.atom.xml'
  CATEGORY_FEED_ATOM = 'feeds/{slug}.atom.xml'

I hope your RSS reader supports Atom feeds Morgan! If not, there are some additional pure RSS settings I can mess with.
