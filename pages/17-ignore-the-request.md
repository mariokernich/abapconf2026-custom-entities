# Ignore the request? 🤯

## The framework holds you accountable

The framework **tracks** which getters you call. If a request asks for
something you **never read**, it assumes you can't have handled it correctly —
and stops you.

<div class="two-col pt-4">

<div>

### What happens

- 🕵️ FW records every `get_*( )` you call
- ❓ Request wants `$filter`, you never call `get_filter( )`
- 📦 Returned **> page size** rows but never read paging → dump too
- 💥 **Runtime dump** instead of silently wrong data

</div>

<div>

> *"You return data, but you never asked what was requested —
> how could this possibly be right?"*
>
> — the RAP framework, basically

</div>

</div>

<div class="opacity-70 text-sm pt-4">
Better a loud dump now than wrong numbers in production. Consume the request — or explicitly mark it handled.
</div>
