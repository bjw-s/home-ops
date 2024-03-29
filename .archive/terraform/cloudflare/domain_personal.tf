module "cf_domain_personal" {
  source     = "./modules/cf_domain"
  domain     = "bjws.nl"
  account_id = cloudflare_account.bjw_s.id

  dns_entries = [
    {
      name  = "ipv4"
      value = local.home_ipv4
    },
    # Generic settings
    {
      name  = "_dmarc"
      value = "v=DMARC1; p=quarantine;"
      type  = "TXT"
    },
    # Migadu settings
    {
      id       = "migadu_mx_1"
      name     = "@"
      priority = 10
      value    = "aspmx1.migadu.com"
      type     = "MX"
    },
    {
      id       = "migadu_mx_2"
      name     = "@"
      priority = 20
      value    = "aspmx2.migadu.com"
      type     = "MX"
    },
    {
      id      = "migadu_dkim_1"
      name    = "key1._domainkey"
      value   = "key1.bjws.nl._domainkey.migadu.com."
      type    = "CNAME"
      proxied = false
    },
    {
      id      = "migadu_dkim_2"
      name    = "key2._domainkey"
      value   = "key2.bjws.nl._domainkey.migadu.com."
      type    = "CNAME"
      proxied = false
    },
    {
      id      = "migadu_dkim_3"
      name    = "key3._domainkey"
      value   = "key3.bjws.nl._domainkey.migadu.com."
      type    = "CNAME"
      proxied = false
    },
    {
      id    = "migadu_spf"
      name  = "@"
      value = "v=spf1 include:spf.migadu.com -all"
      type  = "TXT"
    },
    {
      id    = "migadu_verification"
      name  = "@"
      value = "hosted-email-verify=b938qnjb"
      type  = "TXT"
    },
  ]

  waf_custom_rules = [
    {
      enabled     = true
      description = "Firewall rule to block bots and threats determined by CF"
      expression  = "(cf.client.bot) or (cf.threat_score gt 14)"
      action      = "block"
    },
    {
      enabled     = true
      description = "Firewall rule to block certain countries"
      expression  = "(ip.geoip.country in {\"CN\" \"IN\" \"KP\" \"RU\"})"
      action      = "block"
    },
  ]
}
