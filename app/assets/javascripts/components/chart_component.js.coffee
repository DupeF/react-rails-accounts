@ChartComponent = React.createClass
  getDefaultProps: ->
    type: ''
    data: []
    options: {}
  getInitialState: ->
    chart: null
  render: ->
    React.DOM.canvas null
  componentWillReceiveProps: (nextProps) ->
    if @state.chart != null
      @state.chart.destroy()
    @setState chart: @drawChart(nextProps)
  drawChart: (props) ->
    if props == null
      props = @props
    canvas = React.findDOMNode(this)
    ctx = canvas.getContext("2d");
    switch props.type
      when 'doughnut' then (new Chart(ctx).Doughnut(props.data, props.options))
      when 'line' then (new Chart(ctx).Line(props.data, props.options))
      when 'bar' then (new Chart(ctx).Bar(props.data, props.options))
      else null
