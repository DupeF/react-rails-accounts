@Groups = React.createClass
  getInitialState: ->
    groups: @props.data
  getDefaultProps: ->
    groups: []
  render: ->
    React.DOM.div
      className: 'groups'
      React.DOM.h2
        className: 'title'
        'Groups'
      React.DOM.ul
        className: 'list-unstyled'
        for group in @state.groups
          React.DOM.a
            href: '/groups/' + group.id
            group.name