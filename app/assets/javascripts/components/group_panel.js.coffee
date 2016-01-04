@GroupPanel = React.createClass
  render: ->
    React.DOM.li
      className: 'dashboard-entry'
      React.DOM.a
        href: '/groups/'+@props.group.id
        React.DOM.div
          className: 'panel panel-default dashboard-panel'
          React.DOM.div
            className: 'panel-body dashboard-panel-body'
            React.DOM.span
              className: 'dashboard-panel-title'
              @props.group.name
