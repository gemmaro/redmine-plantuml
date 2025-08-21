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

class PlantumlControllerTest < ActionController::TestCase
  def setup
    @request.session[:user_id] = 1
    Setting.default_language = 'en'

    PlantumlHelper.singleton_class.prepend(Module.new do
      def plantuml_file(name, extension)
        File.open(File.expand_path("../../fixtures/files/#{name}#{extension}", __FILE__), mode='r')
      end
    end)
  end

  def test_convert_with_svg
    get :convert, params: { content_type: 'svg', filename: 'plantuml_0c40679fe8cc7b2f654444c35ff1ab7ba53a28768f7f89b9c457d500b76f5590' }
    assert_response :success
    assert_equal 'image/svg+xml', @response.content_type
  end

  def test_convert_with_png
    get :convert, params: { content_type: 'png', filename: 'plantuml_0c40679fe8cc7b2f654444c35ff1ab7ba53a28768f7f89b9c457d500b76f5590' }
    assert_response :success
    assert_equal 'image/png', @response.content_type
  end

  def test_convert_default_with_png
    get :convert, params: { content_type: 'jpeg', filename: 'plantuml_0c40679fe8cc7b2f654444c35ff1ab7ba53a28768f7f89b9c457d500b76f5590' }
    assert_response :success
    assert_equal 'image/png', @response.content_type
  end

end
