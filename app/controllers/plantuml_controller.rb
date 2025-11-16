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

class PlantumlController < ApplicationController
  unloadable

  def convert
    frmt = PlantumlHelper.check_format(params[:content_type])
    filename = params[:filename]
    send_file(PlantumlHelper.plantuml_file(filename, frmt[:ext]), type: frmt[:content_type], disposition: frmt[:inline])
  end
end
