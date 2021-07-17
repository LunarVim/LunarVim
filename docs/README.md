<!-- # Hello LunarVim 🍝 -->
<!-- --- -->
<!-- lang: en-US -->
<!-- title: Title of this page -->
<!-- description: Description of this page -->
<!-- --- -->

<!-- ![LunarVim Logo](/assets/lunarvim_logo.png) -->

<img :src="$withBase('/assets/lunarvim_logo.png')" alt="VuePress Logo">

# Landing Page

[[toc]]
<!-- relative path -->
[Home](../README.md)  
[Config Reference](../reference/config.md)  
[Getting Started](./getting-started.md)  
<!-- absolute path -->
[Guide](/guide/README.md)  
[Config Reference > markdown.links](/reference/config.md#links)  
<!-- URL -->
[GitHub](https://github.com)  

```ts{1,6-8}
import type { UserConfig } from '@vuepress/cli'

export const config: UserConfig = {
  title: 'Hello, VuePress',

  themeConfig: {
    logo: 'https://vuejs.org/images/logo.png',
  },
}
```
<video width="560" height="240" controls>
  <source src="https://sample-videos.com/video123/mp4/480/big_buck_bunny_480p_1mb.mp4" type="video/mp4">
  Your browser does not support the video tag.
</video> 

asdf


## this title


asdf

|asdfasdf


::: tip [info]
[content]
:::

<!-- tip -->
<!-- warning -->
<!-- danger -->
<!-- details -->
<!-- codeGroup -->
<!-- codeGroupItem -->
