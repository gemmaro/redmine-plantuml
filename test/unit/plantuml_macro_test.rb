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

require File.expand_path('../../test_helper', __FILE__)

class PlantumlMacroTest < ActionController::TestCase
  include ApplicationHelper
  include ActionView::Helpers::AssetTagHelper
  include ERB::Util

  def setup
    Setting.plugin_plantuml['plantuml_binary_default'] = ENV['REDMINE_PLANTUML_EXECUTABLE'] || '/usr/bin/plantuml'
  end

  def test_plantuml_macro_with_png
    text = <<-RAW
{{plantuml(png)
Bob -> Alice : hello
}}
RAW
    assert_include '/plantuml/png/plantuml_88358e9331985a8ad4ec566b38dfd68a2875ead47b187542e2bea02c670d50ff.png', textilizable(text)
  end

  def test_plantuml_macro_with_svg
    text = <<-RAW
{{plantuml(svg)
Bob -> Alice : hello
}}
RAW
    assert_include '/plantuml/svg/plantuml_88358e9331985a8ad4ec566b38dfd68a2875ead47b187542e2bea02c670d50ff.svg', textilizable(text)
  end

end
