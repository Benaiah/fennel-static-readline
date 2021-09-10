(include :cURL.impl.cURL)
(local curl (require :cURL))
(local view (require :fennelview))

(fn request [url]
  (let [out []
        headers ["User-Agent: Fennel example"]]
    (with-open [h (curl.easy {: url
                              :httpheader headers
                              :writefunction {:write #(table.insert out $2)}})]
      (h:perform))
    (table.concat out "\n")))

(match arg
  [url] (print (request url))
  _ (print (request "https://httpbin.org/get")))
