# PHP Releases Action
Generates an array of supported PHP releases for use within a GitHub Actions matrix.

## Usage
Within your workflow `jobs` block, add the following job _before_ your matrix job:
```yaml
  output_releases:
    name: Generate PHP Releases Array
    runs-on: ubuntu-latest
    steps:
      - name: Fetch Current Releases
        uses: tighten/phpreleases-action@v1
        id: releases
```
If you need to add specific versions to the matrix statically (to ensure they're included regardless of current support), add them as a comma separated list with the `releases` key:
```yaml
  output_releases:
    name: Generate PHP Releases Array
    runs-on: ubuntu-latest
    steps:
      - name: Fetch Current Releases
        uses: tighten/phpreleases-action@v1
        id: releases
        with:
          releases: '7.4, 7.3'
```

A full sample is available in this repo's [.github/workflows directory](https://github.com/tighten/phpreleases-action/blob/main/.github/workflows/main.yml).

Then, refer to the `output_releases` job's output in the `php` line of your matrix strategy, like below:
```yaml
  strategy:
    matrix:
      php: ${{ fromJSON(needs.output_releases.outputs.range) }}
```

You can implement additional matrix values (os or laravel versions, for example), as well as include/exclude combinations [as you normally would with a matrix](https://docs.github.com/en/actions/using-jobs/using-a-matrix-for-your-jobs).

## Issues
If you encounter any issues in the implementation of this workflow, or have feature ideas, feel free to [open a github issue](https://github.com/tighten/phpreleases-action/issues/new).

Thanks for using the PHP releases github action!

## Contributing
Please see [CONTRIBUTING](CONTRIBUTING.md) for details.

## Credits
- [Alison Kirk](https://github.com/faxblaster)
- [Kristin Collins](https://github.com/krievley)

## Support us
Tighten is a web development firm that works in Laravel, Vue, and React. You can learn more about us on our [web site](https://tighten.com/).

## License
The MIT License (MIT). Please see [License File](LICENSE.md) for more information.
