/**
 * Copyright (C) 2025  gemmaro <gemmaro.dev@gmail.com>
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU Affero General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU Affero General Public License for more details.
 *
 * You should have received a copy of the GNU Affero General Public License
 * along with this program.  If not, see <https://www.gnu.org/licenses/>.
 */

/**
 * Extend the jsToolBar function to add the plantUML buttons to editor toolbar.
 * Needs to run after the jsToolbar function is defined and before toolbars are drawn
 *
 * The position cannot be set (see http://www.redmine.org/issues/14936 )
 */
if (typeof(jsToolBar) != 'undefined') {
    jsToolBar.prototype.elements.plantuml = {
        type: 'button',
        title: 'Add PlantUML diagramm',
        fn: {
            wiki: function () {
                // this.singleTag('{{plantuml(png)\n', '\n}}');
                this.encloseLineSelection('{{plantuml(png)\n', '\n}}')
            }
        }
    }
} else {
    throw 'could not add plantUML button to Toolbar. jsToolbar is undefined';
}
