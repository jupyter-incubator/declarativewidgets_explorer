# Explorer visualization widget for the Jupyter notebook

The `<urth-viz-explorer>` tag, based on the jupyter-incubator/declarativewidgets project, binds data to a visualization
and provides UI controls to explore the data set.

The data abstraction is a dataframe, passed in either with the name of a kernel variable as the `ref` attribute,
or using the [`<urth-core-dataframe>`](http://jupyter-incubator.github.io/declarativewidgets/docs.html#urth-core-dataframe) abstraction
as a child element, wrapped in an `<urth-viz-query>` element to provide the ability to do interactive queries of the data set
on the kernel.

See `urth-viz-explorer.ipynb` for examples.

## Installation

`make init; make run`