fs = require 'fs-extra'
path = require 'path-extra'

{Provider} = require 'react-redux'
{createStore} = require 'redux'
arApp = require './reducers'

store = createStore arApp

{React, ReactDOM, ReactBootstrap, $, ROOT, __, translate, CONST} = window
{Tabs, Tab, Label} = ReactBootstrap
{log, warn, error} = require path.join(ROOT, 'lib/utils')

APIResolver = require './api-resolver'

apiResolver = new APIResolver(store)

AkashicLog = require './akashic-records-log'
AkashicResourceLog = require './akashic-resource-log'
AkashicAdvancedModule = require './containers/advanced-module'

$('#font-awesome')?.setAttribute 'href', require.resolve('font-awesome/css/font-awesome.css')

# getUseItem: (id)->
#   switch id
#     when 10
#       "家具箱（小）"
#     when 11
#       "家具箱（中）"
#     when 12
#       "家具箱（大）"
#     when 50
#       "応急修理要員"
#     when 51
#       "応急修理女神"
#     when 54
#       "給糧艦「間宮」"
#     when 56
#       "艦娘からのチョコ"
#     when 57
#       "勲章"
#     when 59
#       "給糧艦「伊良湖」"
#     when 62
#       "菱餅"
#     else
#       "特殊的东西"

AkashicRecordsArea = React.createClass
  getInitialState: ->
    mapShowFlag: false
    selectedKey: 0
    warning: ''
  handleResponse: (e) ->
    @setState
      warning: e.detail.warning
  componentDidMount: ->
    apiResolver.start()

  componentWillUnmount: ->
    apiResolver.stop()

  handleSelectTab: (selectedKey)->
    if selectedKey is 5
      @setState
        mapShowFlag: true
        selectedKey: selectedKey
    else
      @setState
        mapShowFlag: false
        selectedKey: selectedKey

  render: ->
    <div>
      <div  style={'fontSize': 18}>
        <Label bsStyle="danger">{@state.warning}</Label>
      </div>
      <Tabs activeKey={@state.selectedKey} animation={false} onSelect={@handleSelectTab}>
        <Tab eventKey={0} title={__ "Sortie"} ><AkashicLog contentType={CONST.typeList.attack}/></Tab>
        <Tab eventKey={1} title={__ "Expedition"} ><AkashicLog contentType={CONST.typeList.mission}/></Tab>
        <Tab eventKey={2} title={__ "Construction"} ><AkashicLog contentType={CONST.typeList.createShip}/></Tab>
        <Tab eventKey={3} title={__ "Development"} ><AkashicLog contentType={CONST.typeList.createItem}/></Tab>
        <Tab eventKey={4} title={__ "Retirement"} ><AkashicLog contentType={CONST.typeList.retirement}/></Tab>
        <Tab eventKey={5} title={__ "Resource"} ><AkashicResourceLog mapShowFlag={@state.mapShowFlag}/></Tab>
        <Tab eventKey={6} title={__ "Others"} ><AkashicAdvancedModule /></Tab>
      </Tabs>
    </div>

ReactDOM.render(
  <Provider store={store}>
    <AkashicRecordsArea />
  </Provider>,
  $('akashic-records')
)
