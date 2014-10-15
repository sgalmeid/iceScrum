%{--
- Copyright (c) 2014 Kagilum SAS.
-
- This file is part of iceScrum.
-
- iceScrum is free software: you can redistribute it and/or modify
- it under the terms of the GNU Affero General Public License as published by
- the Free Software Foundation, either version 3 of the License.
-
- iceScrum is distributed in the hope that it will be useful,
- but WITHOUT ANY WARRANTY; without even the implied warranty of
- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- GNU General Public License for more details.
-
- You should have received a copy of the GNU Affero General Public License
- along with iceScrum.  If not, see <http://www.gnu.org/licenses/>.
-
- Authors:
-
- Vincent Barrier (vbarrier@kagilum.com)
- Nicolas Noullet (nnoullet@kagilum.com)
--}%
<g:set var="ownerOrSm" value="${request.scrumMaster || request.owner}"/>
<nav id="header" class="navbar navbar-masthead navbar-default" role="navigation">
    <div class="container-fluid">
        <div class="navbar-header">
            <button type="button" class="pull-left navbar-toggle" onclick="return $.icescrum.toggleSidebar();">
                <span class="sr-only">${message(code:'todo.is.main.menu')}</span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
            <a class="hidden-xs navbar-brand"
               hotkey="{'I': showAbout}"
               hotkey-description="${message(code: 'is.about')}"
               ng-click="showAbout()"
               href>
                <span id="is-logo" class="disconnected" title="${message(code: 'is.about')} (I)"><g:message code="is.shortname"/></span>
            </a>
            <is:errors/>
        </div>
        <div id="mainmenu" ng-controller="projectCtrl">
            <ul class="nav navbar-nav scroll" ui-sortable="menubarSortableOptions">
                <li class="dropdown contextual-menu">
                    <a class="dropdown-toggle">
                        ${pageScope.variables?.space ? pageScope.space.object.name.encodeAsJavaScript() : message(code:'is.projectmenu.title')}&nbsp;<i class="fa fa-caret-down"></i>
                    </a>
                    <ul class="dropdown-menu">
                        <li role="presentation" class="dropdown-header">
                            ${message(code: 'todo.is.projects')}
                        </li>
                        <g:if test="${creationProjectEnable}">
                            <li>
                                <a hotkey="{ 'shift+n': hotkeyClick}"
                                   href="#project/new">
                                    <g:message code="is.projectmenu.submenu.project.create"/> <small class="text-muted">(SHIFT+N)</small>
                                </a>
                            </li>
                        </g:if>
                        <g:if test="${importEnable}">
                            <li>
                                <a hotkey="{ 'shift+i': hotkeyClick}" href="#project/import">
                                    <g:message code="is.projectmenu.submenu.project.import"/> <small class="text-muted">(SHIFT+I)</small>
                                </a>
                            </li>
                        </g:if>
                        <g:if test="${browsableProductsExist}">
                            <li>
                                <a hotkey="{ 'shift+l': hotkeyClick}" href="#project/list">
                                    <g:message code="is.projectmenu.submenu.project.browse"/> <small class="text-muted">(SHIFT+L)</small>
                                </a>
                            </li>
                        </g:if>
                        <g:if test="${product}">
                            <li role="presentation" class="divider"></li>
                            <li role="presentation" class="dropdown-header">
                                ${message(code: 'todo.is.current.project')}
                            </li>
                            <li>
                                <a hotkey="{ 'shift+t': hotkeyClick}" href="#project/members">
                                    <g:message code="is.projectmenu.submenu.project.team"/> <small class="text-muted">(SHIFT+T)</small>
                                </a>
                            </li>
                            <li ng-if="authorizedProject('edit', currentProject)">
                                <a hotkey="{ 'shift+e': hotkeyClick}" href="#project/edit">
                                    <g:message code="is.projectmenu.submenu.project.edit"/> <small class="text-muted">(SHIFT+E)</small>
                                </a>
                            </li>
                            <li ng-if="authorizedProject('edit', currentProject)">
                                <a hotkey="{ 'shift+d': hotkeyClick}" href="#project/practices">
                                    <g:message code="is.projectmenu.submenu.project.editPractices"/> <small class="text-muted">(SHIFT+D)</small>
                                </a>
                            </li>
                            <li ng-if="authorizedProject('delete', currentProject)">
                                <a href ng-click="delete(currentProject)">
                                    <g:message code="is.projectmenu.submenu.project.delete"/>
                                </a>
                            </li>
                            <g:if test="${exportEnable && (request.scrumMaster || request.productOwner)}">
                                <li>
                                    <a hotkey="{ 'shift+d': hotkeyClick}"href="#project/export">
                                        <g:message code="is.projectmenu.submenu.project.export"/> <small class="text-muted">(SHIFT+X)</small>
                                    </a>
                                </li>
                            </g:if>
                        </g:if>
                        <g:if test="${productFilteredsList}">
                            <li role="presentation" class="divider" style='display:${productFilteredsList ?'block':'none'}'></li>
                            <li role="presentation" class="dropdown-header" id="my-projects" style='display:${productFilteredsList ?'block':'none'}'>
                                ${message(code: 'is.projectmenu.submenu.project.my.title')}
                            </li>
                            <g:each var="curProduct" in="${productFilteredsList}">
                                <li class="project">
                                    <a class="${product?.id == curProduct.id ? 'active' : ''}"
                                       href="${product?.id == curProduct.id ? '' : createLink(controller: "scrumOS", params: [product:curProduct.pkey])}/"
                                       title="${curProduct.name.encodeAsHTML()}">
                                       ${curProduct.name.encodeAsHTML()}
                                    </a>
                                </li>
                            </g:each>
                        </g:if>
                        <g:if test="${moreProductsExist}">
                            <li>
                                <a href="${createLink(controller:'project', action:'browse')}" data-ajax="true">
                                    <g:message code="is.projectmenu.submenu.project.more"/>
                                </a>
                            </li>
                        </g:if>
                        <entry:point id="menu-project" model="[curProduct:product,user:user]"/>
                    </ul>
                </li>
                <entry:point id="menu-left" model="[product:product]"/>
                <li class="menubar hidden">&nbsp;</li>
                <g:each in="${menus}" var="menu" status="index">
                    <li ng-class="{active:$state.includes('${menu.id}')}" class="menubar draggable-to-main ${menu.widgetable ? 'draggable-to-widgets' : ''}" id="elem_${menu.id}">
                        <a  hotkey="{ 'ctrl+${index + 1}' : hotkeyClick }"
                            hotkey-description="${message(code:'todo.is.open.view')} ${message(code: menu.title)}"
                            tooltip="${message(code: menu.title)} (CTRL+${index + 1})"
                            tooltip-placement="bottom"
                            href='#/${menu.id}'>
                            <span class="drag text-muted">
                                <i class="fa fa-ellipsis-v"></i>
                            </span>
                            <i class="visible-xs ${menu.icon}"></i><span class="title"> ${message(code: menu.title)}</span></a>
                    </li>
                </g:each>
                <g:if test="${menusHidden}">
                    <li class="dropdown menubar-hidden">
                        <a class="dropdown-toggle" href="#">${message(code:'todo.is.more')} <i class="fa fa-caret-down"></i></a>
                        <ul class="dropdown-menu">
                            <li class="menubar hidden" data-hidden="true">&nbsp;</li>
                            <g:each in="${menusHidden}" var="menu" status="index">
                                <li data-hidden="true" ng-class="{active:$state.includes('${menu.id}')}" class="menubar draggable-to-main ${menu.widgetable ? 'draggable-to-widgets' : ''}" id="elem_${menu.id}">
                                    <a  hotkey="{ 'ctrl+${index + menus.size() + 1}' : hotkeyClick }"
                                        hotkey-description="${message(code:'todo.is.open.view')} ${message(code: menu.title)}"
                                        tooltip-placement="left"
                                        tooltip="${message(code: menu.title)} (CTRL+${index + menus.size() + 1})"
                                        href='#/${menu.id}'>
                                        <span class="drag text-muted">
                                            <span class="glyphicon glyphicon-th"></span>
                                            <span class="glyphicon glyphicon-th"></span>
                                        </span>
                                        <i class="visible-xs ${menu.icon}"></i><span class="title"> ${message(code: menu.title)}</span></a>
                                </li>
                            </g:each>
                        </ul>
                    </li>
                </g:if>
            </ul>
            <entry:point id="menu-right" model="[curProduct:curProduct]"/>
            <div class="navbar-right">
                <g:if test="${product}">
                    <form class="navbar-form pull-left" role="search">
                        <div class="input-group">
                            <input type="text" class="form-control" placeholder="${message(code:'todo.is.ui.search')}">
                            <span class="input-group-btn">
                                <button class="btn btn-primary" type="button"><span class="glyphicon glyphicon-search"></span></button>
                            </span>
                        </div>
                    </form>
                    <!-- Todo remove, user role change for dev only -->
                    <div style="padding: 13px" class="pull-left" ng-if="false">
                        <a ng-class="{ 'text-warning': roles.productOwner && roles.scrumMaster }" ng-click="changeRole('PO_SM')">PO_SM</a>
                        <a ng-class="{ 'text-warning': roles.productOwner && (!roles.scrumMaster) }" ng-click="changeRole('PO')">PO</a>
                        <a ng-class="{ 'text-warning': roles.scrumMaster && (!roles.productOwner) }" ng-click="changeRole('SM')">SM</a>
                        <a ng-class="{ 'text-warning': roles.teamMember }" ng-click="changeRole('TM')">TM</a>
                        <a ng-class="{ 'text-warning': roles.stakeHolder }" ng-click="changeRole('SH')">SH</a>
                    </div>
                </g:if>
                <div ng-if="currentUser.username"
                     data-toggle="dropdown"
                     class="navbar-user pull-left dropdown-toggle">
                    <img ng-src="{{ currentUser | userAvatar }}" height="32px" width="32px"/>
                </div>
                <div ng-if="currentUser.username" class="panel panel-default dropdown-menu" id="panel-current-user">
                    <div class="panel-body">
                        <img ng-src="{{ currentUser | userAvatar }}" height="60px" width="60px" class="pull-left"/>
                        {{ currentUser.username }}
                        <g:if test="${product}">
                            <br/>
                            <a href="javascript:;" onclick="$('#edit-members').find('a').click();"><strong> <is:displayRole product="${product.id}"/> </strong></a>
                        </g:if>
                    </div>
                    <div class="panel-footer">
                        <div class="row">
                            <div>
                                <a class="btn btn-info"
                                   hotkey="{'U':showProfile}"
                                   tooltip="${message(code:'is.dialog.profile')} (U)"
                                   tooltip-append-to-body="true"
                                   ng-click="showProfile()">${message(code:'is.dialog.profile')}</a>
                            </div>
                            <div>
                                <a class="btn btn-danger" href="${createLink(controller:'logout')}">${message(code:'is.logout')}</a>
                            </div>
                        </div>
                    </div>
                </div>
                <button id="login"
                        ng-show="!(currentUser.username)"
                        class="btn btn-primary"
                        hotkey="{'L':showAuthModal}"
                        ng-click="showAuthModal()"
                        hotkey-description="${message(code:'is.button.connect')}"
                        tooltip="${message(code:'is.button.connect')} (L)"
                        tooltip-append-to-body="true"
                        tooltip-placement="bottom"><g:message code="is.button.connect"/></button>
            </div>
        </div>
    </div>
</nav>