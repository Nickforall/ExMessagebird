# ExMessagebird

⚠ This is a prerelease, newer prereleases might have breaking changes and not everything has been unit- or integration-tested.

- [Documentation](https://hexdocs.pm/ex_messagebird/ExMessagebird.html)
- [Hex](https://hex.pm/packages/ex_messagebird)

Please don't use, this is in development still but published on github because a project needed it.

## Config

```elixir
config :ex_messagebird,
  token: "YOUR API TOKEN",
  originator: "ExMessagebird"
```

## Testing

You can use the [InMemory](https://hexdocs.pm/ex_messagebird/ExMessagebird.Backend.InMemory.html) backend to list the payloads sent to `send_message`.
Additionaly you can implement a `Mox` Mock with the `ExMessagebird.Backend.Behaviour` behavior.

```elixir
config :ex_messagebird,
  backend: ExMessagebird.Backend.InMemory,
  originator: "ExMessagebird"
```
