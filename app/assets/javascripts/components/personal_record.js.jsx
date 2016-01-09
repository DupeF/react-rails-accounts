var PersonalRecord = React.createClass({
  getInitialState: function() {
    return {
      edit: false
    };
  },
  handleToggle: function(e) {
    e.preventDefault();
    this.setState({edit: !this.state.edit});
  },
  render: function() {
    if (this.state.edit) {
      return this.recordForm();
    } else {
      return this.recordRow();
    }
  },
  recordRow: function() {
    return (
      <tr>
        <td>{dateFormat(this.props.record.date)}</td>
        <td>{this.props.record.title}</td>
        <td>{amountFormat(this.props.record.amount)}</td>
        <td>
          <a className = 'btn btn-default'
             onClick = {this.handleToggle}>{I18n.t('components.edit')}</a>
          <a className = 'btn btn-danger'
             onClick = {this.handleDelete}>{I18n.t('components.delete')}</a>
        </td>
      </tr>
    );
  },
  recordForm: function() {
    return (
      <tr>
        <td>
          <input className = 'form-control'
                 type = 'text'
                 data-provide = 'datepicker'
                 defaultValue = {dateFormat(this.props.record.date)}
                 ref = 'date' />
        </td>
        <td>
          <input className = 'form-control'
                 type = 'text'
                 defaultValue = {this.props.record.title}
                 ref = 'title' />
        </td>
        <td>
          <input className = 'form-control'
                 type = 'text'
                 defaultValue = {this.props.record.amount}
                 ref = 'amount' />
        </td>
        <td>
          <a className = 'btn btn-default'
             onClick = {this.handleEdit}>{I18n.t('components.update')}</a>
          <a className = 'btn btn-danger'
             onClick = {this.handleToggle}>{I18n.t('components.cancel')}</a>
        </td>
      </tr>
    );
  },
  handleEdit: function(e) {
    e.preventDefault();
    var data = {
      title: React.findDOMNode(this.refs.title).value,
      date: React.findDOMNode(this.refs.date).value,
      amount: React.findDOMNode(this.refs.amount).value
    };
    $.ajax({
      method: 'PUT',
      url: "/personal_records/"+this.props.record.id,
      dataType: 'JSON',
      data: { personal_record: data },
      success: (function(data) {
        this.setState({edit: false});
        this.props.handleEditRecord(data, this.props.record);
      }).bind(this)
    });
  },
  handleDelete: function(e) {
    e.preventDefault();
    $.ajax({
      method: 'DELETE',
      url: "/personal_records/"+this.props.record.id,
      dataType: 'JSON',
      success: (function(data) {
        this.props.handleDeleteRecord(data);
      }).bind(this)
    });
  }
});
