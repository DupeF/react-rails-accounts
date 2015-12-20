@Record = React.createClass
  getDefaultProps: ->
    record: {}
  render: ->
    React.DOM.tr null,
      React.DOM.td null, dateFormat(@props.record.date)
      React.DOM.td null, @props.record.title
      React.DOM.td null, amountFormat(@props.record.amount)
      React.DOM.td null, @props.record.payer.email
      React.DOM.td null,
        React.DOM.ul
          className: 'list list-unstyled'
          for user in @props.record.users
            React.DOM.li
              key: user.id
              user.email
      React.DOM.td null,
        React.DOM.a
          className: 'btn btn-default'
          href: "#editRecordModal#{@props.record.id}"
          role: 'button'
          'data-toggle': 'modal'
          I18n.t('components.edit')
        React.DOM.a
          className: 'btn btn-danger'
          onClick: @handleDelete
          I18n.t('components.delete')
  handleDelete: (e) ->
    e.preventDefault()
    $.ajax
      method: 'DELETE'
      url: "/records/#{ @props.record.id }"
      dataType: 'JSON'
      success: () =>
        @props.handleDeleteRecord @props.record