<script type="text/ng-template" id="tasks.panel.html">
    <div class="panel panel-light" ng-controller="userTaskCtrl">
        <div class="panel-heading" as-sortable-item-handle>
            <h3 class="panel-title"><i class="fa fa-tasks"></i> ${message(code: 'is.panel.mytask')}</h3>
        </div>
        <div class="panel-body">
            <div ng-repeat="entry in tasksByProject">
                <h5>
                    {{ entry.project.name }}
                    <button type="button"
                            class="pull-right btn btn-xs btn-default"
                            ng-click="$event.stopPropagation(); openProject(entry.project)"
                            uib-tooltip="${message(code:'todo.is.ui.project.open')}"
                            tooltip-append-to-body="true"
                            tooltip-placement="top">
                        <span class="fa fa-expand"></span>
                    </button>
                </h5>
                <uib-accordion>
                    <uib-accordion-group ng-repeat="task in entry.tasks">
                        <uib-accordion-heading>
                            <button class="btn btn-xs btn-default ng-binding" disabled="disabled">{{ task.uid }}</button>
                            {{ task.name }}
                        </uib-accordion-heading>
                        <table>
                            {{ task }}
                            <tr><td>${message(code: 'is.task.estimation')} {{ task.estimation }}</td></tr>
                            <tr><td>${message(code: 'is.task.state')} {{task.state | i18n:'TaskStates' }}</td></tr>
                            <tr><td>${message(code: 'is.backlogelement.description')} {{ task.description }}</td></tr>
                            <tr><td>${message(code: 'is.task.creator')} {{ task.creator }}</td></tr>
                            <tr><td>${message(code: 'is.story')} {{ task.parentStory.name }}</td></tr>
                            <tr><td>${message(code: 'is.task.type')} {{ task.type }}</td></tr>
                            <tr><td>${message(code: 'is.sprint')} {{ task.parentSprint.name }}</td></tr>
                        </table>
                    </uib-accordion-group>
                </uib-accordion>
            </div>
        </div>
    </div>
</script>