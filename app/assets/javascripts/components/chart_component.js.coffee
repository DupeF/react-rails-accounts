@ChartComponent = React.createClass
  getDefaultProps: ->
    name: ''
    params: {}
  getInitialState: ->
    chart: null
  render: ->
    React.DOM.canvas null
  componentDidMount: ->
    @loadChart()
  loadChart: ->
    $.get @request_path(), @props.params, ((data) ->
      if @state.chart != null
        @state.chart.destroy()
      @setState chart: @drawChart data.chart_type, data.formatted_data, data.options
      ).bind(this)
  drawChart: (type, data, options) ->
    canvas = React.findDOMNode(this)
    ctx = canvas.getContext("2d");
    switch type
      when 'doughnut' then (new Chart(ctx).Doughnut(data, options))
      when 'line' then (new Chart(ctx).Line(data, options))
      when 'bar' then (new Chart(ctx).Bar(data, options))
      else null
  request_path: ->
    '/charts/'+@props.name
