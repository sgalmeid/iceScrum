<script type="text/ng-template" id="mood.panel.html">
    <div class="panel panel-light">
        <div class="panel-heading" as-sortable-item-handle>
            <h3 class="panel-title"><i class="fa fa-smile-o"></i> ${message(code: 'is.panel.mood')}</h3>
        </div>
        <div class="panel-body" ng-controller="moodCtrl">
            <div ng-switch="alreadySavedToday">
                <div ng-switch-default>
                    <table>
                        ${message(code: 'is.panel.mood.day')}
                        <tr>
                            <td><button ng-click="save('GOOD')" uib-tooltip="${message(code: 'is.panel.mood.good')}" class="fa fa-smile-o fa-5x"></button></td>
                            <td><button ng-click="save('MEH')" uib-tooltip="${message(code: 'is.panel.mood.meh')}" class="fa fa-meh-o fa-5x"></button></td>
                            <td><button ng-click="save('BAD')" uib-tooltip="${message(code: 'is.panel.mood.bad')}" class="fa fa-frown-o fa-5x"></button></td>
                        </tr>
                    </table>
                </div>
                <div ng-switch-when="true">
                    <table ng-repeat="mood in moods">
                        <tr><td>${message(code: 'is.panel.mood.feeling')} {{mood.feeling | i18n:'MoodFeelings'}}</td>
                        </tr>
                    </table>
                    <div ng-controller="moodChartCtrl">
                        <div class="panel-body">
                            <nvd3 options="options" data="data"></nvd3>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</script>