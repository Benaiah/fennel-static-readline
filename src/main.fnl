(local options {:plugins []})

(fn try-readline [ok readline]
  (when ok
    (when readline.set_readline_name
      (readline.set_readline_name :fennel))
    (readline.set_options {:keeplines 1000 :histfile ""})

    (fn options.readChunk [parser-state]
      (let [prompt (if (< 0 parser-state.stack-size) ".. " ">> ")
            str (readline.readline prompt)]
        (if str (.. str "\n"))))

    (var completer nil)

    (fn options.registerCompleter [repl-completer]
      (set completer repl-completer))

    (fn repl-completer [text from to]
      (if completer
          (do
            (readline.set_completion_append_character "")
            (completer (text:sub from to)))
          []))

    (readline.set_complete_function repl-completer)
    readline))

(let [readline (try-readline (pcall #(require :lua-readline)))]
  ((. (require :fennel) :repl) options))
