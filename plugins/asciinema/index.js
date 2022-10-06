// Checks all cast files for glyphes and bundles a custom font for the production build
// based on https://www.tonylykke.com/posts/2018/06/18/custom-fonts-in-asciinema/

// type options = {
//   output_dir: String,
//   font_name: String,
// }

module.exports = function(_, options) {
  var fs = require('fs');
  var subsetFont = require('subset-font');

  let castsFolder = ''
  let castChars = new Set();
  let sourceFont = ''

  function getCasts() {
    let files = fs.readdirSync(castsFolder);
    return files.filter(file => file.endsWith('.cast'));
  }

  function addCharsFromCast(path) {
    fs.readFileSync(path).toString()
      .split("\n")
      .forEach((line, index, arr) => {
        if (index === arr.length - 1 && line === "")
          return;

        let json_line = JSON.parse(line);

        if (!Array.isArray(json_line))
          return;

        if (json_line.length != 3) {
          console.log('Custom Terminal font: Unexpected number of array elements: ' + json_line + "\n");
          return;
        }

        for (let char of json_line[2]) {
          castChars.add(char);
        }
      });
  }

  async function createFont() {
    for (let file of getCasts()) {
      addCharsFromCast(castsFolder + "/" + file);
    }

    // Exclude ascii chars (0-127)
    for (let i = 0; i < 128; i++) {
      castChars.delete(String.fromCharCode(i));
    }

    // Exclude whitespace, fonts don't register these characters so
    // leaving them in here will break fontTools.subset
    castChars = new Set([...castChars].filter(c => c !== ' '));

    const sourceBuffer = Buffer.from(fs.readFileSync(sourceFont));
    return await subsetFont(sourceBuffer, [...castChars].join(''));
  }
  return {
    name: 'asciinema-font',
    async loadContent() {
      castsFolder = options.casts_folder || 'static/casts';
      font_name = options.font_name || 'glyphs.ttf';
      sourceFont = options.source_font;

      if (!sourceFont) {
        throw new Error('Custom Terminal font: Missing source font');
      }

      const font = await createFont();
      fs.writeFileSync("static/fonts/" + font_name, font);

      console.log("Created glyphs font.");
    }
  }
}
