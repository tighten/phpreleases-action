![Release](https://img.shields.io/github/v/release/tighten/phpreleases-action?include_prereleases&style=flat-square)
![Build Status](https://github.com/tighten/phpreleases-action/actions/workflows/main.yml/badge.svg)

# PHP Releases Action
Tired of manually keeping your GitHub actions workflow up to date with the PHP support schedule?  Use this action to generate an array of supported PHP versions for a GitHub Actions matrix. 

By default, this action uses the [PHP Releases API](https://phpreleases.com/) to retrieve the  PHP versions that are currently supported and formats them for a GitHub Actions matrix. Additional versions can be added to the matrix utilizing the `with` parameter. 

## Usage
```yaml
  # This job will need to run before the job that defines the matrix.
  output_releases:
    name: Generate PHP Releases Array
    # Requires a machine that can execute bash and make http requests.
    runs-on: ubuntu-latest
    # Expose the variable for your dependent job.
    outputs:
      range: ${{ steps.releases.outputs.range }}
    steps:
      - name: Fetch Current Releases
        uses: tighten/phpreleases-action@v1
        id: releases
 ```
 
### Create a matrix from the return value
```yaml
  current_php_releases:
    runs-on: ubuntu-latest
    # The matrix cannot be built before the job has finished.
    needs: output_releases
    strategy:
      matrix:
        # GitHub Actions expression to get the return value.
        php: ${{ fromJSON(needs.output_releases.outputs.range) }}
    name: PHP ${{ matrix.php }}
```
A full sample is available in this repo's [.github/workflows directory](https://github.com/tighten/phpreleases-action/blob/main/.github/workflows/main.yml).

Then, refer to the `output_releases` job's output in the `php` line of your matrix strategy, like below:
```yaml
  strategy:
    matrix:
      php: ${{ fromJSON(needs.output_releases.outputs.range) }}
```

### Add PHP versions that are not included by default
```yaml
  # This job will need to run before the job that defines the matrix.
  output_releases:
    name: Generate PHP Releases Array
    # Requires a machine that can execute bash and make http requests.
    runs-on: ubuntu-latest
    # Expose the variable for your dependent job.
    outputs:
      range: ${{ steps.releases.outputs.range }}
    steps:
      - name: Fetch Current Releases
        uses: tighten/phpreleases-action@v1
        id: releases
        with:
          # Comma delimited string of all versions that should be included in the matrix.
          releases: '7.4, 7.3'
```

## Example
```yaml
name: Run Tests

on:
  push:
    branches: [ main ]
  pull_request:

jobs:
  output_releases:
    name: Generate PHP Releases Array
    runs-on: ubuntu-latest
    outputs:
      range: ${{ steps.releases.outputs.range }}
    steps:
      - name: Fetch Current Releases
        uses: tighten/phpreleases-action@v1
        id: releases
        with:
          releases: '7.4'
  tests:
    needs: output_releases
    strategy:
      matrix:
        os: [Ubuntu, Windows, macOS]
        php: ${{ fromJSON(needs.output_releases.outputs.range) }}

        include:
        - os: Ubuntu
          os-version: ubuntu-latest

        - os: Windows
          os-version: windows-latest

        - os: macOS
          os-version: macos-latest

    name: ${{ matrix.os }} - PHP ${{ matrix.php }}

    runs-on: ${{ matrix.os-version }}

    steps:
    - name: Checkout code
      uses: actions/checkout@v1

    - name: Setup PHP
      uses: shivammathur/setup-php@v2
      with:
          php-version: ${{ matrix.php }}
          extensions: posix, dom, curl, libxml, mbstring, zip, pcntl, bcmath, soap, intl, gd, exif, iconv, imagick
```

## Issues
If you need to report an issue or a feature idea, let us know by [opening a GitHub Issue](https://github.com/tighten/phpreleases-action/issues/new).

Thanks for using the PHP releases GitHub Action!

## Contributing
Please see [CONTRIBUTING](CONTRIBUTING.md) for details.

## Credits
- [Alison Kirk](https://github.com/faxblaster)
- [Kristin Collins](https://github.com/krievley)

## Support us
Tighten is a web development firm that works in Laravel, Vue, and React. You can learn more about us on our [web site](https://tighten.com/).

## License
The MIT License (MIT). Please see [License File](LICENSE.md) for more information.
