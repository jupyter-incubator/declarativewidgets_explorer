# Explorer visualization widget for the Jupyter notebook

The [`<urth-viz-explorer>`](https://jupyter-incubator.github.io/declarativewidgets_explorer/#urth-viz-explorer) widget,
based on the [jupyter-incubator/declarativewidgets project](https://github.com/jupyter-incubator/declarativewidgets),
binds a dataframe to a visualization and provides controls to explore the data interactively.  Using an embedded
[`<urth-viz-query>`](https://jupyter-incubator.github.io/declarativewidgets_explorer/#urth-viz-explorer) and
[`<urth-core-dataframe>`](https://jupyter-incubator.github.io/declarativewidgets/#urth-core-dataframe) widgets,
queries are executed against the dataframe on the kernel.  The visualizations are constructed using declarative
[Vega](https://vega.github.io/) JSON grammar.

[![Explorer demonstration](http://img.youtube.com/vi/fJ3hRokI5RA/0.jpg)](http://www.youtube.com/watch?v=fJ3hRokI5RA "Exploring Data with the Declarative Widgets Visualization Explorer")

See the [widget documentation](https://jupyter-incubator.github.io/declarativewidgets_explorer/) for usage details.

## Getting started

Jupyter Declarative Widgets 0.7 or greater is required.  See the [declarativewidgets project](https://github.com/jupyter-incubator/declarativewidgets) for installation details.

Once you have declarativewidgets running in your notebook, you can add an explorer by simply importing and calling the `explore` helper function. This constructs the HTML necessary to create the widget. Here is the necessary code in python, given a dataframe called `df`:

```python
from declarativewidgets import explore
explore(df)
```

Optional second and third parameters to the `explore` function are dicts containing widget properties and bindings, respectively, for example:

```python
explore('trips', properties={'selection-as-object': True}, bindings={'selection': 'trip_sel'})
```

It is also possible to construct an `urth-viz-explorer` instance directly in HTML:

```html
<link rel='import' href='urth_components/declarativewidgets-explorer/urth-viz-explorer.html' is='urth-core-import' package="jupyter-incubator/declarativewidgets_explorer"
<urth-viz-explorer ref="aDataFrame"></urth-viz-explorer>
```

## Developer Installation

1. Clone the repository from github.

1. Make a tarball of the declarativewidgets project (version 0.7 or later) with bower dependencies manually included for the explorer

    `make init; bower install path/to/explorer; make sdist`

1. Copy the tarball from the `dist` directory into the top-level directory of the explorer project, then:

    `make init; make run`

Jupyter will be running on port 8888.

`make tests` assumes that declarativewidgets is installed as a sibling directory to this project
