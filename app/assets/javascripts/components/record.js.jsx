var Record = React.createClass({
  getDefaultProps: function() {
    return  {
      record: {}
    };
  },
  render: function() {
    return (
      <tr>
        <td>{dateFormat(this.props.record.date)}</td>
        <td>{this.props.record.title}</td>
        <td>{amountFormat(this.props.record.amount)}</td>
        <td>{this.props.record.payer.email}</td>
        <td>
          <ul className = 'list list-unstyled'>
            {this.props.record.users.map(function(user) {
              return (<li key = {user.id}>{user.email}</li>);
            })}
          </ul>
        </td>
        <td>
          <a className = 'btn btn-default'
             href = {"#editRecordModal"+this.props.record.id}
             role = 'button'
             data-toggle = 'modal'>{I18n.t('components.edit')}</a>
          <a className = 'btn btn-danger'
             onClick = {this.handleDelete}>{I18n.t('components.delete')}</a>
        </td>
      </tr>
    );
  },
  handleDelete: function(e) {
    e.preventDefault();
    $.ajax({
      method: 'DELETE',
      url: "/records/"+this.props.record.id,
      dataType: 'JSON',
      success: (function() {
        this.props.handleDeleteRecord(this.props.record);
      }).bind(this)
    });
  }
});
