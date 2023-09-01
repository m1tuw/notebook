#import "template.typ": *

#show: project.with()

#let extract_code(contents) = {
  return contents.split("- */\n").at(-1)
}
#let extract_metadata(contents) = {
  return toml.decode(contents.split("- */\n").at(0).replace("/* -\n", ""))
}

#let insert(filename) = {
  let contents = read(filename)
  let metadata = extract_metadata(contents)
  return [
    #block[
      #v(-0.5em)
      #heading(metadata.name)
      #v(0.25em)
      #if metadata.info.keys().len() == 0 {
        v(-0.75em)
      }
      #block(
        for (key, value) in metadata.info {
          text(key + ": ", weight: "bold")
          eval(value, mode: "markup")
          linebreak()
        }
      )
    ]
    #raw(extract_code(contents), lang: "cpp", block: true)
    #v(0.5em)
    #line(length: 100%, stroke: 0.2pt)
  ]
}

#insert("template.h")
#insert("hashmap.h")
#insert("kmp.h")
#insert("order_statistic_tree.h")