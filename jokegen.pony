use "collections"
use "net/http"
use "json"

actor Main
  new create(env: Env) =>
    HTTPClient(env.root as AmbientAuth).get("https://official-joke-api.appspot.com/random_joke", JokeHandler)

class JokeHandler is HTTPHandler
  fun ref apply(response: HTTPResponse ref) =>
    try
      let json = JsonDoc.parse(String.from_array(response.body))?.data as JsonObject
      let setup = json.data("setup") as JsonString
      let punch = json.data("punchline") as JsonString
      @printf[I32]("%s - %s\n".cstring(), setup.string().cstring(), punch.string().cstring())
    else
      @printf[I32]("Xatolik\n".cstring())
    end
