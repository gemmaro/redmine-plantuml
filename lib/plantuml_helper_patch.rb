# Copyright (C) 2025  gemmaro <gemmaro.dev@gmail.com>
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU Affero General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU Affero General Public License for more details.
#
# You should have received a copy of the GNU Affero General Public License
# along with this program.  If not, see <https://www.gnu.org/licenses/>.

require_dependency 'redmine/wiki_formatting/textile/helper'

module PlantumlHelperPatch
  def self.included(base) # :nodoc:
    base.send(:prepend, HelperMethodsWikiExtensions)

    base.class_eval do
      unloadable # Send unloadable so it will not be unloaded in development
      if Rails.version < '5.0.0'
        alias_method_chain :heads_for_wiki_formatter, :redmine_plantuml
      else
        alias_method :heads_for_wiki_formatter_without_redmine_plantuml, :heads_for_wiki_formatter
        alias_method :heads_for_wiki_formatter, :heads_for_wiki_formatter_with_redmine_plantuml
      end
    end
  end
end

module HelperMethodsWikiExtensions
  # extend the editor Toolbar for adding a plantuml button
  # overwrite this helper method to have full control about the load order
  def heads_for_wiki_formatter_with_redmine_plantuml
    heads_for_wiki_formatter_without_redmine_plantuml

    unless @heads_for_wiki_plantuml_included
      content_for :header_tags do
        javascript_include_tag('jstoolbar/jstoolbar-textile.min') +
            javascript_include_tag("jstoolbar/lang/jstoolbar-#{current_language.to_s.downcase}") +
            stylesheet_link_tag('jstoolbar') +
            javascript_include_tag('plantuml.js', plugin: 'plantuml') +
            stylesheet_link_tag('plantuml.css', plugin: 'plantuml')
      end
      @heads_for_wiki_plantuml_included = true
    end
  end
end
