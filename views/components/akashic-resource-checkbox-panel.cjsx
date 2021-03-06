{React, ReactBootstrap, jQuery} = window
{Panel, Button, Col, Input, Grid, Row, ButtonGroup} = ReactBootstrap

AkashicResourceCheckboxArea = React.createClass
  handleClickCheckbox: (index) ->
    {tabVisibility} = @props
    tmp = tabVisibility.toArray()
    tmp[index] = not tmp[index]
    config.set "plugin.Akashic.#{@props.contentType}.checkbox", JSON.stringify tmp
    @props.onCheckboxClick index, tmp[index]

  render: ->
    <div className='akashic-records-settings'>
      <Grid className='akashic-records-filter'>
        <Row>
        {
          for checkedVal, index in @props.tableTab.toArray()
            continue if index < 2
            <Col key={index} xs={2}>
              <Input
                type='checkbox'
                value={index}
                onChange={@handleClickCheckbox.bind(@, index)}
                checked={@props.tabVisibility.get index}
                style={verticalAlign: 'middle'}
                label={checkedVal} />
            </Col>
        }
        </Row>
      </Grid>
    </div>

module.exports = AkashicResourceCheckboxArea
