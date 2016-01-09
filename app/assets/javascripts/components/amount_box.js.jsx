var AmountBox = React.createClass({
  render: function() {
    return (
      <div className = 'col-md-4'>
        <div className = {'panel panel-'+this.props.type}>
          <div className= 'panel-heading'>
            {this.props.text}
          </div>
          <div className = 'panel-body'>
            <ul className = 'list list-unstyled'>
              <li>
                {I18n.t('components.amount_box.this_page', {amount: amountFormat(this.props.page_amount)})}
              </li>
              <li>
                {I18n.t('components.amount_box.total', {amount: amountFormat(this.props.total_amount)})}
              </li>
            </ul>
          </div>
        </div>
      </div>
    );
  }
});
