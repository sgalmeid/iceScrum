<form ng-submit="update(editableSprint)"
      name='formHolder.sprintForm'
      ng-class="{'form-editable': formEditable(), 'form-editing': formHolder.editing }"
      show-validation
      novalidate>
    <div class="panel-body">
        <div class="clearfix no-padding">
            <div class="form-half">
                <label for="sprint.startDate">${message(code:'is.sprint.startDate')}</label>
                <div ng-class="{'input-group': authorizedSprint('updateStartDate', sprint)}">
                    <input type="text"
                           class="form-control"
                           required
                           ng-focus="editForm(true)"
                           name="sprint.startDate"
                           ng-disabled="!authorizedSprint('updateStartDate', sprint)"
                           ng-model="editableSprint.startDate"
                           ng-model-options="{timezone: 'utc'}"
                           uib-datepicker-popup
                           datepicker-options="startDateOptions"
                           is-open="startDateOptions.opened"/>
                    <span class="input-group-btn"
                          ng-if="authorizedSprint('updateStartDate', sprint)">
                        <button type="button"
                                class="btn btn-default"
                                ng-focus="editForm(true)"
                                ng-click="openDatepicker($event, startDateOptions)">
                            <i class="fa fa-calendar"></i>
                        </button>
                    </span>
                </div>
            </div>
            <div class="form-half">
                <label for="sprint.endDate">${message(code:'is.sprint.endDate')}</label>
                <div ng-class="{'input-group': authorizedSprint('updateEndDate', sprint)}">
                    <input type="text"
                           class="form-control"
                           required
                           ng-focus="editForm(true)"
                           name="sprint.endDate"
                           ng-disabled="!authorizedSprint('updateEndDate', sprint)"
                           ng-model="editableSprint.endDate"
                           ng-model-options="{timezone: 'utc'}"
                           uib-datepicker-popup
                           datepicker-options="endDateOptions"
                           is-open="endDateOptions.opened"/>
                    <span class="input-group-btn"
                          ng-if="authorizedSprint('updateEndDate', sprint)">
                        <button type="button"
                                class="btn btn-default"
                                ng-focus="editForm(true)"
                                ng-click="openDatepicker($event, endDateOptions)">
                            <i class="fa fa-calendar"></i>
                        </button>
                    </span>
                </div>
            </div>
        </div>
        <div class="chart"
             ng-controller="chartCtrl"
             ng-init="openChart('sprint', 'burnupTasks', sprint)">
            <div uib-dropdown
                 ng-controller="projectChartCtrl"
                 class="pull-right">
                <div class="btn-group visible-on-hover">
                    <button class="btn btn-default btn-sm"
                            ng-click="openChartInModal(chartParams)"
                            type="button">
                        <i class="fa fa-search-plus"></i>
                    </button>
                    <button class="btn btn-default btn-sm"
                            ng-click="saveChart(chartParams)"
                            type="button">
                        <i class="fa fa-floppy-o"></i>
                    </button>
                </div>
                <button class="btn btn-default btn-sm"
                        uib-tooltip="${message(code:'todo.is.ui.charts')}"
                        type="button"
                        uib-dropdown-toggle>
                    <i class="fa fa-bar-chart"></i> <i class="fa fa-caret-down"></i>
                </button>
                <ul uib-dropdown-menu>
                    <li ng-repeat="chart in projectCharts.sprint"><a href ng-click="openChart('sprint', chart.id, sprint)">{{ message(chart.name) }}</a></li>
                </ul>
            </div>
            <nvd3 options="options | merge: {chart:{height: 200}, title:{enable: false}}" data="data"></nvd3>
        </div>
        <div class="form-group">
            <label for="deliveredVersion">${message(code:'is.sprint.deliveredVersion')}</label>
            <input name="deliveredVersion"
                   ng-focus="editForm(true)"
                   ng-model="editableSprint.deliveredVersion"
                   type="text"
                   ng-maxlength="255"
                   class="form-control"
                   placeholder="${message(code: 'todo.is.ui.sprint.nodeliveredversion')}"/>
        </div>
        <div class="form-group" ng-if="sprint.state > sprintStatesByName.IN_PROGRESS">
            <label for="retrospective">${message(code: 'is.sprint.retrospective')}</label>
            <textarea is-markitup
                      class="form-control"
                      name="retrospective"
                      ng-model="editableSprint.retrospective"
                      is-model-html="editableSprint.retrospective_html"
                      ng-show="showRetrospectiveTextarea"
                      ng-blur="showRetrospectiveTextarea = false"
                      placeholder="${message(code: 'todo.is.ui.sprint.noretrospective')}"></textarea>
            <div class="markitup-preview important"
                 ng-disabled="!formEditable()"
                 ng-show="!showRetrospectiveTextarea"
                 ng-click="showRetrospectiveTextarea = formEditable()"
                 ng-focus="editForm(true); showRetrospectiveTextarea = formEditable()"
                 ng-class="{'placeholder': !editableSprint.retrospective_html}"
                 tabindex="0"
                 ng-bind-html="editableSprint.retrospective_html ? editableSprint.retrospective_html : '<p>${message(code: 'todo.is.ui.sprint.noretrospective')}</p>'"></div>
        </div>
        <div class="form-group">
            <label for="goal">${message(code:'is.sprint.goal')}</label>
            <textarea name="goal"
                      class="form-control important"
                      ng-focus="editForm(true)"
                      ng-disabled="!formEditable()"
                      ng-maxlength="5000"
                      ng-model="editableSprint.goal"
                      placeholder="${message(code: 'todo.is.ui.sprint.nogoal')}"></textarea>
        </div>
        <div class="form-group">
            <label for="doneDefinition">${message(code: 'is.sprint.doneDefinition')}</label>
            <textarea is-markitup
                      class="form-control"
                      name="doneDefinition"
                      ng-model="editableSprint.doneDefinition"
                      is-model-html="editableSprint.doneDefinition_html"
                      ng-show="showDoneDefinitionTextarea"
                      ng-blur="showDoneDefinitionTextarea = false"
                      placeholder="${message(code: 'todo.is.ui.sprint.nodonedefinition')}"></textarea>
            <div class="markitup-preview important"
                 ng-disabled="!formEditable()"
                 ng-show="!showDoneDefinitionTextarea"
                 ng-click="showDoneDefinitionTextarea = formEditable()"
                 ng-focus="editForm(true); showDoneDefinitionTextarea = formEditable()"
                 ng-class="{'placeholder': !editableSprint.doneDefinition_html}"
                 tabindex="0"
                 ng-bind-html="editableSprint.doneDefinition_html ? editableSprint.doneDefinition_html : '<p>${message(code: 'todo.is.ui.sprint.nodonedefinition')}</p>'"></div>
        </div>
        <div class="form-group">
            <label>${message(code:'is.backlogelement.attachment')} {{ sprint.attachments_count > 0 ? '(' + sprint.attachments_count + ')' : '' }}</label>
            <div ng-if="authorizedSprint('upload', sprint)"
                 ng-controller="attachmentNestedCtrl">
                <button type="button"
                        class="btn btn-default"
                        flow-btn>
                    <i class="fa fa-upload"></i> ${message(code: 'todo.is.ui.new.upload')}
                </button>
                <entry:point id="attachment-add-buttons"/>
            </div>
            <div class="form-control-static" ng-include="'attachment.list.html'">
            </div>
        </div>
    </div>
    <div class="panel-footer" ng-if="formHolder.editing">
        <div class="btn-toolbar">
            <button class="btn btn-primary"
                    ng-if="isLatest() || formHolder.submitting"
                    ng-disabled="!isDirty() || formHolder.sprintForm.$invalid || formHolder.submitting"
                    type="submit">
                ${message(code:'default.button.update.label')}
            </button>
            <button class="btn btn-danger"
                    ng-if="!isLatest() && !formHolder.submitting"
                    ng-disabled="!isDirty() || formHolder.sprintForm.$invalid"
                    type="submit">
                ${message(code:'default.button.override.label')}
            </button>
            <button class="btn btn-default"
                    type="button"
                    ng-click="editForm(false)">
                ${message(code:'is.button.cancel')}
            </button>
            <button class="btn btn-warning"
                    type="button"
                    ng-if="!isLatest() && !formHolder.submitting"
                    ng-click="resetSprintForm()">
                <i class="fa fa-warning"></i> ${message(code:'default.button.refresh.label')}
            </button>
        </div>
    </div>
</form>