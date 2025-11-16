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

require 'digest/sha2'
require "open3"

module PlantumlHelper
  ALLOWED_FORMATS = {
    'png' => { type: 'png', ext: '.png', content_type: 'image/png', inline: true },
    'svg' => { type: 'svg', ext: '.svg', content_type: 'image/svg+xml', inline: true }
  }.freeze

  def self.construct_cache_key(key)
    ['plantuml', Digest::SHA256.hexdigest(key.to_s)].join('_')
  end

  def self.check_format(frmt)
    ALLOWED_FORMATS.fetch(frmt, ALLOWED_FORMATS['png'])
  end

  def self.plantuml_file(name, extension)
    File.join(Rails.root, 'files', "#{name}#{extension}")
  end

  def self.plantuml(text, args)
    frmt = check_format(args)
    name = construct_cache_key(sanitize_plantuml(text))
    settings_binary = Setting.plugin_plantuml['plantuml_binary_default']
    unless File.file?(plantuml_file(name, '.pu'))
      File.open(plantuml_file(name, '.pu'), 'w') do |file|
        file.write "@startuml\n"
        file.write sanitize_plantuml(text) + "\n"
        file.write '@enduml'
      end
    end
    unless File.file?(plantuml_file(name, frmt[:ext]))
      out, status = Open3.capture2e(
        settings_binary,
        "-charset", "UTF-8",
        "-t", frmt[:type],
        plantuml_file(name, '.pu'),
      )
      unless status.success?
        Rails.logger.error("status: #{status.inspect}")
        raise StandardError, "Failed to run PlantUML"
      end
      Rails.logger.info("out: #{out}")
    end
    name
  end

  def self.sanitize_plantuml(text)
    return text if Setting.plugin_plantuml['allow_includes']
    text.gsub!(/!include.*$/, '')
    text
  end
end
