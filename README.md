# PlantUML Redmine plugin

This plugin will allow adding [PlantUML](http://plantuml.sourceforge.net/) diagrams into Redmine.

Links:

- [Original GitHub repository by dkd](https://github.com/dkd/plantuml)
  - [Original plugin page](https://www.redmine.org/plugins/plantuml) at `redmine.org`
- [**Current project repository**](https://github.com/gemmaro/redmine-plantuml)

## Requirements

- Java
- PlantUML binary

## Installation

- create a shell script in `/usr/bin/plantuml`

```
#!/bin/bash
/usr/bin/java -Djava.io.tmpdir=/var/tmp -Djava.awt.headless=true -jar /PATH_TO_YOUR_PLANTUML_BINARY/plantuml.jar ${@}
```

- copy this plugin into the Redmine plugins directory

## Usage

- go to the [plugin settings page](http://localhost:3000/settings/plugin/plantuml) and add the *PlantUML binary* path `/usr/bin/plantuml`
- PlantUML diagrams can be added as follow:

```
{{plantuml(png)
  Bob -> Alice : hello
}}
```

```
{{plantuml(svg)
  Bob -> Alice : hello
}}
```

- you can choose between PNG or SVG images by setting the `plantuml` macro argument to either `png` or `svg`

## using !include params

Since all files are written out to the system, there is no safe way to prevent editors from using the `!include` command inside the code block.
Therefore every input will be sanitited before writing out the .pu files for further interpretation. You can overcome this by activating the `Setting.plugin_plantuml['allow_includes']`
**Attention**: this is dangerous, since all files will become accessible on the host system.

## Known issues

- PlantUML diagrams are not rendered inside a PDF export, see https://github.com/dkd/plantuml/issues/1

## TODO

- add image caching

## License

As of November 2025, this plugin has changed its license from the **MIT License** to the **GNU Affero General Public License (AGPL v3)**.

- **Older versions (up to commit `f6a6a81`)** remain available under the MIT License.
  Please see `original-LICENSE-by-dkd` file for details.
- **Newer versions** are released under the AGPL v3.

The adoption of AGPL aims to ensure transparency within the open-source community while also encouraging fair contributions from organizations that benefit from this software.

For details, please see the [`COPYING`](./COPYING) file.

```text
Copyright (C) 2025  gemmaro <gemmaro.dev@gmail.com>

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU Affero General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License
along with this program.  If not, see <https://www.gnu.org/licenses/>.
```
