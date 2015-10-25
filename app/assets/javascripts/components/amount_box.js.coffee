@AmountBox = React.createClass
  render: ->
    React.DOM.div
      className: 'col-md-4'
      React.DOM.div
        className: "panel panel-#{@props.type}"
        React.DOM.div
          className: 'panel-heading'
          @props.text
        React.DOM.div
          className: 'panel-body'
          React.DOM.ul
            className: 'list list-unstyled'
            React.DOM.li null,
              I18n.t('components.amount_box.this_page', amount: amountFormat(@props.page_amount))
            React.DOM.li null,
              I18n.t('components.amount_box.total', amount: amountFormat(@props.total_amount))
