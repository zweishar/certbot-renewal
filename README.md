This is a small wrapper to allow for automated renewal of a letsencrypt certificate. Certbot is capable of renewing your certificate for you automatically out of the box, but only if you install it on a running server. If you own a static site, this won't help you.

Prerequsites:
- [Install Certbot](https://certbot.eff.org/)
- Manage your DNS through Cloudflare
- A computer capable of running bash scripts and scheduling cron jobs

Setup:
- `git clone git@github.com:zweishar/certbot-renewal.git`
- `mkdir .cloudflare-secrets`
- `cd .cloudflare-secrets`
- `echo your-cloudflare-api-key > .api-key`
- `echo your-cloudflare-email > .email`
- Set up a cron job to execute this script (example used on Mac OS):
    - `env crontab -e`
    - Add a line with: `0 12 * * * cd /path/to/root-of-this-repo && /path/to/certbot certonly --config .certbot/cli.ini --email your-email@example.com -d your-domain.com`

With the example cron job, this script will be run everyday at noon. Letsencrypt certs only need to be renewed every 90 days, but if you computer isn't turned on when the cron job is supposed to run, than it won't until the next scheduled window.

If you want certbot to interact properly with certificates created by this script, you can pass the config flag from the above cron job. For example, checking the expiration date of your certificates would look like this:
`certbot certificates --config /path/to/root-of-this-repo/.certbot/cli.ini`

The meat of these scripts come from the [letsencrypt docs](http://letsencrypt.readthedocs.io/en/latest/using.html). Thanks to them for putting together such great documentation in addition to building such a killer utility.
