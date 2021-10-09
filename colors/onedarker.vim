" Author: Christian Chiarulli <chrisatmachine@gmail.com>

lua << EOF
package.loaded['onedarker'] = nil
package.loaded['onedarker.highlights'] = nil
package.loaded['onedarker.Treesitter'] = nil
package.loaded['onedarker.markdown'] = nil
package.loaded['onedarker.Whichkey'] = nil
package.loaded['onedarker.Git'] = nil
package.loaded['onedarker.LSP'] = nil

require("onedarker")
EOF
